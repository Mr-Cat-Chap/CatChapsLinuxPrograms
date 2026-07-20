#! /bin/bash

#I want to be able to paste a link for a movie in, pick if it's a TV show or movie, give it the name, then it downloads it, once it's downloaded it finds or creates the folder for it, renames the file in case it comes with a weird name like 0, then it moves it to the correct folder. If possible sending a notification to my phone when it finishes would be awesome, there might be an ability to do that using KDE Connect

#Note 1: Turns out you can just specify the name of a file when it's downloaded!

#First we get the info

Download="Empty"
Name="Empty"
Season="Empty"
Episode="Empty"
NameSE="Empty"
SE="Empty"
Type="Empty"
FileLocation="Empty"
LocationToSave="Empty"
whoami=$(whoami)
JellyfinFiles="/home/$whoami/Jellyfin Server Media/"

#Get the download link
echo "Download link for content"
read -p ": " Download

#All this gets the type of content and checks to make sure the input was correct

function gettype() {
#Movie or TV show
echo "For movie press 1, for TV show press 2"
read -p ": " Type
}

gettype

until [[ $Type == "1" || $Type == "2" ]] do

    echo "Input type not correct, try again"
    echo "Input was $Type"
    gettype

done

#Get the content name
echo "Name of movie or series"
read -p ": " Name

if [[ $Type == 2 ]] then

    echo "TV show selected"
    echo "Specify season with two numbers i.e. 01"
    read -p ": " Season

    echo "Now specify episode, i.e. 01"
    read -p ": " Episode

fi

#Collected all the information from the user, now I need to download it, rename it and put it in the right folder

#Specify the path to save the file to

if [[ $Type == "1" ]] then

    LocationToSave="$JellyfinFiles$Name/Movies"
    echo $LocationToSave

    else

    #TV shows are saved in their shows folder, their season folder, then each season folder is full of the season's episodes
    LocationToSave="$JellyfinFiles/TVShows/$Name/Season $Season/"
    echo $LocationToSave

fi

if [[ $Type == "1" ]] then

    #Download the file and name itg
    wget -O "$LocationToSave$Name.mkv" $Download

    else

    NameSE="$Name S${Season}E${Episode}"
    wget -O "$LocationToSave$NameSE.mkv" $Download

fi
