import sys

print sys.argv[0]
print sys.argv[1]
fdin = open(sys.argv[1],"r")
fdout = open(sys.argv[1]+"_new","w")

x = fdin.readline()
k1 = []
k2 = []
n = 1
while x != "" :
    if x[0:3] == "end" or x.find("pragma") != -1 :
        k1 += ["\n"+x]
        # print x
    else:
        fdout.write(x)
    x = fdin.readline()
    #n = x.split(" ")
    #print len(n)
fdout.write("\nprivate\n\n")
for i in range(0,len(k1)) :
    fdout.write(k1[i])

fdin.close()
fdout.close()

    
