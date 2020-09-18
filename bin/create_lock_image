#! /bin/sh

# Take a screenshot of the desktop and apply a gaussian blur to create
# an image to use for the lock screen.

grim /tmp/_sway_lock_image.png
ffmpeg -i /tmp/_sway_lock_image.png -filter_complex "gblur=sigma=50" /tmp/sway_lock_image.png -y
