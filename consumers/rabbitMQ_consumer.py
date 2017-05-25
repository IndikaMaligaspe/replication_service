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
    print ("[x] Recieved %s" %body)
    time.sleep(body.count(b'.'))
    print("[x] Done")
    ch.basic_ack(delivery_tag = method.delivery_tag)


if __name__ == "__main__":
     main()
