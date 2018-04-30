# openbsd-fetch-mscore-fonts

A little script to download the MS Core Fonts. Built for OpenBSD

Please note: this script currently uses curl to download the fonts. do not run as root...

## Usage

```sh
$ mkdir some-temp-dir
$ cd some-temp-dir
$ get-core-fonts.sh
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


