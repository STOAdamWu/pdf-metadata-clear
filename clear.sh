#!/bin/bash

#check if pkg available

if (! $(type exiftool &> /dev/null))
then
	echo 'exiftool is required yet not installed'
	echo 'For MACOS users'
	echo '        brew install exiftool'

	echo 'For Linux users'
	echo '        sudo apt-get install exiftool'
	exit 0
fi


if (! $(type qpdf &> /dev/null))
then
	echo 'qpdf is required yet not installed'
	echo 'For MACOS users'
	echo '        brew install qpdf'

	echo 'For Linux users'
	echo '        sudo apt-get install qpdf'
	exit 0
fi

#Only one argument or none is allowed
if [ $# -gt 1 ]
then
	echo 'Error : More than one argument is passed'
	exit -1
fi

#get files to process
if [ -z $1 ]
then
	files=$(find $(pwd) -name '*.pdf')
elif [ -f $1 ]
then
	files=$1
elif [ -d $1 ]
then
	files=$(find $1 -name '*.pdf')
fi

#list all file to process
echo 'Target files : '
for file in $files
do
	echo $(basename $file)
done

#confirm process
while true
do
	echo -n 'process? ([y]/n)'
	read ans
	if  [ -z $ans ]||[ $ans = 'y' ] 
	then
		break
	elif [ $ans = 'n' ]
	then
		echo 'Operation aborted'
		exit 0
	fi
	echo 'Please answer y or n'
done


#Completely remove all metadata and delete tags
for file in $files
do
	exiftool -overwrite_original -all:all= $file > /dev/null 2>&1
	qpdf --linearize $file --replace-input >/dev/null 2>&1
	rm $(dirname $file)/*.~qpdf-orig > /dev/null 2>&1
done

echo 'Successed'

