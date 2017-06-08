'''
    This is a consumer for reading binlogstream events which are sent to a rabbitMQ instance
    Since the queries have to be executes serilly we should use only one consumer.
    This could become a botlleneck in the future as if the events increase we may have a large queue backlog

    @author Indika Maligaspe
    @Date 27-May-2017
'''

import yaml
import pika
import time
import mysql.connector
import cPickle
import sys
import logging




MYSQL_SETTING = {
    "host": "192.168.50.4",
    "port": 3306,
    "user": "indika",
    "passwd": "123456"
}

RABBITMQ_SETTINGS = {}

logger = logging.getLogger()
schema_list = {'alienvault':'maticportal'}

def get_configs():
    config_file = sys.argv[1]
    with open(config_file, 'r') as yfile:
        doc = yaml.load(yfile)
        MYSQL_SETTING['host']=str(doc['mysql_slave']['host'])
        MYSQL_SETTING['port']=int(doc['mysql_slave']['port'])
        MYSQL_SETTING['user']=str(doc['mysql_slave']['user'])
        MYSQL_SETTING['passwd']=str(doc['mysql_slave']['passwd'])
        MYSQL_SETTING['database']=str(doc['mysql_slave']['database'])
        log4py_file=doc['logs']['log4py']['path']
        log4py_log_level=doc['logs']['log4py']['log_level']
        RABBITMQ_SETTINGS['host']=str(doc['rabbitMQ']['host'])
        RABBITMQ_SETTINGS['passwd']=str(doc['rabbitMQ']['passwd'])
        RABBITMQ_SETTINGS['user']=str(doc['rabbitMQ']['user'])
        RABBITMQ_SETTINGS['queue']=str(doc['rabbitMQ']['queue'])

        if log4py_log_level == 'DEBUG':
            log_level = logging.DEBUG
        elif log4py_log_level == 'INFO':
            log_level = logging.INFO
        elif log4py_log_level == 'WARN':
            log_level = logging.WARN
        elif log4py_log_level == 'ERROR':
            log_level = logging.ERROR

    logging.basicConfig(filename=log4py_file,level=log_level)
    # schema_list = {'alienvault':'maticportal'}

def main():
    get_configs()
    queuehost = RABBITMQ_SETTINGS['host']
    user = RABBITMQ_SETTINGS['user']
    password = RABBITMQ_SETTINGS['passwd']
    replicate_queue = RABBITMQ_SETTINGS['queue']
    print('name / pwd - >%s / %s' %(user,password))
    credentials = pika.PlainCredentials(username=user, password=password)
    connection = pika.BlockingConnection(pika.ConnectionParameters(host=queuehost, port=8080,  virtual_host='/', credentials=credentials))
    channel = connection.channel()

    channel.queue_declare(queue=replicate_queue, durable=True)
    print ('[*] waiting for messeges on queue = %s at %s. To exit press CNTR+C ' %(replicate_queue, queuehost))
    channel.basic_qos(prefetch_count=1)
    channel.basic_consume(callback,queue=replicate_queue)

    channel.start_consuming()

def callback(ch,method,properties, body):
    if None != body:
        query , args = build_query(body)
        write_to_consming_backend(query , args)

    time.sleep(body.count(b'.'))
    print("[x] Done")
    ch.basic_ack(delivery_tag = method.delivery_tag)


def build_query(body):
    consumed = cPickle.loads(body)
    query = ''
    args = []

    if consumed['type'] == 'insert':
        query , args  = create_insert_query(consumed)
    if consumed['type'] == 'update':
        query , args = create_update_query(consumed)
    if consumed['type'] == 'delete':
        query , args = create_delete_query(consumed)
    if consumed['type'] == 'create':
        query , args = create_query(consumed)
    if consumed['type'] == 'drop':
        query , args = create_query(consumed)
    return query , args

def create_insert_query(consumed):
    table = consumed['table']
    schema = consumed['schema']
    columns = consumed['cols']
    values = consumed['values']
    args = []
    column_types = []
    for column in columns:
        column_types.append("%s")

    sql = ("INSERT INTO `"+change_scehame(schema,schema_list)+"`.`"+table+"` ("+",".join(columns)+") values ("+",".join(column_types)+")")
    for key in columns:
        args.append(values[key])
    logger.debug(sql)
    return sql , args


def create_update_query(consumed):
    table = consumed['table']
    schema = consumed['schema']
    columns = consumed['cols']
    values = []
    where = []
    sql = ("UPDATE  `"+change_scehame(schema,schema_list)+"`.`"+table+"` set ")
    update_vals = ''
    where_vals = ''
    logger.debug('after - > %s' %(consumed['after_values']))
    logger.debug('before - > %s' %(consumed['before_values']))
    logger.debug('colmuns - > %s' %(columns))

    for cols in columns:
        update_vals += cols+' = %s , '
        where_vals += cols+' = %s AND '
        values.append(consumed['after_values'][cols])
        where.append(consumed['before_values'][cols])

    sql = sql +   update_vals[:-2]  + ' where '+ where_vals[:-4]

    args = values + where
    logger.debug(args)
    logger.debug(sql)
    return sql , args
def create_delete_query(consumed):
    table = consumed['table']
    schema = consumed['schema']
    columns = consumed['cols']
    where = []
    sql = ("DELETE FROM  `"+change_scehame(schema,schema_list)+"`.`"+table+"`")
    where_vals = ''
    logger.debug('after - > %s' %(consumed['values']))
    logger.debug('colmuns - > %s' %(columns))

    for cols in columns:
        where_vals += cols+' = %s AND '
        where.append(consumed['values'][cols])

    sql = sql +   ' where '+ where_vals[:-4]

    args = where
    logger.debug(args)
    logger.debug(sql)
    return sql , args

def create_query(consumed):
    return 'test' , []


def write_to_consming_backend(sql , args):
    print ("[x] Recieved %s" %args)
    mysql_user_name = MYSQL_SETTING['user']
    mysql_password = MYSQL_SETTING['passwd']
    mysql_host =MYSQL_SETTING['host']
    mysql_port=MYSQL_SETTING['port']
    mysql_database=MYSQL_SETTING['database']

    cnx = mysql.connector.connect(user=mysql_user_name, password=mysql_password,
                              host=mysql_host,
                              database=mysql_database)

    try:
        cursor = cnx.cursor()
        cursor.execute(sql,args);
        corsor.commit()
        cursor.close()
    except mysql.connector.Error as err:
        logger.error(err.message)
    finally:
        cnx.close();

def change_scehame(message,schema_list):
    if schema_list == None:
        return message
    else:
        for from_schema,to_schema in schema_list.items():
            message = str(message).replace(from_schema,to_schema)
    return message


if __name__ == "__main__":
     main()
