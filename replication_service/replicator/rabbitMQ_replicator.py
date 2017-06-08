# This file is used to publish binlogstream events to a rabbitMQ instance
# @author Indika Maligaspe
# @Date 26th May 2017


import pika
import logging
import os
import yaml
import sys
import base64
import cPickle

from time import sleep
import mysql.connector
from pymysql.charset import charset_to_encoding

from pymysqlreplication import BinLogStreamReader
from pymysqlreplication.row_event import(
    DeleteRowsEvent,
    WriteRowsEvent,
    UpdateRowsEvent
)
from pymysqlreplication.event import (
    QueryEvent,
    RotateEvent
)

from pymysqlreplication.constants import FIELD_TYPE


MYSQL_SETTING = {
    "host": "192.168.50.4",
    "port": 3306,
    "user": "indika",
    "passwd": "123456"
}

RABBITMQ_SETTINGS = {}

persist_file = os.getcwd()+'/persist.log'
logger = logging.getLogger()


def main():
    log_position = 4
    get_configs()
    start_binlograder(log_position)


def get_configs():
    config_file = sys.argv[1]
    with open(config_file, 'r') as yfile:
        doc = yaml.load(yfile)
        MYSQL_SETTING['host']=str(doc['mysql_master']['host'])
        MYSQL_SETTING['port']=int(doc['mysql_master']['port'])
        MYSQL_SETTING['user']=str(doc['mysql_master']['user'])
        MYSQL_SETTING['passwd']=str(doc['mysql_master']['passwd'])
        persist_file=doc['logs']['persist_log']
        log4py_file=doc['logs']['log4py']['path']
        log4py_log_level=doc['logs']['log4py']['log_level']
        RABBITMQ_SETTINGS['host']=str(doc['rabbitMQ']['host'])
        RABBITMQ_SETTINGS['passwd']=str(doc['rabbitMQ']['passwd'])
        RABBITMQ_SETTINGS['user']=str(doc['rabbitMQ']['user'])

        if log4py_log_level == 'DEBUG':
            log_level = logging.DEBUG
        elif log4py_log_level == 'INFO':
            log_level = logging.INFO
        elif log4py_log_level == 'WARN':
            log_level = logging.WARN
        elif log4py_log_level == 'ERROR':
            log_level = logging.ERROR

    logging.basicConfig(filename=log4py_file,level=log_level)


def start_binlograder(log_position):
    print MYSQL_SETTING['passwd']
    log_file , log_position = get_latest_master_log_file(persist_file)
    credentials = pika.PlainCredentials(RABBITMQ_SETTINGS['user'],RABBITMQ_SETTINGS['passwd'])
    connection  = pika.BlockingConnection(pika.ConnectionParameters(host=RABBITMQ_SETTINGS['host'],credentials=credentials))
    channel = connection.channel()
    queue = 'alienvault_replicate'
    channel.queue_declare(queue=queue,durable=True)
    while True:
        logger.debug('Log position - %s' %(log_position))
        stream = BinLogStreamReader(
            connection_settings=MYSQL_SETTING,
            resume_stream=True,
            log_file=log_file,
            server_id=1,
            blocking = True,
            log_pos=log_position,
            only_events=[DeleteRowsEvent, WriteRowsEvent, UpdateRowsEvent,QueryEvent,RotateEvent])
        logger.debug('stream.log_pos -> %s' %(stream.log_pos))
        logger.debug('stream.log_file -> %s' %(stream.log_file))
        for binlogevent in stream:
            logger.debug('stream.log_pos -> %s' %(stream.log_pos))
            if stream.log_pos >= log_position:
                logger.debug('Inside Stream position - %s and log position %s' %(stream.log_pos,log_position))
                if isinstance(binlogevent,QueryEvent):
                    schema = binlogevent.schema
                    prefix = "%s: " %(schema)
                    query = str(binlogevent.query)
                    logger.debug ('Query Event - %s' %(query))
                    if "create table".upper() in query.upper():
                        logger.debug ('Create SQL - %s' %(query))
                        dataset = {}
                        dataset['table']= table
                        dataset['schema'] = schema
                        dataset['type'] = 'create'
                        dataset['query'] = query
                        push_mesage(channel,dataset,queue)
                        log_position = stream.log_pos
                    elif "drop table".upper() in query.upper():
                        logger.debug ('Drop SQL - %s' %(query))
                        dataset = {}
                        dataset['table']= table
                        dataset['schema'] = schema
                        dataset['type'] = 'drop'
                        dataset['query'] = query
                        push_mesage(channel,dataset,queue)
                        log_position = stream.log_pos
                elif isinstance(binlogevent,RotateEvent):
                    logger.info("RotateEvent fired... calling update_new_master_log_file...")
                    update_new_master_log_file(persist_file)
                    log_file , log_position = get_latest_master_log_file(persist_file)
                    stream.log_pos = log_position
                    stream.log_file = log_file
                    logger.debug('Rotate Event log_pos -> %s' %(log_position))
                    logger.debug('Rotate Event log_file -> %s' %(log_file))
                else:
                    schema = binlogevent.schema
                    for row in binlogevent.rows:
                            table = binlogevent.table
                            columns = binlogevent.columns


                            if isinstance(binlogevent,DeleteRowsEvent):
                                dataset = {}
                                dataset['table']= table
                                dataset['schema'] = schema
                                dataset['type'] = 'delete'
                                dataset['values'] = row["values"]
                                dataset['cols'] = get_columns(columns)
                                push_mesage(channel,dataset,queue)
                                log_position = stream.log_pos
                            elif isinstance(binlogevent,UpdateRowsEvent):
                                dataset = {}
                                dataset['table']= table
                                dataset['schema'] = schema
                                dataset['type'] = 'update'
                                dataset['after_values'] = row["after_values"]
                                dataset['before_values'] = row["before_values"]
                                dataset['cols'] = get_columns(columns)
                                push_mesage(channel,dataset,queue)
                                log_position = stream.log_pos
                            elif isinstance(binlogevent,WriteRowsEvent):
                                vals = row["values"]
                                dataset = {}
                                dataset['table']= table
                                dataset['schema'] = schema
                                dataset['type'] = 'insert'
                                dataset['values'] = vals
                                dataset['cols'] = get_columns(columns)
                                push_mesage(channel,dataset,queue)
                                log_position = stream.log_pos
                log_position = stream.log_pos
            logger.info( "Event loop end log position -> %s" %(log_position))
            persist(log_file, log_position,persist_file)
        sleep(10)
    stream.close()
    connection.close();


