#!/usr/bin/env bash

# Dotfiles

echo "Linking dotfiles..."
overwrite_all=false

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

for file in $DIR/files/*; do
  overwrite=false

  basename=${file##*/}
  target="$HOME/.$basename"


  if [ -e "$target" ] || [ -L "$target" ]; then
    if ! $overwrite_all; then
      while true; do
        echo "$target already exists"
        printf "[s]kip, [S]kip all, [o]verwrite, [O]verwrite all: "
        read answer
        case $answer in
          "s") continue 2;;
          "S") break 2;;
          "o") overwrite=true; break;;
          "O") overwrite_all=true; break;;
           * ) continue;;
        esac
      done
    fi
  fi

  if [ -e "$target" ] || [ -L "$target" ]; then
    rm $target
  fi

  ln -svs "$file" "$target"
done
