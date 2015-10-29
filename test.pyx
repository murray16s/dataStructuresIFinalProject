from libc.stdio cimport *
def main():
    cdef char* test = "Hello World!"
    pystr = test
    pystr += "\nIt's nice to see you!\n"
    test = pystr
    printf(test)
main()