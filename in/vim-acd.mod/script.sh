#!/bin/bash
#
# Script para configurar lo mas posible vim para el usuario.
# Actualmente los plugins están ya descargados y dentro de box/
# Otra opción seria descargarlos de internet para minimizar en tamaño del "script"
# comentados antes de cada copia estan los wget
# 

I=`dirname $0`

if [ ! -d $HOME/.vim/spell ]; then
	mkdir -p $HOME/.vim/spell
fi

wget -cv http://ftp.vim.org/vim/runtime/spell/es.latin1.spl --directory-prefix="$HOME/.vim/spell"
wget -cv http://ftp.vim.org/vim/runtime/spell/es.latin1.sug --directory-prefix="$HOME/.vim/spell"
wget -cv http://ftp.vim.org/vim/runtime/spell/es.utf-8.sug --directory-prefix="$HOME/.vim/spell"
wget -cv http://ftp.vim.org/vim/runtime/spell/es.utf-8.spl --directory-prefix="$HOME/.vim/spell"

if [ ! -d $HOME/.vim/plugin ]; then
	mkdir -p $HOME/.vim/plugin
fi

vim-addons install "colors sampler pack"
vim-addons install debPlugin
vim-addons install nerd-commenter
vim-addons install surround
vim-addons install latex-suite

# Auto Wordcomplete
cp -v $I/box/word_complete.vim $HOME/.vim/plugin

# Comprueba la sintaxis de PHP al guardar (:w)
cp -v $I/box/php_check_syntax.vim $HOME/.vim/plugin

# Zencoding (ex: html>body+head>div#unaid + Ctrl+y + , )
cp -v $I/box/zencoding-vim.zip $HOME/.vim
unzip $HOME/.vim/zencoding-vim.zip -d $HOME/.vim

# Bash support
cp -v $I/box/bash-support.zip $HOME/.vim
unzip $HOME/.vim/bash-support.zip -d $HOME/.vim

# Set config
if [ -f $HOME/.vimrc ]; then
	cp -a $HOME/.vimrc $HOME/.vimrc_backup
fi

cp -rfv $I/box/vimrc $HOME/.vimrc

