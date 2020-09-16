#rename files

import re, os, shutil


def main():
    rename()
    return


def rename():
    file_re = re.compile(r'^(.*)(_)(\d+.png)')
    os.chdir('./graphics')
    for dir in os.listdir():
        for filename in os.listdir(dir):
            if mo := file_re.search(filename): # WAAAAALRUS!!!
                print(dir + '/' + filename)
                shutil.move(dir + '/' + filename, dir + '/' + mo.group(3))
    return


if __name__ == '__main__':
    main()
