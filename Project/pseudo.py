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


    #syscall
    #open
    #read
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


#technically global:
return_x0 = 0 #v0
return_x1 = 0 #v1
least = 15680000 #t3   0xEF4200
def bruteish_find_closest(length, base_address):
    # $a0 is num_points, $a1 is array base address
    # $v0, $v1 is the address of the two points of the closest pair
    # i.e., $v0 is the address of x0 in the array, $v1 is the address of x1 in the array

    #x,y are 4 byte pairs
    #|x0|y0|x1|y1|x2|y2|x3|y3|
    #|4 |4 |4 |4 |4 |4 |4 |4 |
    #|8    |8    |8    |8    |  
    #pointer math

    comp = base_address        #$a1
    cur = 0                    #li $t0, 0
    distance = 0               #li $t1, 0

    cur = comp+8           # addi $t0, $t0, 8
    while(cur < length):
        distance = euclidean_distance(comp, comp+4, cur, cur+4)
            
        if(distance < least):
            least = distance
            return_x0 = comp
            return_x1 = cur

        cur+=8             # addi $t0, $t0, 8

    if(length == 1):
        return

    bruteish_find_closest(length-1, comp+8)                # addi $t0, $t0, 8

    #end


return_x0 = 0 #v0
return_x1 = 0 #v1
def find_closest_torun(length, base_address, array, x0, x1, l):
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
    least = l

    return_x0 = x0 #v0
    return_x1 = x1 #v1

    cur = comp+2          # addi $t1, $t0, 8
    while(cur < length):
        distance = euclidean_distance(array[comp], array[comp+1], array[cur], array[cur+1])
            
        if(distance < least):
            least = distance
            return_x0 = comp
            return_x1 = cur

        cur+=2             # addi $t1, $t1, 8

    if(length == 1):
        print(array[return_x0], array[return_x0+1], array[return_x1], array[return_x1+1])
        return array[return_x0], array[return_x0+1], array[return_x1], array[return_x1+1]
        
    find_closest_torun(length-1, comp+2, array, return_x0, return_x1, least)                # addi $t0, $t0, 8


"""
Sorting algo are not the best, but written with an "easy" 
assembly translation in mind
"""


#sort.s
def sort_by_x(length, array):
    # sort points in-place by x . Non-decrease order is applied
    # $a0 is num_points, $a1 is array base address
    # note that array has the order as x0, y0, x1, y1, x2, y3, ..., xn , yn

    #x's are even

    sort_length = 0
    current_pos = 2

    check_pos = 0

    while(sort_length < length-2):

        i = check_pos
        while(i <= current_pos):
            if(array[current_pos] < array[i]):
                temp_x = array[i]
                temp_y = array[i+1]
                array[i] = array[current_pos]
                array[i+1] = array[current_pos+1]
                array[current_pos] = temp_x
                array[current_pos+1] = temp_y

                check_pos = i #used to shift elements
                break
            if(i == current_pos and i != length):
                sort_length+=2
                current_pos+=2
                check_pos = 0
                break

            i+=2

    return array #for testing

def sort_by_y(length, array):
    # sort points in-place by x . Non-decrease order is applied
    # $a0 is num_points, $a1 is array base address
    # note that array has the order as x0, y0, x1, y1, x2, y3, ..., xn , yn

    #y's are odd

    sort_length = 0
    current_pos = 3

    check_pos = 1

    while(sort_length < length-2):

        i = check_pos
        while(i <= current_pos):
            if(array[current_pos] < array[i]):
                temp_x = array[i-1]
                temp_y = array[i]
                array[i] = array[current_pos]
                array[i-1] = array[current_pos-1]
                array[current_pos-1] = temp_x
                array[current_pos] = temp_y

                check_pos = i #shift elements right
                break
            if(i == current_pos and i != length):
                sort_length+=2
                current_pos+=2
                check_pos = 1
                break

            i+=2

    return array #for testing