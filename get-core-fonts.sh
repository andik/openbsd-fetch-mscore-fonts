#!/bin/ksh

# create a temporary directory change in this directory
# and run this script without arguments to download
# the ms-core-fonts from source-forge
#
# (c) 2018 A. Koerner
#
# released under CC0 Licence
#

# set your preferred sourceforge-mirror here
MIRROR=netix

DLROOT="https://$MIRROR.dl.sourceforge.net/project/corefonts/the%20fonts/final"

FONTS=" \
andale32.exe \
arial32.exe  \
arialb32.exe \
comic32.exe  \
courie32.exe \
georgi32.exe \
impact32.exe \
times32.exe  \
trebuc32.exe \
verdan32.exe \
webdin32.exe \
"

# get the fonts and extract them after getting them
for FONT in $FONTS
do
	echo "GET $DLROOT/$FONT"
	if curl -s "$DLROOT/$FONT" -o $FONT
	then
		cabextract $FONT
	fi
done

# rename fonts to lower case
for FONT in *.TTF
do
	LOWERCASE=$(echo $FONT  | tr '[A-Z]' '[a-z]')
	if [ $LOWERCASE != $FONT ]
	then
		mv -f $FONT $LOWERCASE
	fi
done

# show licence
echo By installing this fonts you agree to the following EULA:
echo ----------------------------------------------------
cat Licen.TXT

# Print how-to-install
echo 'run as root:'
echo '------------'
echo 'mkdir /usr/local/share/fonts/mscore'
echo 'mv *.ttf /usr/local/share/fonts/mscore'
echo ''
echo 'then add "/usr/local/share/fonts/mscore'
echo 'to /etc/fonts/local.conf'
echo ''
echo 'then run fc-cache as root'


# remove stuff
STUFF=" ADVPACK.DLL Licen.TXT W95INF32.DLL andale32.exe arialb32.exe \
courie32.exe fontinst.inf impact32.exe trebuc32.exe webdin32.exe \
FONTINST.EXE W95INF16.DLL andale.inf   arial32.exe  comic32.exe  \
fontinst.exe georgi32.exe times32.exe  verdan32.exe 
"
for FILE in $STUFF
do
	rm -f $FILE
done

