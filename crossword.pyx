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

cdef int contains(int field[], int query):
	for i in range(sizeof(field)/sizeof(int)):
		if(field[i] == query):
			return 1
	return 0
def getalphabet(filename): #filename would be the sys dict's location
	#We can borrow from or modify the C solution at the site below:
	#http://stackoverflow.com/questions/387623/find-unique-characters-in-a-file
	#nevermind. I think this is actually better:
	alphabet = []
	with open(filename) as f:
		for c in f.read():
			if c not in alphabet:
				alphabet.append(c)
	return alphabet

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
    # use random Integer to determine whether each space is char or fillIn (10% or 20% char?).
    # Randomly assign thw fillIns and then the chars
cdef void printBoard(spaces board[][10]):
	cdef int side = 10
	rows = ["","","","","","","","","",""]
	for i in range(side):
		for j in range(side):
			rows[j] += board[i][j].value + " "
        
	for i in range(side):
		print(rows[i] + "\n")
cdef int main():
	cdef int side = 10
	cdef spaces board[10][10]
	makeBoard(board)
	printBoard(board)
	return 0
main()
