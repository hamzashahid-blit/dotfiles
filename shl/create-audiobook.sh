#!/bin/env bash

model="~/src/piper/models/en_US-kathleen-low.onnx"
rawBook=$(mktemp)

# First argument must be an epub file
(epub2txt -n "$1" >> $rawBook) && piper-tts --model $model --output-file "audiobook-$(uuidgen).wav" < $rawBook
