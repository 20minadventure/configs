"""""""""" plugins """"""""""
" Plugins will be downloaded under the specified directory.
call plug#begin(stdpath('data').'/site/plugged')
" LINUX call plug#begin('~/.local/share/nvim/site/plugged')
" WINDO call plug#begin('~/AppData/Local/nvim/plugged')

" Declare the list of plugins.
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'jeetsukumaran/vim-pythonsense'
Plug 'wellle/targets.vim'  " richer text objects
" Plug 'rakr/vim-one'  " kolorowanie składni
" Plug 'jalvesaq/Nvim-R', {'branch': 'stable'}

" List ends here. Plugins become visible to Vim after this call.
call plug#end()


"""""""""" system clipboard """"""""""
set clipboard+=unnamedplus


"""""""""" smartcase search """"""""""
:set ignorecase
:set smartcase


"""""""""" clear highlight on pressing ESC """"""""""
nnoremap <esc> :noh<return><esc>


"""""""""" tabs or spaces """"""""""
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


"""""""""" VSCode """"""""""
if exists('g:vscode')
	function! VSCodeNotifyVisual(cmd, leaveSelection, ...)
	    let mode = mode()
	    if mode ==# 'V'
		let startLine = line('v')
		let endLine = line('.')
		call VSCodeNotifyRange(a:cmd, startLine, endLine, a:leaveSelection, a:000)
		call VSCodeCall(a:cmd)
		call VSCodeNotifyRange(a:cmd, startLine, endLine, a:leaveSelection, 0)
	    elseif mode ==# 'v' || mode ==# "\<C-v>"
		let startPos = getpos('v')
		let endPos = getpos('.')
		call VSCodeNotifyRangePos(a:cmd, startPos[1], endPos[1], startPos[2], endPos[2] + 1, a:leaveSelection, a:000)
		call VSCodeCall(a:cmd)
		call VSCodeNotifyRangePos(a:cmd, startPos[1], endPos[1], startPos[2], endPos[2] + 1, a:leaveSelection, 0)
	    else
		call VSCodeNotify(a:cmd, a:000)
	    endif
	endfunction

	xnoremap <Bslash> <Cmd>call VSCodeNotifyVisual('jupyter.execSelectionInteractive', 1)<CR><Esc>
endif
