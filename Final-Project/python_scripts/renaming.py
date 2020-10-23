#rename files

import re, os, shutil
import sys

def main():
    #rename()
    #reorder('./graphics/Ai')
    rename()
    #for dir in os.listdir():
    #    new_portrait(dir)
    #return


def rename():
    dirs = sys.argv[1:]
    file_re = re.compile(r'^(.*)(_)(\d+.png)')
    os.chdir('./graphics')
    for dir in dirs:
        for filename in os.listdir(dir):
            if mo := file_re.search(filename): # WAAAAALRUS!!!
                print(f"Renaming {filename} to {mo.group(3)}")
                shutil.move(dir + '/' + filename, dir + '/' + mo.group(3))
    return


def reorder(path):
    files = []
    os.chdir(path)
    files = os.listdir()

    for i in range(len(files)):

            new_name = files[i].strip('.png')
            files[i] = int(new_name)


    files.sort()

    counter = 0
    for file in files:
        old_name = str(file) + '.png'
        new_name = str(counter) + '.png'
        shutil.move(old_name, new_name)
        print('Passing ' + old_name + ' to ' + new_name + '...')
        counter += 1
    return


def new_portrait(dir):
    if 'img.png' in os.listdir(dir):
        shutil.move(dir + '/img.png', 'portrait.png')
    return


if __name__ == '__main__':
    main()
