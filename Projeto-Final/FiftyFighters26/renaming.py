#rename files

import re, os, shutil


def main():
    file_re = re.compile(r'^(.*)(_)(\d+.png)')
    nome = input('Nome: ')
    os.chdir('./graphics/' + nome)
    for filename in os.listdir():
        mo = file_re.search(filename)
        shutil.move(filename, mo.group(3))
    return


if __name__ == '__main__':
    main()
