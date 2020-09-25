from PIL import Image
import os
import send2trash
import re


def main():
    resize(sys.argv[1:], 'body.png')
    return


def crop(image, xo, yo, x, y):
    """
    Takes a Image and crops it
    """
    if image.endswith('.png'):
        print(f'Cropping {image}...')
        image_reader = Image.open(image)
        portrait = image_reader.crop((xo, yo, x, y))
        portrait.save('portrait.png')
    return


def delete_crops():
    for filename in os.listdir():
        if filename.endswith('portrait.png'):
            send2trash.send2trash(filename)
            #print(f'Deleting {filename}...')
    return


def resize(image, new_name):
    os.chdir('/home/davi/Documents/Code/Harvard-CS50-Games/Projeto-Final/FiftyFighters26/graphics/' + image)
    image_reader = Image.open('0.png')
    width, height = image_reader.size
    new_image = image_reader.resize((int(width*1.5), int(height*1.5)))
    new_image.save(new_name)
    print(f'Cropping {image}...')
    return


def little_resize(character):

    os.chdir('/home/davi/Documents/Code/Harvard-CS50-Games/Projeto-Final/FiftyFighters26/graphics/' + character)
    if 'portrait.png' in os.listdir():
        resize('portrait.png', 20, 15, 'new_portrait.png')
    return


def big_resize(character):
    os.chdir('/home/davi/Documents/Code/Harvard-CS50-Games/Projeto-Final/FiftyFighters26/graphics/' + character)
    if '0.png' in os.listdir():
        resize('0.png', 200, 170, 'body.png')
    return


def crop_tall(character, xcrop, ycrop):
    os.chdir('/home/davi/Documents/Code/Harvard-CS50-Games/Projeto-Final/FiftyFighters26/graphics/' + character)
    image_re = re.compile(r'\d+.png')
    for filename in os.listdir():
        if image := image_re.search(filename): # WALRUS! WALRUS! WALRUS!
            reader = Image.open(image.group(0))
            width, height = reader.size
            if int(height) > 20:
                print(f"Cropping {image.group(0)}")
                new_image = reader.crop((0, 0, int(width-xcrop), int(height-ycrop)))
                new_image.save(image.group(0))
            else:
                print(f"Couldn't crop {image.group(0)}")
    return


if __name__ == '__main__':
    main()
