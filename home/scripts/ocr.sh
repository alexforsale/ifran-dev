#!/usr/bin/env bash
maim="$(command -v maim)"
notify_send="$(command -v notify-send)"
tesseract="$(command -v tesseract)"
xclip="$(command -v xclip)"

${maim} -u -s -b 5 -l -c 0.3,0.4,0.6,0.4 -d 0.1 | ${tesseract} -l eng - - | ${xclip} -selection clipboard
${notify_send} -i ebook-reader "OCR" "Saved to clipboard"
