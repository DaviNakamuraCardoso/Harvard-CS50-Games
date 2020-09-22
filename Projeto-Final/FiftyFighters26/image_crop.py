from PIL import Image
import os
import send2trash
import re


def main():
    os.chdir('./graphics/CSEL')
    #resize('Clark.png', 200, 170)
    #delete_crops()
    #for filename in os.listdir():
    #    crop(filename)
    #resize('Character_little_Adelheid_portrait.png', 20, 15)
    resize('little_Elizabeth_portrait.png', 20, 15)
#    for image in os.listdir():
#        if image.startswith('Character_'):
#            print(f"Resizing {image} to {image.strip('Character_')}...")

    return


def crop(image):
    """
    Takes a Image and crops it
    """
    if image.endswith('.png'):
        print(f'Cropping {image}...')
        image_reader = Image.open(image)
        big_portrait = image_reader.crop((0, 0, 180, 220))
        little_portrait = image_reader.crop((180, 220, 220, 250))
        character = image.strip('.png')
        big_portrait.save('big_' + character + '_portrait.png')
        little_portrait.save('little_' + character + 'portrait.png')
    return


def delete_crops():
    for filename in os.listdir():
        if filename.endswith('portrait.png'):
            send2trash.send2trash(filename)
            #print(f'Deleting {filename}...')
    return


def resize(image, new_width, new_height):
    image_reader = Image.open(image)
    width, height = image_reader.size
    new_image = image_reader.resize((int(new_width), int(new_height)))
    new_image.save(image)
    print(f'Cropping {image}...')
    return


if __name__ == '__main__':
    main()
