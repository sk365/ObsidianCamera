# ObsidianCamera
Mobile camera functionality for Obsidian via desktop folder action

This script and setup offer a way to quickly create camera notes and store them in your Obsidian vault via Dropbox or similar cloud service and a Mac (or Linux) computer

## Installation

1. In your Dropbox, create a folder "inbox"
2. Download the Dropbox apps to your mobile and to your computer
3. On your computer, create a symbolic link to your Obsidian vault ``` ln -s  ~/Dropbox/inbox /path/to/your/obsidian_vault ```
4. On your computer, create a folder _resources in your Obsidian vault. ```mkdir /path/to/your/obsidian_vault/resources```
5. Download inbox_Obsidian_folder_action.sh from repository to your computer
6. On your Mac, create a new Automator folder action for your Drobbox folder "inbox". Select execute shell script and paste in the content of inbox_Obsidian_folder_action.sh
7. On Linux, the same result can be attained with a simple [watch](https://linux.die.net/man/1/watch) shell script

## Usage

1. In your mobile Dropbox app, open folder "inbox". Select take photo or scan document.
2. Store result as jpg or pdf. Name the image file as you wish to entitle your Obsidian note. 
3. Optional: Add @target_folder and a list of tags (#tag1 #tag2 ...) to image file name before the extension. 
4. When Dropbox  downloads the image file, the script will automatically:
* create an Obsidian note named as the image file
*  move the note into target_folder if such folder exists in your Obsidian vault
*  tag the note with your list of tags 
*  move the image file into folder _resources of the Obsidian vault
*  link the image file to the note such that the image appears in the note
