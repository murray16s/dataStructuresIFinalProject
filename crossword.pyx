from libc.stdio cimport *
from math import *
from random import randint
from libc.stdlib cimport malloc, free

cdef struct space:
    int row
    int column
    char* value
    int charType
ctypedef space spaces

cdef spaces* makeBoard():
    char = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j',' k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']
    fillIns = ['_', '#']
    cdef spaces *board = <spaces *>malloc(100*sizeof(spaces))
    cdef spaces temp
    cdef int i = 0
    while(i < 100):
        for x in range(10):
            for y in range(10):
                temp.row = y
                temp.column = x
                val = randint(1,10)
                temp.charType = val
                board[i] = temp
                i += 1
    for i in range(100):
        if(board[i].charType < 9):
            val = randint(1,10)
            if(val < 8):
                board[i].value = '_'
            else:
                board[i].value = '#'
        else:
            index = randint(0,25)
            board[i].value = char[index]
    # We want to weight the fillIns more, so that they occur more often than the chars.
    # cdef struct for the board
    # use random Integer to determine whether each space is char or fillIn (10% or 20% char?).
    # Randomly assign thw fillIns and then the chars
    return board
cdef void printBoard(spaces* board):
    rows = ["","","","","","","","","",""]
    for i in range(100):
        rows[board[i].row] += board[i].value + " "
        
    for i in range(10):
        print(rows[i] + "\n")
cdef int main():
    cdef spaces *board = makeBoard()
    printBoard(board)
    return 0
main()