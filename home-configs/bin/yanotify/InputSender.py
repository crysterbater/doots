import os, sys

PIPE = "/tmp/yanotify"
if os.path.exists(PIPE):            #Only write if there is a pipe
    pipe = open(PIPE, "w")
    l = sys.argv[1:len(sys.argv)]   #Remove first arg (file name)
    pipe.write(" ".join(l))         #Join args in a string
    pipe.close()
