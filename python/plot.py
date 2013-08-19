#!/usr/bin/python

# Numpy is a library for handling arrays (like data points)
from dateutil import *
import numpy as np

# Pyplot is a module within the matplotlib library for plotting
import matplotlib.pyplot as plt

# Create an array of 100 linearly-spaced points from 0 to 2*pi
x = np.linspace(0,2*np.pi,100)
y1 = np.sin(2*x)
y2 = np.cos(4*x+np.pi/8)/4
# Create the plot
plt.plot(x,y1)
plt.plot(x,y2)
# Save the figure in a separate file
plt.savefig('sine_function_plain.png')

# Draw the plot to the screen
plt.show()
