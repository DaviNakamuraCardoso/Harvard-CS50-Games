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
        image1_width, image1_height = image1.size
        image2_width, image2_height = image2.size
        new_image = image1.copy()
        new_image.paste(image2, (int(image1_width - image2_width), 0), image2)
        new_image.save(str(1001 + counter) + '.png')
        counter += 1
    return


if __name__ == '__main__':
    main()
