#fusion.py

from PIL import Image
import sys
import os


def main():
    if len(sys.argv) < 4:
        print('Incorrect number of command line arguments\nUse: <character> <start> <end>')
    else:
        character = sys.argv[1]
        start = int(sys.argv[2])
        end = int(sys.argv[3])
        os.chdir('graphics/' + character)
        fusion(start, end)
    return


def fusion(start, end):
    counter = start
    for i in range(start, end, 2):
        image1 = Image.open(str(i) + '.png').convert("RGBA")
        image2 = Image.open(str(i+1) + '.png').convert("RGBA")
        new_image = image2.copy()
        new_image.paste(image1, (0, 0), image1)
        new_image.save(str(1001 + counter) + '.png')
        counter += 1
    return


if __name__ == '__main__':
    main()