def push_mesage(channel,message,key):
    channel.basic_publish(exchange='',
        routing_key  = key,
        body = cPickle.dumps(message),
        properties=pika.BasicProperties(
            delivery_mode = 2, #make message persistant
        )
    )
    return True

def get_columns(columns):
    cols = []
    for column in columns:
        cols.append(column.name)
    return cols

def prepare_where_clause(set_vals,columns):
    where = []
    i=0
    for keys in set_vals:
        column = check_field_types(set_vals[columns[i].name],columns[i])
        where.append(columns[i].name+'= '+column)
        i+=1
    return where


def prepare_update_clause(set_vals,columns):
    update = []
    i=0
    for keys in set_vals:
        column = check_field_types(set_vals[keys],columns[i])
        update.append(' '+keys+'= '+column)
        i+=1
    return update


def prepare_insert_values(set_vals,columns):
    insert = {}
    insert_cols = ''
    insert_vals = ''
    i=0
    for keys in set_vals:
        column = check_field_types(set_vals[keys],columns[i])
        insert_cols = insert_cols + keys+','
        if type(column) == 'str':
            insert_vals = insert_vals + (str('%s' %(column.decode(charset_to_encoding(character_set_name))))+',')
        else:
            insert_vals = insert_vals + (str('%s' %(column))+',')
        i+=1
    # insert['cols'] = insert_cols
    # insert['vals'] = insert_vals
    return insert_cols , insert_vals


