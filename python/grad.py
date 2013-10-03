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
x_item = 'PK'
y_item = 'High'

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
   return float(row[0])

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
    m = (n*sum_xy - sum_x*sum_y)
    m = m/(n*sum_x2-sum_x**2)
    b = (sum_y - m*sum_x)/n
    r = (n*sum_xy - sum_x*sum_y)
    r1 = sqrt(n*sum_y2 - sum_y**2)
    r2 = sqrt(n*sum_x2 - sum_x**2)
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
   Y1 = []
   for x in X:
       Y1.append(m*x+b)
   # Create the plot
   plt.plot(X,Y,'o')
   plt.plot(X,Y1)
   # Save the figure in a separate file
   plt.savefig('linreg.png')

   # Draw the plot to the screen
   plt.show()
    
def test1():
   global x_item, y_item, DATABASE, TABLE
   x_item = 'PK'
   y_item = 'High'
   DATABASE = "music"
   TABLE = "songs"

def test2():
   global x_item, y_item, DATABASE, TABLE
   DATABASE = "ratest"
   TABLE = "R2"
   x_item = 'K'
   y_item = 'F'

def test3():
   global x_item, y_item, DATABASE, TABLE
   DATABASE = "iris2d"
   TABLE = "iris_2d"
   x_item = 'petallength'
   y_item = 'petalwidth'

def runit():
   global x_item, y_item, DATABASE, TABLE
   X = load(x_item)
   Y = load(y_item)
   [[n, sum_x, sum_y, sum_x2, sum_y2, sum_xy], m, b, r] = linreg(y_item, x_item)   
   plot(X,Y, m, b)

def theta_x(theta, X):
   n = len(theta)
   y = 0
   for i in range(n):
      y += theta[i]*X[i]
   return y

def csvread(filename):
   import csv
   reader = csv.reader(open(filename, "rb"), 
                    delimiter=',', quoting=csv.QUOTE_NONE)

   thereIsAHeader = False
   header = []
   records = []

   if thereIsAHeader: header = reader.next()

   for row, record in enumerate(reader):
      a = []
      for i in record:
         a.append(float(i))
      records.append(a)
   return records

# m denotes the number of examples here, not the number of features
def gradientDescent(x, y, theta, alpha, m, numIterations):
    points = []
    costs = []
    count = []
    # original: xTrans = x.transpose()
    xTrans = x
    for i in range(0, numIterations):
        hypothesis = np.dot(x, theta)
        loss = hypothesis - y
        # avg cost per example (the 2 in 2*m doesn't really matter here.
        # But to be consistent with the gradient, I include it)
        cost = np.sum(loss ** 2) / 2 * m
        print("Iteration %d | Cost: %f" % (i, cost))
        count.append(i+1)
        costs.append(cost)
        # avg gradient per example
        # original: gradient = np.dot(xTrans, loss) / m
        gradient = np.dot(loss, xTrans) / m
        # update
        theta = theta - alpha * gradient
        if cost > 10**15 : break
    points.append(count)
    points.append(costs)
    return [theta, points]


def learningCurves(X, Y):
   m = X.shape[1]
   n = X.shape[0]
   for alpha in [0.001,0.005, 0.01, 0.05, 0.1, 0.15]:
#   for alpha in [0.05, 0.06, 0.07]:      
      [theta_out, points]=gradientDescent( X, Y, np.zeros(m), alpha, n, 25 )
      points[0]
      points[1]
      plt.plot(points[0],points[1],'-',label='Alpha='+str(alpha),linewidth=3)
   plt.ylim([0,50000])
   plt.legend(loc='upper right', numpoints = 1)
   plt.show()

   
test3()
X = load(x_item)
Y = load(y_item)
X1 = np.column_stack((np.ones(len(X)),X))
m = X1.shape[1]
n = X1.shape[0]
theta = np.zeros(m)
[theta_out, points] = gradientDescent(X1,Y, theta, 0.05, n, 100)
                     
plot(X,Y, theta_out[1], theta_out[0])
# var1 = (sum_x2/n - (sum_x/n)**2)
# var2 = np.var(X)
# np.savetxt('D:\\Documents\\druby\\tmp\\test.dat', X, delimiter=",")
learningCurves(X1, Y)


                   
                   
