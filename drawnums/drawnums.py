'''
Adds numbers to a sprite sheet for easy reference.
'''
from PIL import Image
from PIL import ImageFont
from PIL import ImageDraw

import sys


def main(*argv):
    
    file_path = sys.argv[1]
    file_name = sys.argv[2]
    tiles_wide = int(sys.argv[3])
    tiles_high = int(sys.argv[4])
    tile_size = int(sys.argv[5])

     # replace 'tiles.png' with your sprite sheet
    img = Image.open(file_path)
    draw = ImageDraw.Draw(img)

    # custom small font, good for small tile sets
    font = ImageFont.truetype('04B_03__.TTF', 8)
    
    # keep track of which tile we're adding text to
    counter = 1

    for y in range(tiles_high):
        for x in range(tiles_wide):
            draw.text((x * tile_size + 1, y * tile_size), str(counter), (0, 0, 0), font=font)
            draw.text((x * tile_size, y * tile_size + 1), str(counter), (0, 0, 0), font=font)
            draw.text((x * tile_size, y * tile_size), str(counter), (255, 0, 255), font=font)
            counter += 1
    
    # save as renamed tile sheet
    img.save(file_name)

if __name__ == '__main__':
    main()