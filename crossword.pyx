import os
from libc.stdio cimport *
from math import *
from random import randint
from libc.stdlib cimport malloc, free

cdef struct space:
    int row
    int column
    char* value
    int charType
    char* horizontallist   #words that work horizontally
    char* verticallist     #words that work vertically
    char* combinedlist     #word that work both ways

ctypedef space spaces

cdef int contains(int field[], int query):
    for i in range(sizeof(field)/sizeof(int)):
        if(field[i] == query):
            return 1
    return 0

cdef int* lenlistmaker(spaces board[][10]):
    size = 10
    counts = 0
    countslist = []
    cdef char* blackSpace = "#"
    for x in range(size):
        for y in range(size):
            
            if board[x][y].value != blackSpace:
                counts += 1
                if (counts not in countslist):
                    countslist.append(counts)
    for y in countslist:
        if y in range(0,2):
            countslist.remove(y)
    cdef int* countsList = <int *>malloc(len(countslist)*sizeof(int))
    for i in range(len(countslist)):
        countsList[i] = countslist[i]
    return countsList


def transferfile(location,lengthlist):
    blacklist = [chr(39), chr(146), "-", ".", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    lengthlist = [2, 3, 4, 5, 6, 7, 8, 9, 10]
    os.system("cp " + location + " ./words")
    with open("words") as f:
        lines = f.readlines()
        goodLines = []
        for line in lines:
            isBlacklisted = False
            for c in line:
#               #if((c in blacklist) or (len(line) <= 3) or (len(line) > 11)):
                if((c in blacklist) or ((len(line) - 1) not in lengthlist)):
                    isBlacklisted = True
            if(isBlacklisted == False):
                goodLines.append(line)
    with open("temp", "w") as f:
        for line in goodLines:
            f.write(line) 
    os.system("mv temp words")


def getalphabet(filename): #filename would be the sys dict's location
    alphabet = []
    with open(filename) as f:
        for c in f.read():
            if c not in alphabet:
                alphabet.append(c)
    return alphabet

cdef void solveboard(spaces board[][10]): #very much in progress
    size = 10
    countslist = []
    cdef char* blackSpace = "#"
    cdef spaces boardRow[10]
    for row in range(size):
        rowString = "#"
        boardRow = board[row]
        for i in range(size):
            val = boardRow[i].value
            rowString += val
        rowString += "#"
        rowString = rowString.split('#')
        for i in rowString:
            if i == '':
                rowString.remove(i)
        for i in rowString:
            if(len(i) not in countslist):
                countslist.append(len(i))
      #  if(counts not in countslist):
       #     countslist.append(counts) 
       # if(countsVert not in countslist):
        #    countslist.append(countsVert)                               
    for y in countslist:
        if not(y in range(3, 10)):
            board[0][0].value = "!"




cdef void makeBoard(spaces board[][10]):
    cdef int side = 10
    chars = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j',' k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']
    #I think we can replace char with getalphabet applied to the sys dict
    filename = "/usr/share/dict/words"
    #chars = getalphabet(filename)
    fillIns = ['_', '#']
    cdef spaces temp
    for x in range(side):
        for y in range(side):
            temp.row = y
            temp.column = x
            val = randint(1,10)
            temp.charType = val
            board[x][y] = temp
    cdef int noncharprob = 9
    cdef int blankprob = 8
    for i in range(side):
        for j in range(side):
            if(board[i][j].charType < noncharprob):
                val = randint(1,10)
                if(val < blankprob):
                    board[i][j].value = '_'
                else:
                    board[i][j].value = '#'
            else:
                index = randint(0,25)
                board[i][j].value = chars[index]
            
    # We want to weight the fillIns more, so that they occur more often than the chars.
    # cdef struct for the board
cdef void printBoard(spaces board[][10]):
    cdef int side = 10
    rows = ["","","","","","","","","",""]
    for i in range(side):
        for j in range(side):
            rows[i] += board[i][j].value + " "
        
    for i in range(side):
        print(rows[i] + "\n")
cdef int main(int badCount):
    if(badCount > 1200):
        print("Avoiding seg fault, solvable board not found!")
        return 0
    cdef int side = 10
    cdef spaces board[10][10]
    makeBoard(board)
    #lengthlist = lenlistmaker(board)
    solveboard(board)
    cdef char* errorChar = "!"
    if(board[0][0].value == errorChar):
         badCount += 1
         printBoard(board)
      #  main(badCount)
    else:
        printBoard(board)
    return 0
cdef int badCount = 1
lengthlist = [2, 3, 4, 5, 6, 7, 8, 9, 10]
transferfile("/usr/share/dict/words", lengthlist)
main(badCount)
