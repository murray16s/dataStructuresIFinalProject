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

cdef void makeBoard(spaces board[][10]):
	char = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j',' k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']
	fillIns = ['_', '#']
	cdef spaces temp
	for x in range(10):
		for y in range(10):
			temp.row = y
			temp.column = x
			val = randint(1,10)
			temp.charType = val
			board[x][y] = temp
	for i in range(10):
		for j in range(10):
			if(board[i][j].charType < 9):
				val = randint(1,10)
				if(val < 8):
					board[i][j].value = '_'
				else:
					board[i][j].value = '#'
			else:
				index = randint(0,25)
				board[i][j].value = char[index]
			
    # We want to weight the fillIns more, so that they occur more often than the chars.
    # cdef struct for the board
    # use random Integer to determine whether each space is char or fillIn (10% or 20% char?).
    # Randomly assign thw fillIns and then the chars
cdef void printBoard(spaces board[][10]):
	rows = ["","","","","","","","","",""]
	for i in range(10):
		for j in range(10):
			rows[j] += board[i][j].value + " "
        
	for i in range(10):
		print(rows[i] + "\n")
cdef int main():
	cdef spaces board[10][10]
	makeBoard(board)
	printBoard(board)
	return 0
main()
