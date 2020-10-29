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

for i in range(0, 10):
    ar = generate_random_array(20)
    sort = sort_by_x(len(ar), ar)
    for j in range(0,len(sort)-2, 2):
        if(sort[j] > sort[j+2]):
            print("error")