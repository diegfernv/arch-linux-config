#!/bin/bash

song_info=$(playerctl -i brave metadata --format '{{title}}      {{artist}}')

echo "$song_info" 
