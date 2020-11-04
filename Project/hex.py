bin = "14 00 00 00 DD 05 00 00 53 FA FF FF A4 F8 FF FF 2C FF FF FF A1 FB FF FF BC F9 FF FF 27 FE FF FF E7 02 00 00 F6 03 00 00 B4 04 00 00 9D 00 00 00 5F FF FF FF D9 07 00 00 EA 00 00 00 8E 02 00 00 EC FF FF FF 61 01 00 00 18 FF FF FF 7A 02 00 00 41 FC FF FF 2C F8 FF FF F5 FE FF FF 01 00 00 00 33 04 00 00 CE F9 FF FF 65 F8 FF FF 84 FB FF FF FC 01 00 00 8F 00 00 00 4A FD FF FF F8 FC FF FF 94 FD FF FF F7 F8 FF FF EB F8 FF FF 56 FA FF FF 46 06 00 00 82 FD FF FF 80 03 00 00 53 FB FF FF 63 FE FF FF"
##THIS is the header
# 268501040
"""

           00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F

00000000   14 00 00 00 DD 05 00 00 53 FA FF FF A4 F8 FF FF  ....Ý...Sú..¤ø..
00000010   2C FF FF FF A1 FB FF FF BC F9 FF FF 27 FE FF FF  ,...¡û..¼ù..'þ..
00000020   E7 02 00 00 F6 03 00 00 B4 04 00 00 9D 00 00 00  ç...ö...´......
00000030   5F FF FF FF D9 07 00 00 EA 00 00 00 8E 02 00 00  _...Ù...ê......
00000040   EC FF FF FF 61 01 00 00 18 FF FF FF 7A 02 00 00  ì...a.......z...
00000050   41 FC FF FF 2C F8 FF FF F5 FE FF FF 01 00 00 00  Aü..,ø..õþ......
00000060   33 04 00 00 CE F9 FF FF 65 F8 FF FF 84 FB FF FF  3...Îù..eø..û..
00000070   FC 01 00 00 8F 00 00 00 4A FD FF FF F8 FC FF FF  ü......Jý..øü..
00000080   94 FD FF FF F7 F8 FF FF EB F8 FF FF 56 FA FF FF  ý..÷ø..ëø..Vú..
00000090   46 06 00 00 82 FD FF FF 80 03 00 00 53 FB FF FF  F...ý.....Sû..
000000A0   63 FE FF FF                                      cþ..

"""

def hex_dec(hex):
    h = hex.replace(" ", "")
    pwr = len(h)-1

    total = 0
    for i in h:
        if i == "A":
            total += 10*(16**pwr)
        elif i == "B":
            total += 11*(16**pwr)
        elif i == "C":
            total += 12*(16**pwr)
        elif i == "D":
            total += 13*(16**pwr)
        elif i == "E":
            total += 14*(16**pwr)
        elif i == "F":
            total += 15*(16**pwr)
        else:
            total += int(i)*(16**pwr)
        pwr-=1
        
        
    return total


def to_big_Endian(hex):
    l = hex.split(" ")
    l.reverse()
    ret = ""
    for i in l:
        ret += i + " "
    return ret
def sep_points(pts):
    pt = pts.split(" ")
    l = []
    s = ""
    count = 0
    for i in pt:
        if(count != 3):
            s += i + " "
        count +=1
        if(count == 4):
            count = 0
            l.append(s + i)
            s = ""
    return l


def get_points(l):
    numpoints = hex_dec(to_big_Endian(l[0]))
    print("num_points", numpoints)
    pt = 1
    i = 1
    while(i < len(l)):
        x = hex_dec(to_big_Endian(l[i]))
        y = hex_dec(to_big_Endian(l[i+1]))
        print(pt, (x,y), to_big_Endian(l[i]), "|", to_big_Endian(l[i+1]))
        pt+=1
        i+=2


def main():
    get_points(sep_points(bin))
    return 0

main()