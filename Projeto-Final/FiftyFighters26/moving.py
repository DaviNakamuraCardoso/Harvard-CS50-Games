import os, zipfile, shutil, send2trash


def main():
    os.chdir('./graphics')
    #move_zip(current_cd)
    delete_zip()
    #extrac_zip()

    return




def delete_zip():
    for filename in os.listdir():
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


def extrac_zip():
    for filename in os.listdir():
        if filename.endswith('.zip'):
            zip_file = zipfile.ZipFile(filename)
            zip_file.extractall()
            zip_file.close()
    return

if __name__ == '__main__':
    main()
