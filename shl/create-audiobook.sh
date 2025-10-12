#!/bin/env bash

model="~/src/piper/models/en_US-kathleen-low.onnx"
rawBook=$(mktemp)

# First argument must be an epub file
(epub2txt "$1" | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g" >> $rawBook) && piper-tts --model $model --output-file "audiobook-$(uuidgen).wav" < $rawBook
