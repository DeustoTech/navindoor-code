import sys

input_name = sys.argv[1]
chars = sys.argv[2:]
file = open(input_name,'r')
file_out = open('output.txt','w')

index = 0
for line in file:
	index = index + 1
	if str(index) in chars:
		next
	else:
		file_out.write(line)