def check_field_types(column_value,column):
    if None == column.character_set_name:
        character_set_name = 'latin1'
    else:
        character_set_name = column.character_set_name

    logger.debug(type(column_value))
    if type(column_value) == 'str':
        logger.debug ('column name - %s , column value - %s , column type %s' %(column.name, column_value.decode(charset_to_encoding(character_set_name)),column.type))
    # else:
    # logger.debug ('column name - %s , column value - %s , column type %s' %(column.name, column_value,column.type))


    column_str = None

    if column.type == FIELD_TYPE.TINY:
        column_str = column_value
    elif column.type == FIELD_TYPE.SHORT:
        column_str = column_value
    elif column.type == FIELD_TYPE.LONG:
        column_str = column_value
    elif column.type == FIELD_TYPE.INT24:
        column_str = column_value
    elif column.type == FIELD_TYPE.FLOAT:
        column_str = column_value
    elif column.type == FIELD_TYPE.DOUBLE:
        column_str = column_value
    elif column.type == FIELD_TYPE.VARCHAR or \
            column.type == FIELD_TYPE.STRING:
        column_str = column_value.decode(charset_to_encoding(character_set_name))
        # column_str = ('%s' %(column_value))

    elif column.type == FIELD_TYPE.NEWDECIMAL:
        # column_str = '\''+str(column_value)+'\''
        column_str = ('%s' %(column_value))
    elif column.type == FIELD_TYPE.BLOB:
        column_str = column_value.decode(charset_to_encoding(character_set_name))
        # column_str = ('%s' %(column_value))
    elif column.type == FIELD_TYPE.DATETIME:
        # column_str = '\''+str(column_value)+'\''
        column_str = ('%s' %(column_value))
    elif column.type == FIELD_TYPE.TIME:
        # column_str = '\''+str(column_value)+'\''
        column_str = ('%s' %(column_value))
    elif column.type == FIELD_TYPE.DATE:
        # column_str = '\''+str(column_value)+'\''
        column_str = ('%s' %(column_value))
    elif column.type == FIELD_TYPE.TIMESTAMP:
        # vcolumn_str = '\''+str(column_value)+'\''
        column_str = ('%s' %(column_value))

    # For new date format:
    elif column.type == FIELD_TYPE.DATETIME2:
        # column_str = '\''+str(column_value)+'\''
        column_str = ('%s' %(column_value))
    elif column.type == FIELD_TYPE.TIME2:
        # column_str = '\''+str(column_value)+'\''
        column_str = ('%s' %(column_value))
    elif column.type == FIELD_TYPE.TIMESTAMP2:
        # column_str = '\''+str(column_value)+'\''
        column_str = ('%s' %(column_value))
    elif column.type == FIELD_TYPE.LONGLONG:
        # column_str = '\''+str(column_value)+'\''
        column_str = ('%s' %(column_value))
    elif column.type == FIELD_TYPE.YEAR:
        # column_str = '\''+str(column_value)+'\''
        column_str = ('%s' %(column_value))
    elif column.type == FIELD_TYPE.ENUM:
        # column_str = '\''+str(column_value)+'\''
        column_str = ('%s' %(column_value))
    elif column.type == FIELD_TYPE.SET:
        # We read set columns as a bitmap telling us which options
        # are enabled
        # column_str = '\''+str(column_value)+'\''
        column_str = ('%s' %(column_value))

    elif column.type == FIELD_TYPE.BIT:
        # column_str = 'b\''+str(column_value)+'\''
        column_str = ('%s' %(column_value))
    elif column.type == FIELD_TYPE.GEOMETRY:
        # column_str = '\''+str(column_value)+'\''
        column_str = ('%s' %(column_value))
    elif column.type == FIELD_TYPE.JSON:
        # column_str = '\''+str(column_value)+'\''
        column_str = ('%s' %(column_value))
    else:
        logger.error("Unknown MySQL column type: %d" %
                                  (column.type))
    return column_str



def get_latest_master_log_file(persist_file):
    if(os.path.isfile(persist_file)):
        log_file,log_position = get_master_log_and_postion_from_persist(persist_file)
    else:
        log_file,log_position = update_new_master_log_file(persist_file)
    return log_file , log_position


def update_new_master_log_file(persist_file):
    connection = None
    log_file = '0'
    try:
        connection = mysql.connector.connect(user=MYSQL_SETTING['user'], password=MYSQL_SETTING['passwd'],
                                  host=MYSQL_SETTING['host'],
                                  database='alienvault')

        cursor = connection.cursor()
        cursor.execute("SHOW MASTER STATUS")
        for rows in cursor:
            log_file = rows[0]
            log_position = 4
        cursor.close()
        connection.close()
        logger.debug('New Persist file -> %s, Log Position -> %d' %(log_file,log_position))
        persist(log_file,log_position,persist_file)
    except mysql.connector.errors as mysqlerror:
        logger.error(mysqlerror.message)
    finally:
        if None != connection:
            connection.close()
    return log_file,log_position


def get_master_log_and_postion_from_persist(persist_file):
    log_file = ''
    log_position = 4
    try:
        file = open(persist_file, 'r')
        persiste_entries = file.readline().split("|")
        log_file = persiste_entries[0]
        log_position = int(persiste_entries[1])
        file.close()
    except (IOError,ValueError) as error:
        logger.error('Error opening persist file -> %s ' %(error.message))
    # print log_file , log_position
    return log_file,log_position


def persist(master_file, log_position,persist_file):
    try:
        file = open(persist_file,'w')
        file.write('%s|%d' %(master_file, log_position))
        # file.write('' %(log_position))
        file.close()
    except IOError as ioError:
        logger.error('Could not persist due to - > %s' %(ioError.message))


if __name__ == "__main__":
    main()
