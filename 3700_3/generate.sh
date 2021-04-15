#!/bin/sh

ffmpeg \
  -i ../Big_Buck_Bunny_1080_10s_30MB.mp4 \
  -f lavfi -i sine=frequency=1000 \
  -map 0 -s:v:0 416x232 -c:v:0 libx264 -g 30 -keyint_min 30 -sc_threshold 0 -b:v:0 192000 \
  -map 1                -c:a:0 aac                                          -b:a:0 48000 \
  -map 0 -s:v:1 416x232 -c:v:1 libx264 -g 30 -keyint_min 30 -sc_threshold 0 -b:v:1 384000 \
  -map 1                -c:a:1 aac                                          -b:a:1 64000 \
  -map 0 -s:v:2 640x360 -c:v:2 libx264 -g 30 -keyint_min 30 -sc_threshold 0 -b:v:2 768000 \
  -map 1                -c:a:2 aac                                          -b:a:2 96000 \
  -map 0 -s:v:3 960x540 -c:v:3 libx264 -g 30 -keyint_min 30 -sc_threshold 0 -b:v:3 1500000 \
  -map 1                -c:a:3 aac                                          -b:a:3 128000 \
  -f hls -master_pl_name master.m3u8 -hls_segment_type fmp4 -hls_playlist_type vod -hls_time 2 \
  -var_stream_map "v:0 a:0 v:1 a:1 v:2 a:2 v:3 a:3" "%v/output.m3u8"
