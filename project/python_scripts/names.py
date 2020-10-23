import os

array = os.listdir('./graphics')
array.sort()
for filename in array:
    print('-', filename)
