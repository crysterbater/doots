1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
20
21
22
23
24
25
26
27
28
29
30
31
32
33
34
35
36
37
38
39
40
41
42
43
44
45
	
#!/usr/bin/python
 
themes = "./themes/"
 
from os import listdir, chdir
from os.path import isfile, join
from random import randrange
from time import strftime
 
import sys
 
def rec(s, m):
    if m in s:
        return s
    return rec(check(), m)
 
 
# change the theme from dark to light based on time of day
color = lambda : int(strftime("%H")) <= 16 and "light" or "dark"
 
 
 
if __name__ == "__main__":
    """
    The startup
    """
    if len(sys.argv) < 2:
        sys.exit('Usage: %s [path to termite] [path to themes]' % sys.argv[0])
 
    chdir(sys.argv[1])
    themes = len(sys.argv) > 2 and sys.argv[2] + "/" or themes
 
 
    # produce file list
    fl = [ f for f in listdir(themes) if isfile(join(themes,f)) ]
 
    check = lambda :  fl[randrange(len(fl))]
 
    with open("config", "w") as fw:
        with open("base.conf") as fr:
            for line in fr:
                fw.write(line)
        with open( themes + rec(check(), color())) as fr:
            for line in fr:
                fw.write(line)
