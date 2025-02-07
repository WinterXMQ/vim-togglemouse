"
" Toggle mouse plugin for quickly toggling mouse between Vim and terminal
" Maintainer:   WinterXMQ <WinterXMQ@gmail.com>(Vincent Driessen <vincent@datafox.nl>)
" Version:      Vim 7 (may work with lower Vim versions, but not tested)
" URL:          http://github.com/WinterXMQ/vim-togglemouse
"
" Only do this when not done yet for this buffer
if exists("b:loaded_toggle_mouse_plugin")
    finish
endif
let b:loaded_toggle_mouse_plugin = 1

fun! s:ToggleMouse()
    if !exists("s:old_mouse")
        let s:old_mouse = "a"
    endif

    if &mouse == ""
        let &mouse = s:old_mouse
        echo "Mouse is for Vim (" . &mouse . ")"
    else
        let s:old_mouse = &mouse
        let &mouse=""
        echo "Mouse is for terminal"
    endif
endfunction

" Add mappings, unless the user didn't want this.
" The default mapping is registered under to <F10> by default, unless the user
" remapped it already (or a mapping exists already for <F10>)
" Using `g:toggle_mouse_key` to define the mapping key.
" Using manual command to call the function.
let g:toggle_mouse_key = '<F10>'
if !exists("no_plugin_maps") && !exists("no_toggle_mouse_maps")
    if !hasmapto('<expr> '.g:toggle_mouse_key)
      nnoremap <silent> <expr> <F10> ":call <SID>ToggleMouse()\<CR>"
      nnoremap <silent> <expr> <Leader>m ":call <SID>ToggleMouse()\<CR>"
      inoremap <silent> <expr> <F10> "<Esc>:call <SID>ToggleMouse()\<CR>a"
    endif
endif
