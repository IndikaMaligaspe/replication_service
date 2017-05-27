'''
    This file is used to publish binlogstream events to a rabbitMQ instance
    @author Indika Maligaspe
    @Date 26th May 2017

'''

import pika
import time
from time import sleep

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

MYSQL_SETTING = {
    "host": "192.168.50.4",
    "port": 3306,
    "user": "indika",
    "passwd": "123456"
}

def main():
    log_position = 0
    start_binlograder(log_position)

def start_binlograder(log_position):
    credentials = pika.PlainCredentials('Indika','changeme')
    connection  = pika.BlockingConnection(pika.ConnectionParameters(host='192.168.50.5',credentials=credentials))
    channel = connection.channel()
    queue = 'alienvault_replicate'
    channel.queue_declare(queue=queue,durable=True)


    while True:
        stream = BinLogStreamReader(
            connection_settings=MYSQL_SETTING,
            # resume_stream=True,
            server_id=3,
            log_pos=log_position,
            only_events=[DeleteRowsEvent, WriteRowsEvent, UpdateRowsEvent,QueryEvent,RotateEvent])
            
        for binlogevent in stream:
            if isinstance(binlogevent,RotateEvent):
                print 'Log Rotated'
                log_position = 0
            elif isinstance(binlogevent,QueryEvent):
                schema = binlogevent.schema
                prefix = "%s: " %(schema)
                query = str(binlogevent.query)
                print ('Query Event - %s' %(query))
                if "create table".upper() in query.upper():
                    print ('Create SQL - %s' %(query))
                    push_mesage(channel,query,queue)
                    log_position = stream.log_pos
                elif "drop table".upper() in query.upper():
                    print ('Drop SQL - %s' %(query))
                    push_mesage(channel,query,queue)
                    log_position = stream.log_pos

            else:
                schema = binlogevent.schema
                table = binlogevent.table
                columns = binlogevent.columns
                for row in binlogevent.rows:
                    # if stream.log_pos >= 1263:
                        if isinstance(binlogevent,DeleteRowsEvent):
                            prefix = "%s:%s" %(schema,table)
                            where = []
                            vals = row["values"]
                            where = prepare_where_clause(vals)
                            SQL = 'delete from `'+schema+'`.`'+table+'` where ' + " and ".join(where)
                            print 'Delete SQL : '+SQL
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
                            print 'Update SQL : '+SQL
                            # r.set(name = prefix+"update - ", value = SQL)
                            push_mesage(channel,SQL,queue)
                            log_position = stream.log_pos
                        elif isinstance(binlogevent,WriteRowsEvent):
                            prefix = "%s:%s" %(schema,table)
                            vals = row["values"]
                            insert = prepare_insert_values(vals)
                            SQL = 'insert into  `'+schema+'`.`'+table+'` ('+" , ".join(insert['cols'])+') values ('+" , ".join(insert['vals'])+')'
                            print 'Insert SQL : '+SQL
                            # r.set(name = prefix+"insert - ", value = SQL)
                            push_mesage(channel,SQL,queue)
                            log_position = stream.log_pos



            print "log position = %s" %(stream.log_pos)
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
    else:
        column_str = '\''+str(column)+'\''
    return column_str

if __name__ == "__main__":
    main()
