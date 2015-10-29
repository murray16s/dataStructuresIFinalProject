from libc.stdio cimport *
from math import *
cdef int main():
    
    return 0
def makeBoard():
    char = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j',' k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']
    fillIns = ['_', '#']
    # We want to weight the fillIns more, so that they occur more often than the chars.
    # cdef struct for the board
    # use random Integer to determine whether each space is char or fillIn (10% or 20% char?).
    # Randomly assign thw fillIns and then the chars
    pass