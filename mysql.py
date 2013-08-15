# Simply Python <--> MySQL Examples

import MySQLdb

def test1():
   conn = MySQLdb.connect (host = "localhost",
                           user = "cs126",
                           passwd = "cs126",
                           db = "music")
   cursor = conn.cursor ()
   cursor.execute ("SELECT VERSION()")
   row = cursor.fetchone ()
   print "server version:", row[0]
   cursor.close ()
   conn.close ()

def test2():
   conn = MySQLdb.connect (host = "localhost",
                           user = "cs126",
                           passwd = "cs126",
                           db = "music")
   cursor = conn.cursor ()
   cursor.execute ("SELECT COUNT(*) FROM SONGS")
   row = cursor.fetchone ()
   print "Table Rows:", row[0]
   cursor.close ()
   conn.close ()
