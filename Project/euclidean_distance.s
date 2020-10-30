.text
euclidean_distance:
    # $a0 is x0 $a1 is y0; a2 is x1 a3 is y1
    # $v0 is the calculated distance

    #####  put your codes below this line #####
    sub $t0, $a0, $a2 #x's
    sub $t1, $a1, $a3 #y's

    mult $t0, $t0 #square x
    mflo $t0      #store x

    mult $t1, $t1 #square y
    mflo, $t1     #store y

    add $v0, $t0, $t1

    #####  put your codes above this line #####
    jr $ra