"""
all functions needed
are coded in python here
with psedo comments
"""

#io
def load_points():
    # $a0 is the based address of the file name string
    # $v0 is the number of points
    # $v1 is the based address of points array
    # i.e., $v1 is x0, 4($v1) is y0, 8($v1) is x1, etc
    return

def output_closest_pair():
    # $a0, $a1 is the address of the two points of the closest pair
    # i.e., $a0 is the address of x0, 4($a0) is the address of y0, $a1 is the address of x1, etc.
    return

def load_points_helper():
    # file descriptor is in $a0
    # $v0 is the number of points
    # $v1 is the based address of points array
    # i.e., $v1 is x0, 4($v1) is y0, 8($v1) is x1, etc.
    return

#euclidean
def euclidean_distance(x0, y0, x1, y1):

    # $a0 is x0 $a1 is y0; a2 is x1 a3 is y1
    # $v0 is the calculated distance
    
    x = x0 - x1     #sub $t0, $a0, $a2
    y = y0 - y1     #sub $t1, $a1, $a3

    #{HI, LO}
    x = x*x         #mult $t0, $t0, $t0
    y = y*y         #mult $t1, $t1, $t1

    final = x + y   #add $v0, $t0, $t1

    return final

def find_closest(length, base_address):
    # $a0 is num_points, $a1 is array base address
    # $v0, $v1 is the address of the two points of the closest pair
    # i.e., $v0 is the address of x0 in the array, $v1 is the address of x1 in the array

    #x,y are 4 byte pairs
    #|x0|y0|x1|y1|x2|y2|x3|y3|
    #|4 |4 |4 |4 |4 |4 |4 |4 |
    #|8    |8    |8    |8    |  
    #pointer math

    comp = base_address        #li $t0, 0
    cur = 0                    #li $t1, 0
    distance = 0               #li $t2, 0

    return_x0 = 0 #v0
    return_x1 = 0 #v1

    least = 0x7FFFFFFF #2^31
    while(comp < length-1):
        cur = comp+8           # addi $t1, $t0, 8
        while(cur < length):
            distance = euclidean_distance(comp, comp+4, cur, cur+4)
            
            if(distance < least):
                least = distance
                return_x0 = comp
                return_x1 = cur

            cur+=8             # addi $t1, $t1, 8

        comp+=8                # addi $t0, $t0, 8

    return

