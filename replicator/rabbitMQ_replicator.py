'''
    This file is used to publish binlogstream events to a rabbitMQ instance
    @author Indika Maligaspe
    @Date 26th May 2017

'''

import pika
import time
import logging

from time import sleep
import mysql.connector

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

logging.basicConfig(filename='example.log',level=logging.DEBUG)
logger = logging.getLogger()

MYSQL_SETTING = {
    "host": "192.168.50.4",
    "port": 3306,
    "user": "indika",
    "passwd": "123456"
}

def main():
    log_position = 4
    start_binlograder(log_position)

def start_binlograder(log_position):
    log_file = get_latest_master_log_file()
    credentials = pika.PlainCredentials('Indika','changeme')
    connection  = pika.BlockingConnection(pika.ConnectionParameters(host='192.168.50.5',credentials=credentials))
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
                        push_mesage(channel,query,queue)
                        log_position = stream.log_pos
                    elif "drop table".upper() in query.upper():
                        logger.debug ('Drop SQL - %s' %(query))
                        push_mesage(channel,query,queue)
                        log_position = stream.log_pos

                elif isinstance(binlogevent,RotateEvent):
                    log_file = get_latest_master_log_file()
                    log_position = 4
                else:
                    schema = binlogevent.schema

                    for row in binlogevent.rows:
                            table = binlogevent.table
                            columns = binlogevent.columns
                            if isinstance(binlogevent,DeleteRowsEvent):
                                prefix = "%s:%s" %(schema,table)
                                where = []
                                vals = row["values"]
                                where = prepare_where_clause(vals)
                                SQL = 'delete from `'+schema+'`.`'+table+'` where ' + " and ".join(where)
                                logger.debug('Delete SQL : '+SQL)
                                # r.set(name = prefix+"delete - ", value = SQL)
                                push_mesage(channel,SQL,queue)
                                log_position = stream.log_pos
                            elif isinstance(binlogevent,UpdateRowsEvent):
                                prefix = "%s:%s" %(schema,table)
                                where = []
                                update = []
                                set_vals = row["after_values"]
                                where_vals = row["before_values"]
                                update = prepare_update_clause(set_vals)
                                where = prepare_where_clause(where_vals)
                                SQL = 'update  `'+schema+'`.`'+table+'` set '+" , ".join(update)+' where ' + " and ".join(where)
                                logger.debug( 'Update SQL : '+SQL)
                                # r.set(name = prefix+"update - ", value = SQL)
                                push_mesage(channel,SQL,queue)
                                log_position = stream.log_pos
                            elif isinstance(binlogevent,WriteRowsEvent):
                                prefix = "%s:%s" %(schema,table)
                                vals = row["values"]
                                insert = prepare_insert_values(vals)
                                SQL = 'insert into  `'+schema+'`.`'+table+'` ('+" , ".join(insert['cols'])+') values ('+" , ".join(insert['vals'])+')'
                                logger.debug( 'Insert SQL : '+SQL)
                                # r.set(name = prefix+"insert - ", value = SQL)
                                push_mesage(channel,SQL,queue)
                                log_position = stream.log_pos


                log_position = stream.log_pos
            logger.info( "log position = %s" %(log_position))
        sleep(10)
    stream.close()
    connection.close();

def push_mesage(channel,message,key):
    channel.basic_publish(exchange='',
        routing_key  = key,
        body = message,
        properties=pika.BasicProperties(
            delivery_mode = 2, #make message persistant
        )
    )
    return True

def prepare_where_clause(set_vals):
    where = []
    for keys in set_vals:
        column = check_field_types(set_vals[keys])
        where.append(' '+keys+'= '+column)
    return where


def prepare_update_clause(set_vals):
    update = []
    for keys in set_vals:
        column = check_field_types(set_vals[keys])
        update.append(' '+keys+'= '+column)
    return update

def prepare_insert_values(set_vals):
    insert = {}
    insert_cols = []
    insert_vals = []
    for keys in set_vals:
        column = check_field_types(set_vals[keys])
        insert_cols.append(keys)
        insert_vals.append(str(column))
    insert['cols'] = insert_cols
    insert['vals'] = insert_vals
    return insert

def check_field_types(column):
    column_str = None
    if type(column) == int:
        column_str = str(column)
    elif type(column) == bool:
        column_str = str(column)
    elif type(column) == str:
        column_str = '\''+str(column)+'\''
    else:
        logger.warn('New Column Type found - %s - ' %(type(column)))
        column_str = '\''+str(column)+'\''
    return column_str

def get_latest_master_log_file():
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

        cursor.close()
        connection.close()
    except mysql.connector.errors as mysqlerror:
        logger.error(mysqlerror.msg)
    finally:
        if None != connection:
            connection.close()

    logger.debug('Log File -> %s' %(log_file))
    return log_file
if __name__ == "__main__":
    main()
