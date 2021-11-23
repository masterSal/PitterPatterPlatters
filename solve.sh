#!/bin/bash
# author: @masterSal

# image file type identifier
IMAGE_IDENTIFIER="filesystem data"



print_error() {
	echo "[-] $1"
	exit
}


options() {

	echo -e "\t- list (lists files on the image)\n\t- inode [number] (to describe file inode)\n\t- get [block number]\n\t- options (display options)\n\t- rev [string]\n\t- exit"

}



# check the command line args
if [ "$#" -ne 1 ]; then
	print_error "You must specify an image file."
fi

# check if the file type is an image type
if [[ "$(file $1)" != *$IMAGE_IDENTIFIER* ]]; then
	print_error "The file '$1' is not an image file"
fi


CHOICE=""

options

while [ 1 ];
do
	echo -ne "\n> "
	read CHOICE

	if [[ "$CHOICE" == "exit" ]] || [[ "$CHOICE" == "EXIT" ]]; then exit; fi


	case $CHOICE in
		"list" | "LIST")
			fls -a $1
			;;
		*"inode"* | *"INODE"*)
			inode=$(echo $CHOICE | cut -d ' ' -f 2)
			istat $1 $inode
			;;
		*"get"* | *"GET"*)
			block=$(echo $CHOICE | cut -d ' ' -f 2)
			blkcat $1 $block
			;;
		*"rev"* | *"REV"*)
			str=$(echo $CHOICE | cut -d ' ' -f 2)
			echo $str | rev
			;;
		"options" | "OPTIONS")
			options
			;;
		"") ;;
		*)
			echo "--> '$CHOICE' is an invalid command!"
			;;
	esac

done



