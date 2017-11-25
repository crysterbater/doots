#!/bin/sh
scrot -t 10 -d 5 -e 'mv *.png ~/screenshots'#!/usr/bin/env python
from subprocess import check_call as cc
from os.path import expanduser as expand
import base64, requests

# install pathogen
cc([ "mkdir", "-p", expand( "~/.vim/autoload" ), expand( "~/.vim/bundle" ), expand( "~/.vim/colors" ) ])
cc([ "curl", "-LSso", expand( "~/.vim/autoload/pathogen.vim" ), "https://tpo.pe/pathogen.vim" ])

# install nerdtree
cc([ "git", "clone", "https://github.com/scrooloose/nerdtree", expand( "~/.vim/bundle/nerdtree" ) ])
# install syntastic
cc([ "git", "clone", "https://github.com/vim-syntastic/syntastic", expand( "~/.vim/bundle/syntastic" ) ])
# install yajs
cc([ "git", "clone", "https://github.com/othree/yajs.vim", expand( "~/.vim/bundle/yajs" ) ])
# install ctrl-p
cc([ "git", "clone", "https://github.com/kien/ctrlp.vim", expand( "~/.vim/bundle/ctrlp" ) ])
# install python syntax improvements
cc([ "git", "clone", "https://github.com/hdima/python-syntax", expand( "~/.vim/bundle/python-syntax" )])
# install tabular plugin
cc([ "git", "clone", "https://github.com/godlygeek/tabular", expand( "~/.vim/bundle/tabular" )])
# install markdown syntax improvements
cc([ "git", "clone", "https://github.com/plasticboy/vim-markdown", expand( "~/.vim/bundle/vim-markdown" )])
# install glsl syntax improvements
cc([ "git", "clone", "https://github.com/tikhomirov/vim-glsl", expand( "~/.vim/bundle/vim-glsl" )])
# install a decent colorscheme that works with GUI and Terminal
cc( [ "wget", "https://raw.githubusercontent.com/morhetz/gruvbox/master/colors/gruvbox.vim", "-O", expand( "~/.vim/colors/gruvbox.vim" ) ] )
# install pug syntax highlighting
cc( [ "git", "clone", "https://github.com/digitaltoad/vim-pug", expand( "~/.vim/bundle/vim-pug" )])

vimrc_b64 = """
IiBiYXNpYyBzdHVmZgpzZXQgdF9Dbz0yNTYKc3ludGF4IG9uCm
ZpbGV0eXBlIHBsdWdpbiBvbgpmaWxldHlwZSBpbmRlbnQgb24K
c2V0IHRhYnN0b3A9NApzZXQgc2hpZnR3aWR0aD00CnNldCBzb2
Z0dGFic3RvcD00CnNldCBleHBhbmR0YWIKc2V0IG51bWJlcgpz
ZXQgYmFja3NwYWNlPTIKc2V0IGJhY2tncm91bmQ9ZGFyawpzZX
QgY3Vyc29yY29sdW1uCnNldCBjdXJzb3JsaW5lCiJHVUkgb3B0
aW9ucwpzZXQgZ3Vpb3B0aW9ucy09bSAicmVtb3ZlIG1lbnUgYm
FyIgpzZXQgZ3Vpb3B0aW9ucy09VCAicmVtb3ZlIHRvb2xiYXIi
CnNldCBndWlvcHRpb25zLT1yICJyZW1vdmUgcmlnaHQtaGFuZC
BzY3JvbGwgYmFyIgpzZXQgZ3Vpb3B0aW9ucy09TCAicmVtb3Zl
IGxlZnQtaGFuZCBzY3JvbGwgYmFyIgoiIGxvYWQgaW4gYWxsIH
BsdWdpbnMgdXNpbmcgcGF0aG9nZW4KZXhlY3V0ZSBwYXRob2dl
biNpbmZlY3QoKQoiIHNldCBuZXJkdHJlZSB0b2dnbGUKbWFwID
xDLWU+IDpORVJEVHJlZVRvZ2dsZTxDUj4KIiByZW1hcCB3aW5k
b3cgbmF2aWdhdGlvbgptYXAgPEMtaj4gPEMtVz5qCm1hcCA8Qy
1rPiA8Qy1XPmsKbWFwIDxDLWg+IDxDLVc+aAptYXAgPEMtbD4g
PEMtVz5sCiIgZGVmYXVsdCBsYW5ndWFnZSBpbmRlcGVuZGVudC
BzeW50YXN0aWMgc2V0dGluZ3MKbGV0IGc6c3ludGFzdGljX2Fs
d2F5c19wb3B1bGF0ZV9sb2NfbGlzdCA9IDEKbGV0IGc6c3ludG
FzdGljX2F1dG9fbG9jX2xpc3QgPSAxCmxldCBnOnN5bnRhc3Rp
Y19jaGVja19vbl9vcGVuID0gMQpsZXQgZzpzeW50YXN0aWNfY2
hlY2tfb25fd3EgPSAwCiIgdXNlIHRoZSBlc2xpbnQgbGludGVy
IGZvciBqcyAobGV0cyB1cyB1c2UgYXN5bmMvYXdhaXQpCmxldC
BnOnN5bnRhc3RpY19qYXZhc2NyaXB0X2NoZWNrZXJzID0gWyAn
ZXNsaW50JyBdCiIgc3ludGF4IGNoZWNrIHRoZSBoZWFkZXIgZm
lsZXMKbGV0IGc6c3ludGFzdGljX2NwcF9jaGVja19oZWFkZXIg
PSAxCiIgY29uZmlndXJlIHRoZSBjbGFuZyBwYXRoIGZvciBhdX
RvLWNvbXBsZXRlCmxldCBnOmNsYW5nX2xpYnJhcnlfcGF0aCA9
ICcvTGlicmFyeS9EZXZlbG9wZXIvQ29tbWFuZExpbmVUb29scy
91c3IvbGliL2xpYmNsYW5nLmR5bGliJwoiIHN0b3AgbWFya2Rv
d24gZmlsZXMgYmVpbmcgYXV0b21hdGljYWxseSBmb2xkZWQgb2
4gb3BlbgpsZXQgZzp2aW1fbWFya2Rvd25fZm9sZGluZ19kaXNh
YmxlZCA9IDEKIiBpZ25vcmUgZmlsZXMgaW4gTkVSRFRyZWUgZX
hwbG9yZXIKbGV0IE5FUkRUcmVlSWdub3JlID0gWydcLnB5YyQn
LCAnXC5vJCcsICdcLmpzLmVzWzAtOV0kJyBdCiIgaGlkZSB0aG
UgYW5ub3lpbmcgcHJldmlldy9zY3JhdGNYaCB3aW5kb3cgdGhh
dCBjb21lcyB3aXRoIGNsYW5nX2NvbXBsZXRlCnNldCBjb21wbG
V0ZW9wdC09cHJldmlldwoiIHJlYmluZCBjdHJsLXNwYWNlIGZv
ciBlY2xpbSBhdXRvY29tcGxldAppbm9yZW1hcCA8Qy1TcGFjZT
4gPEMtWD48Qy1VPgpjb2xvciBncnV2Ym94Cg==
"""

# decode the vimrc and save
with open( expand( "~/.vimrc" ), "wb" ) as f:
f.write( base64.b64decode( vimrc_b64 ) )
