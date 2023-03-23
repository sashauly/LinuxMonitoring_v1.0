#!/bin/bash

source ./color.conf

export column1_background=$column1_background
export column1_font_color=$column1_font_color
export column2_background=$column2_background
export column2_font_color=$column2_font_color

chmod +x ./color.sh
./color.sh
