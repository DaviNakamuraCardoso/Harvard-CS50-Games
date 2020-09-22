import os, zipfile, shutil, send2trash


def main():
    os.chdir('./graphics')
    path = os.getcwd()
    #move_zip(os.getcwd())
    #delete_zip(path)
    #extrac_zip(path)
    standard_icons()

    return


def delete_zip(path):
    for filename in os.listdir(path):
        if filename.endswith('.zip') and filename.startswith('Play'):
            send2trash.send2trash(filename)
    return


def move_zip(path):
    os.chdir('/home/davi/Downloads')
    for filename in os.listdir():
        if filename.startswith('PlayStation') and filename.endswith('.zip'):
            shutil.copy(filename, path)
            zip_file = zipfile.ZipFile(os.path.join(path, filename))
            zip_file.extractall()

    return


def extrac_zip(path):
    for filename in os.listdir(path):
        if filename.endswith('.zip'):
            zip_file = zipfile.ZipFile(filename)
            zip_file.extractall()
            zip_file.close()
    return


def standard_icons():
    icons = ['1001.png']
    for dir in os.listdir():
        for icon in icons:
            if icon not in os.listdir(dir):
                shutil.copy('Clark/' + icon, dir)
                print(f"{icon} copied to {dir}")
    return


if __name__ == '__main__':
    main()
