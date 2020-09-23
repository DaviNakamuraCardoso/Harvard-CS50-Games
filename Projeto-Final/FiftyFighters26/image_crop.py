from PIL import Image
import os
import send2trash
import re


def main():
    for character in os.listdir('graphics'):
        if not character.endswith('.png'):
            little_resize(character)

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


def resize(image, new_width, new_height, new_name):
    image_reader = Image.open(image)
    width, height = image_reader.size
    new_image = image_reader.resize((int(new_width*1.5), int(new_height*1.5)))
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


if __name__ == '__main__':
    main()
