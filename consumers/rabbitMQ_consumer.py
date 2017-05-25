'''
    This is a consumer for reading binlogstream events which are sent to a rabbitMQ instance.
    Since the queries have to be executes serilly we should use only one consumer.
    This could become a botlleneck in the future as if the events increase we may have a large queue backlog

    @author Indika Maligaspe
    @Date 27-May-2017
'''
