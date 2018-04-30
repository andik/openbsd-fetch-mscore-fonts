#!/bin/ksh
#
# create a temporary directory change in this directory
# and run this script without arguments to download
# the ms-core-fonts from source-forge
#
# Copyright (c) 2018, Andreas Koerner
# All rights reserved.
# 
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
# 
# * Redistributions of source code must retain the above copyright notice, this
#   list of conditions and the following disclaimer.
#
# * Redistributions in binary form must reproduce the above copyright notice,
#   this list of conditions and the following disclaimer in the documentation
#   and/or other materials provided with the distribution.
# 
# * Neither the name of the copyright holder nor the names of its
#   contributors may be used to endorse or promote products derived from
#   this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

# set your preferred sourceforge-mirror here
if [ -z "$1" ]; then
	MIRROR=netix
else
	MIRROR="$1"
fi

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
	if ftp "$DLROOT/$FONT" -o $FONT
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

