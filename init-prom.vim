" Plugins will be downloaded under the specified directory.
call plug#begin('~/.local/share/nvim/site/plugged')
 
" Declare the list of plugins.
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'rakr/vim-one'  " kolorowanie składni
Plug 'jalvesaq/Nvim-R', {'branch': 'stable'}
Plug 'jeetsukumaran/vim-pythonsense'
 
" List ends here. Plugins become visible to Vim after this call.
call plug#end()
 
 
""" https://unix.stackexchange.com/questions/63196/in-vim-how-can-i-automatically-determine-whether-to-use-spaces-or-tabs-for-inde
" By default, use spaced tabs.
set expandtab
 
" Display tabs as 4 spaces wide. When expandtab is set, use 4 spaces.
set shiftwidth=4
set tabstop=4
 
function TabsOrSpaces()
    " Determines whether to use spaces or tabs on the current buffer.
    if getfsize(bufname("%")) > 256000
        " File is very large, just use the default.
        return
    endif
 
    let numTabs=len(filter(getbufline(bufname("%"), 1, 250), 'v:val =~ "^\\t"'))
    let numSpaces=len(filter(getbufline(bufname("%"), 1, 250), 'v:val =~ "^ "'))
 
    if numTabs > numSpaces
        setlocal noexpandtab
    endif
endfunction
 
" Call the function after opening a buffer
autocmd BufReadPost * call TabsOrSpaces()
