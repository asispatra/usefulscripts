## Convert m3u8 to mp4
```
ffmpeg -i in.m3u8 -acodec copy -vcodec copy out.mp4
```
For AAC audio you will also need to add the the bit ststream filter. (Thanks @aergistal for pointing that out)
```
ffmpeg -i in.m3u8 -acodec copy -bsf:a aac_adtstoasc -vcodec copy out.mp4
```
