#!/usr/bin/env bash
# This script assumes that ImageMagick is installed and the convert command is accessible via the $PATH variable

# Ensure that one argument has been passed in.
if [ ! "$#" -eq 1 ]
then
	echo -e "This script requires one argument.\\ne.g. iOS_icon_maker.sh app_icon.png"
	exit 1
fi

# Assign the argument to the path variable so it is easier to follow throughout the script.
path=$1

# Ensure that the path points to a valid file.
if [ ! -f "$path" ]
then
	echo "Path must point to a valid file."
	exit 1
fi

# This function takes in the dimension of the icon (it assumes the icon is a square) and the name of the file to save the icon to.
function createIconImage()
{
	iconDimension=$1
	iconName=$2

	convert "$path" -resize ${iconDimension}x${iconDimension}^ -gravity center -extent ${iconDimension}x${iconDimension} $iconName
}

# Create all the suggested icons for both the iPhone and iPad platforms to ensure the best appearance.
createIconImage 58 icon_spotlight_settings_2x.png
createIconImage 87 icon_spotlight_settings_3x_.png
createIconImage 80 icon_spotlight_iOS_7_9_2x.png
createIconImage 120 icon_spotlight_iOS_7_9_3x.png
createIconImage 120 icon_iphone_app_7_9_2x.png
createIconImage 180 icon_iphone_app_7_9_3x.png
#createIconImage 1024 iTunesArtwork.png

# Create icons for android
#createIconImage 72 mipmap-hdpi.png
#createIconImage 48 mipmap-mdpi.png
#createIconImage 96 mipmap-xhdpi.png
#createIconImage 144 mipmap-xxhdpi.png
