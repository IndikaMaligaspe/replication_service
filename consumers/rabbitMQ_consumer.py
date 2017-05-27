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

def main():
    queuehost = '192.168.50.5'
    user = 'Indika'
    password = 'changeme'
    replicate_queue = 'alienvault_replicate'
    credentials = pika.PlainCredentials(username=user, password=password)
    connection = pika.BlockingConnection(pika.ConnectionParameters(host=queuehost, credentials=credentials))
    channel = connection.channel()

    channel.queue_declare(queue=replicate_queue, durable=True)
    print ('[*] waiting for messeges on queue = %s at %s. To exit press CNTR+C ' %(replicate_queue, queuehost))
    channel.basic_qos(prefetch_count=1)
    channel.basic_consume(callback,queue=replicate_queue)

    channel.start_consuming()

def callback(ch,method,properties, body):
    write_to_consming_backend(body)
    time.sleep(body.count(b'.'))
    print("[x] Done")
    ch.basic_ack(delivery_tag = method.delivery_tag)

def write_to_consming_backend(message):
    print ("[x] Recieved %s" %message)
    mysql_user_name = 'indika'
    mysql_password = '123456'
    mysql_host = '192.168.50.5'
    mysql_port='3306'
    mysql_database='maticportal'
    schema_list = {'alienvault':'maticportal'}

    cnx = mysql.connector.connect(user=mysql_user_name, password=mysql_password,
                              host=mysql_host,
                              database=mysql_database)
    message = change_scehame(message,schema_list)

    try:
        cursor = cnx.cursor()
        cursor.execute(message);
        cursor.close()
    except mysql.connector.Error as err:
        print err.message
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
