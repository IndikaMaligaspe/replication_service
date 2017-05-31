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
                    SQL = 'delete from `'+schema+'`.`'+table+'` where ' + " and ".join(where)
                    print 'Delete SQL : '+SQL
                    r.set(name = prefix+"delete - ", value = SQL)
                elif isinstance(binlogevent,UpdateRowsEvent):
                    where = []
                    update = []
                    set_vals = row["after_values"]
                    where_vals = row["before_values"]

                    update = pepare_update_clause(set_vals)
                    where = prepare_where_clause(where_vals)

                    SQL = 'update  `'+schema+'`.`'+table+'` set '+" , ".join(update)+' where ' + " and ".join(where)
                    print 'Update SQL : '+SQL
                    r.set(name = prefix+"update - ", value = SQL)
                elif isinstance(binlogevent,WriteRowsEvent):
                    vals = row["values"]
                    insert = pepare_insert_values(vals)
                    SQL = 'insert into  `'+schema+'`.`'+table+'` ('+" , ".join(insert['cols'])+') values ('+" , ".join(insert['vals'])+')'
                    print 'Insert SQL : '+SQL
                    r.set(name = prefix+"insert - ", value = SQL)
    print "log position = %s" %(stream.log_pos)
    stream.close()

def prepare_where_clause(set_vals):
    where = []
    for keys in set_vals:
        column = check_field_types(set_vals[keys])
        where.append(' '+keys+'= '+column)
    return where




def pepare_update_clause(set_vals):
    update = []
    for keys in set_vals:
        column = check_field_types(set_vals[keys])
        update.append(' '+keys+'= '+column)
    return update



def pepare_insert_values(set_vals):
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
