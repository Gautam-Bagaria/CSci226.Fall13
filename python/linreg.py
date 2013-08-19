# Sums: x, y, x*y, x**2

# m = (n*sum_xy - sum_x*sum_y)/(n*sum_x2-sum_x**2)
# b = (sum_y - m*sum_x)/n

import MySQLdb
from math import *

from dateutil import *
import numpy as np

# Pyplot is a module within the matplotlib library for plotting
import matplotlib.pyplot as plt

DATABASE = "music"
TABLE = "songs"
# DATABASE = "ratest"
# TABLE = "R2"
def count(item):
   conn = MySQLdb.connect (host = "localhost",
                           user = "cs126",
                           passwd = "cs126",
                           db = DATABASE)
   cursor = conn.cursor ()
   cursor.execute ("select count("+ item + ") from " + TABLE)
   row = cursor.fetchone ()
   cursor.close ()
   conn.close ()
   return float(row[0])

def sum_1(item):
   conn = MySQLdb.connect (host = "localhost",
                           user = "cs126",
                           passwd = "cs126",
                           db = DATABASE)
   cursor = conn.cursor ()
   cursor.execute ("select sum("+ item + ") from "+ TABLE)
   row = cursor.fetchone ()
   cursor.close ()
   conn.close ()
   return (row[0])

def sum_1sq(item):
   conn = MySQLdb.connect (host = "localhost",
                           user = "cs126",
                           passwd = "cs126",
                           db = DATABASE)
   cursor = conn.cursor ()
   cursor.execute ("select sum( item2 ) from " +
                   "(select power(" + item + ",2) as item2 from "+TABLE+") S2 ")
   row = cursor.fetchone ()
   cursor.close ()
   conn.close ()
   return float(row[0])

def sum_2(item1, item2):
   conn = MySQLdb.connect (host = "localhost",
                           user = "cs126",
                           passwd = "cs126",
                           db = DATABASE)
   cursor = conn.cursor ()
   cursor.execute ("select sum("+ item1 + "*" + item2+") from "+TABLE)
   row = cursor.fetchone ()
   cursor.close ()
   conn.close ()
   return float(row[0])

def linreg(Y, X):
    n = count(X)
    sum_x = sum_1(X)
    sum_y = sum_1(Y)

    sum_x2 = sum_1sq(X)
    sum_y2 = sum_1sq(Y)

    sum_xy = sum_2(X, Y)
    m = (n*sum_xy - float(sum_x*sum_y))
    m = m/(n*sum_x2-float(sum_x**2))
    b = (float(sum_y) - m*float(sum_x))/n
    r = (float(n)*sum_xy - float(sum_x*sum_y))
    r1 = sqrt(float(n*sum_y2) - float(sum_y**2))
    r2 = sqrt(float(n*sum_x2) - float(sum_x**2))
    r = r/(r1*r2)
    vals = [n, sum_x, sum_y, sum_x2, sum_y2, sum_xy]
    return [vals, m, b, r]

def load(item):
   conn = MySQLdb.connect (host = "localhost",
                           user = "cs126",
                           passwd = "cs126",
                           db = DATABASE)
   cursor = conn.cursor ()
   cursor.execute ("select "+item+" from " + TABLE)
                   
   row = cursor.fetchone ()
   out = []
   while row != None:
      for i in row:
         out.append(i)
      row = cursor.fetchone ()
   cursor.close ()
   conn.close ()
   return out

def plot(X,Y,m, b):
   x = np.linspace(0,2*np.pi,100)
   Y1 = []
   for x in X:
       Y1.append(m*x+b)
   # Create the plot
   plt.plot(X,Y)
   plt.plot(X,Y1)
   # Save the figure in a separate file
   plt.savefig('linreg.png')

   # Draw the plot to the screen
   plt.show()
    

x_item = 'PK'
y_item = 'High'
# x_item = 'K'
# y_item = 'F'
[[n, sum_x, sum_y, sum_x2, sum_y2, sum_xy], m, b, r] = linreg(y_item, x_item)
X = load(x_item)
Y = load(y_item)
plot(X,Y, m, b)


                   
                   