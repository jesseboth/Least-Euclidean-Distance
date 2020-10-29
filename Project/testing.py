from pseudo import *
import random

def generate_random_array(number_of_coords):
    array = []
    for i in range(0, number_of_coords):
        x = random.randint(-2800, 2800)
        y = random.randint(-2800, 2800)
        print(x,y)
        array += x,y
    return array

def test_sort(num):
    for i in range(0, num):
        ar = generate_random_array(20)
        sort_x = sort_by_x(len(ar), ar)
        print("x", sort_x)
        for j in range(0,len(sort_x)-2, 2):
            if(sort_x[j] > sort_x[j+2]):
                print("error x", sort_x)

    for i in range(0, num):
        ar = generate_random_array(20)
        sort_y = sort_by_y(len(ar), ar)
        print("y", sort_y)
        for j in range(0,len(sort_y)-2, 2):
            if(sort_y[j+1] > sort_y[j+3]):
                print("error y", sort_y)

test_sort(10)