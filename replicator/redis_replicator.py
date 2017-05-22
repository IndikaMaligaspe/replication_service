#!/usr/bin/env python

#@author: Indika Maligaspe
#@date: 2017-May-20

'''

Used to update a redis server cashe with the events triggered from
a MySQL database.
I could use this to update a slave database

'''

import redis

from pymysqlreplication import BinLogStreamReader
from pymysqlreplication.row_event import (
    DeleteRowsEvent,
    UpdateRowsEvent,
    WriteRowsEvent,
)

MYSQL_SETTING = {
    "host": "192.168.50.4",
    "port": 3306,
    "user": "indika",
    "passwd": "123456"
}

def main():
    r = redis.Redis(host='192.168.50.5', port='6379',db=0)

    stream = BinLogStreamReader(
        connection_settings=MYSQL_SETTING,
        # resume_stream=True,
        server_id=3,
        only_events=[DeleteRowsEvent, WriteRowsEvent, UpdateRowsEvent])
    # stream.starting_binlog_pos = 1263
    for binlogevent in stream:
        prefix = "%s:%s" %(binlogevent.schema,binlogevent.table)

        for row in binlogevent.rows:
            if stream.log_pos >= 1263:
                if isinstance(binlogevent,DeleteRowsEvent):
                    vals = row["values"]
                    # query = row["Query"]
                    print "delete values = %s , prefix = %s , query = (%s)" %(vals , prefix,row)
                    r.delete(prefix+str(vals))
                elif isinstance(binlogevent,UpdateRowsEvent):
                    vals = row["after_values"]
                    # query = row["Query"]
                    print "update values = %s , prefix = %s , query = (%s)" %(vals , prefix,row)
                    r.hmset(prefix+str(vals),vals)
                elif isinstance(binlogevent,WriteRowsEvent):
                    vals = row["values"]
                    # query = row["Query"]
                    print "insert values = %s , prefix = %s , query = (%s)" %(vals , prefix,row)
                    r.hmset(prefix+str(vals),vals)
    print "log position = %s" %(stream.log_pos)
    stream.close()

if __name__ == "__main__":
    main()
