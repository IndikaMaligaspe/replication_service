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
    "user": "root",
    "passwd": ""
}

def main():
    r = redis.Redis(host='192.168.50.4', port='6379',db=0)

    stream = BinLogStreamReader(
        connection_settings=MYSQL_SETTING,
        server_id=3,
        only_events=[DeleteRowsEvent, WriteRowsEvent, UpdateRowsEvent])

    for binlogevent in stream:
        prefix = "%s:%s" %(binlogevent.schema,binlogevent.table)

        for row in binlogevent.rows:
            if isinstance(binlogevent,DeleteRowsEvent):
                vals = row["values"]
                r.delet(prefix+str(vals["id"]))
            elif isinstance(binlogevent,UpdateRowsEvent):
                vals = row["after_values"]
                r.hmset(prefix+str(vals["id"]),vals)
            elif isinstance(binlogevent,WriteRowsEvent):
                vals = row["values"]
                r.hmset(prefix+str(vals["id"]),vals)
    stream.close()

if __name__ == "__main__":
    main()
