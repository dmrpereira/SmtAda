import sys, re

def cap_func_proc(s):
    l = ""
    if s[-1] == '(':
        s = s[0:len(s)-1]
    x = s.split("_")
    for i in range(len(x)-1):
        l += x[i].capitalize()+"_"
    l += x[len(x)-1].capitalize()
    return l

def process_pragma(x):
    print x
    r = re.compile("pragma\s+(\w+)\s*\(\s*(.*)\s*\,\s*(.*)\s*\,\s*(.*)\s*\)\s*;")
    l = r.findall(x)
    print len(l)
    s = "pragma "
    s += l[0][0]+"("
    s += l[0][1]+","
    s += cap_func_proc(l[0][2])+","
    s += l[0][3]+") ;"
    print s

def process_args(x):

    l = r.findall(x)
    print len(l)
                   

def process_procedure(x):
    return None

def process_function(x):
    #print x
    r = re.compile("(\w+)(.*)")
    k = r.findall(x)
    # Function name
    print "=> ",cap_func_proc(k[0][0])
    # Now process the rest
    s = k[0][1].strip()
    if s != '':
        if s[0] == '(':
            for m in re.finditer("\s*(\w*)\s*:\s*([\w\d\.\s]*[\w\d])\s*",s):
                print "Arg1 => ", m.groups()
        else:
            print "No args available"


fdi = open(sys.argv[1],"r")
#fdo = open(sys.argv[2],"w+")

x = None
data = list()

final = []

x = fdi.readline()
while x != '':
    # remove prefix and trailing spaces
    x = x.strip()
    if x[0:2] != "--":
        # if x[0:6] == "pragma":
        #     print "Begin PRAGMA:"
        #     process_pragma(x)
        #     print "End PRAGMA"
        if x[0:8] == "function":
            print "\nBegin FUNCTION:"
            process_function(x[9:].strip())
            print "End FUNCTION\n"
    x = fdi.readline()

fdi.close()
#fdo.close()


