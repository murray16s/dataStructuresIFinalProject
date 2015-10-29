from libc.stdio cimport *
def main():
    cdef char* test = "Hello World!"
    pystr = test
    pystr += "\nIt's nice to see you!\n\n\n"
    test = pystr
    printf(test)
    printf("We have to go back...\n\n\nTo the future!!!\n")
main()