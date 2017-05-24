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
        schema = binlogevent.schema
        table = binlogevent.table
        columns = binlogevent.columns
        prefix = "%s:%s" %(binlogevent.schema,binlogevent.table)

        for row in binlogevent.rows:
            # if stream.log_pos >= 1263:
                if isinstance(binlogevent,DeleteRowsEvent):
                    where = []
                    vals = row["values"]
                    where = prepare_where_clause(vals)
                    # query = row["Query"]
                    SQL = 'delete from `'+schema+'`.`'+table+'` where ' + "and".join(where)
                    print 'Delete SQL : '+SQL
                    print "delete values = %s , prefix = %s , query = (%s), columns  = (%s)" %(vals , prefix,row,columns)
                    r.delete(prefix+str(vals))
                elif isinstance(binlogevent,UpdateRowsEvent):
                    where = []
                    update = []
                    set_vals = row["before_values"]
                    where_vals = row["after_values"]

                    update = pepare_update_clause(set_vals)
                    where = prepare_where_clause(where_vals)

                    SQL = 'update  `'+schema+'`.`'+table+'` set '+" , ".join(update)+' where ' + "and".join(where)
                    print 'Update SQL : '+SQL
                    print "update values = %s , prefix = %s , query = (%s) , columns  = (%s)" %(vals , prefix,row ,columns)
                    r.hmset(prefix+str(vals),vals)
                elif isinstance(binlogevent,WriteRowsEvent):
                    vals = row["values"]
                    # query = row["Query"]
                    print "insert values = %s , prefix = %s , query = (%s) , columns  = (%s)" %(vals , prefix,row ,columns)
                    r.hmset(prefix+str(vals),vals)
    print "log position = %s" %(stream.log_pos)
    stream.close()

def prepare_where_clause(vals):
    where = []
    for keys in vals:
        column = vals[keys];
        if type(column) == int:
            where.append(' '+keys+'='+str(column)+' ')
        elif type(column) == bool:
            where.append(' '+keys+'='+str(column)+' ')
        else:
            where.append(' '+keys+'=\''+str(column)+'\''+' ')

    return where

def pepare_update_clause(set_vals):
    update = []
    for keys in set_vals:
        column = set_vals[keys]
        if type(column) == int:
            update.append(' '+keys+'='+str(column)+' ')
        elif type(column) == bool:
            update.append(' '+keys+'='+str(column)+' ')
        else:
            update.append(' '+keys+'=\''+str(column)+'\''+' ')


    return update

if __name__ == "__main__":
    main()
