import os, zipfile, shutil, send2trash


def main():
    os.chdir('./graphics')
    for filename in os.listdir():
        if filename.endswith('.zip') and filename.startswith('Play'):
            send2trash.send2trash(filename)
    return


main()
