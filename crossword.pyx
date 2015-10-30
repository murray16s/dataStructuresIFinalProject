from libc.stdio cimport *
from math import *
from random import randint
from libc.stdlib cimport malloc, free

cdef struct space:
    int row
    int column
    char value
    int charType
ctypedef space spaces

def makeBoard():
    char = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j',' k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']
    fillIns = ['_', '#']
    cdef spaces *board = <spaces *>malloc(100*sizeof(spaces))
    cdef spaces temp
    for i in range(100):
        for x in range(10):
            for y in range(10):
                temp.row = y
                temp.column = x
                val = randint(1,10)
                temp.charType = val
                board[i] = temp
        if(board[i].charType < 8):
            board[i].charType = 0
        else:
            board[i].charType = 1
                
    for i in range(100):
        printf("The value of space %d is: %d\n", i, board[i].charType)
    # We want to weight the fillIns more, so that they occur more often than the chars.
    # cdef struct for the board
    # use random Integer to determine whether each space is char or fillIn (10% or 20% char?).
    # Randomly assign thw fillIns and then the chars
cdef int main():
    makeBoard()
    return 0
main()