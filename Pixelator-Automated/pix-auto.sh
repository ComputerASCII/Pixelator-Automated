#!/bin/sh

#Introduction and user input necessary for executing Pixelator's shell command.
echo "This script allows Pixelator to create large numbers of pixelated images at once. Follow the instructions, and your images will be pixelated in no time!"
echo "Paste the pathway to the _pixelator executable here:"
read pixel_folder
echo "Paste the pathway to the raw folder here:"
read raw_folder
echo "Paste the pathway to the fried folder placeholder image here:"
read fried_folder
echo "Your pixelization pathway is: $pixel_folder"
echo "Your raw pathway is: $raw_folder"
echo "Your fried pathway is: $fried_folder"
echo "Is everything right and ready for pixelization? Y/N "
read confirmation

#if-then-else-while loop, repeating the introduction as necessary.
if [ $confirmation == "Y" ] 
then
echo "Great!"
else
while [ $confirmation != "Y" ]
do
    echo "Oh no. Try pasting it properly this time."
    echo "Paste the pathway to the _pixelator executable here:"
    read pixel_folder
    echo "Paste the pathway to the raw folder here:"
    read raw_folder
    echo "Paste the pathway to the fried folder placeholder image here:"
    read fried_folder
    echo "Your pixelization pathway is: $pixel_folder"
    echo "Your raw pathway is: $raw_folder"
    echo "Your fried pathway is: $fried_folder"
    echo "Is everything right and ready for pixelization? Y/N "
    read confirmation
done
fi

#Array created from the images within the raw folder via for-loop.
#Used to track the count of images and give them sequentially to Pixelator.
declare -a raw_image_array

for raw_image in "$raw_folder"/*
do
    raw_image_array+=("$raw_image")
done

#This is a surprise tool that will help us later!
fried_counter=0

#for-loop where the final product is made. I'll go into greater detail here.
echo "P I X E L I Z A T I O N  I N I T I A T E D"
for ria in "${raw_image_array[@]}"  #Array from earlier makes this for-loop function!
do                                  
    #Surprise! This counter keeps track of the number appended to the fried_folder.
    fried_counter=$((fried_counter+1))
    #A monstrosity that appends the fried_counter right before the file type ".", preventing new images from overwriting old ones because they have the same name.
    fried_folder_new=${fried_folder%%"."*}${fried_counter}${fried_folder#*"${fried_folder%%"."*}"}
    #The mac-daddy shell command of the whole script! Using Pixelator, it creates the image with all the settings listed here. Feel free to edit them if you know how, just don't touch the variables.
    "$pixel_folder" "$ria" "$fried_folder_new" --pixelate 5 --colors 64 --palette_mode adaptive --enhance 1.8 --smooth 0 --smooth_iterations 1 --refine_edges 250 --stroke inside --stroke_opacity 0 --stroke_on_colors_diff 0 --background "#00000000"
    #fried_folder_new has to be reset every loop, otherwise you get image files like "cookie123456789"
    fried_folder_new=$fried_folder
done
echo "Thank you for using my program. I hope it was useful for you. - William N. Nelson, April 21st, 2021"