
# Quiz 4

# Question 1
# Write Python code to initialize a variable ‘x’ to an array of
#  3 values, all equal to 0.

x = [0, 0, 0]

# Question 2
# Write Python function to calculate the area of a triangle
#   given it’s base and height.

def area_of_triangle(base, height):
    area = (base * height) / 2.0
    print area
    return area

# Question 3
# Write a Python function that takes an array as input
#   and uses a for loop to print the contents of each item.

def print_array( array ):
    for item in array:
        print item

# Question 4 & 5
# Create a Class triangle that is initialized with two member variable values,
#   base and height.
# Add a member function to Triangle class that calculates Area.

class triangle (object):
    def __init__(self, base, height):
        self.base = base
        self.height = height

    def area (self):
        return (self.base * self.height)/2.0
        

# Testing Code
print x
# returns:
#[0, 0, 0]

y = area_of_triangle(3,5)
# returns
# 7.5

print y
#returns
#7.5

print_array(x)
# returns 
#0
#0
#0

t1 = triangle(3,5)
print t1.height, t1.base
# returns
#3 5

print t1.area()
# returns
#7.5
