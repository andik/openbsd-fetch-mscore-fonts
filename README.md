# openbsd-fetch-mscore-fonts

A little script to download the MS Core Fonts. Built for OpenBSD

## Usage

```sh
$ mkdir some-temp-dir
$ cd some-temp-dir
$ ksh download-mscore-fonts.sh [Sourceforge Mirror Prefix, default is 'netidx']
$ su
....
# mkdir /usr/local/fonts/mscore
# cp *.ttf /usr/local/fonts/mscore
# vi /etc/fonts/local.conf
...
<dir>/usr/local/fonts/mscore</dir>
...
# fc-cache
```


