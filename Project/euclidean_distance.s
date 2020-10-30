.text
euclidean_distance:
    # $a0 is x0 $a1 is y0; a2 is x1 a3 is y1
    # $v0 is the calculated distance

    #####  put your codes below this line #####
    sub $t8, $a0, $a2 #x's
    sub $t9, $a1, $a3 #y's

    mult $t8, $t8 #square x
    mflo $t8      #store x

    mult $t9, $t9 #square y
    mflo, $t9     #store y

    add $v0, $t8, $t9

    #####  put your codes above this line #####
    jr $ra