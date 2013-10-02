""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File:        plugin/waltz.vim
" Description: Portably map Alt-Arrows and Alt-Shit-Arrows.
" Author:      Dario Sneidermanis <github.com/esneider>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if exists("g:loaded_waltz")
    finish
endif

let g:loaded_waltz = 1

let s:esc_mappings = get(g:, 'waltz_esc_mappings', 0)

let s:keycodes = {
\   'up':    {'dir_up': 'A', 'literal': 'Up'   },
\   'down':  {'dir_up': 'B', 'literal': 'Down' },
\   'right': {'dir_up': 'C', 'literal': 'Right'},
\   'left':  {'dir_up': 'D', 'literal': 'Left' },
\   'a': {'low': 'a', 'up': 'A', 'mac_low': 'å', 'mac_up': 'Å'},
\   'b': {'low': 'b', 'up': 'B', 'mac_low': '∫', 'mac_up': 'ı'},
\   'c': {'low': 'c', 'up': 'C', 'mac_low': 'ç', 'mac_up': 'Ç'},
\   'd': {'low': 'd', 'up': 'D', 'mac_low': '∂', 'mac_up': 'Î'},
\   'e': {'low': 'e', 'up': 'E', 'mac_low':  '', 'mac_up': '´'},
\   'f': {'low': 'f', 'up': 'F', 'mac_low': 'ƒ', 'mac_up': 'Ï'},
\   'g': {'low': 'g', 'up': 'G', 'mac_low': '©', 'mac_up': '˝'},
\   'h': {'low': 'h', 'up': 'H', 'mac_low': '˙', 'mac_up': 'Ó'},
\   'i': {'low': 'i', 'up': 'I', 'mac_low':  '', 'mac_up': 'ˆ'},
\   'j': {'low': 'j', 'up': 'J', 'mac_low': '∆', 'mac_up': 'Ô'},
\   'k': {'low': 'k', 'up': 'K', 'mac_low': '˚', 'mac_up': ''},
\   'l': {'low': 'l', 'up': 'L', 'mac_low': '¬', 'mac_up': 'Ò'},
\   'm': {'low': 'm', 'up': 'M', 'mac_low': 'µ', 'mac_up': 'Â'},
\   'n': {'low': 'n', 'up': 'N', 'mac_low':  '', 'mac_up': '˜'},
\   'o': {'low': 'o', 'up': 'O', 'mac_low': 'ø', 'mac_up': 'Ø'},
\   'p': {'low': 'p', 'up': 'P', 'mac_low': 'π', 'mac_up': '∏'},
\   'q': {'low': 'q', 'up': 'Q', 'mac_low': 'œ', 'mac_up': 'Œ'},
\   'r': {'low': 'r', 'up': 'R', 'mac_low': '®', 'mac_up': '‰'},
\   's': {'low': 's', 'up': 'S', 'mac_low': 'ß', 'mac_up': 'Í'},
\   't': {'low': 't', 'up': 'T', 'mac_low': '†', 'mac_up': 'ˇ'},
\   'u': {'low': 'u', 'up': 'U', 'mac_low':  '', 'mac_up': '¨'},
\   'v': {'low': 'v', 'up': 'V', 'mac_low': '√', 'mac_up': '◊'},
\   'w': {'low': 'w', 'up': 'W', 'mac_low': '∑', 'mac_up': '„'},
\   'x': {'low': 'x', 'up': 'X', 'mac_low': '≈', 'mac_up': '˛'},
\   'y': {'low': 'y', 'up': 'Y', 'mac_low': '\', 'mac_up': 'Á'},
\   'z': {'low': 'z', 'up': 'Z', 'mac_low': 'Ω', 'mac_up': '¸'},
\   '0': {'low': '0', 'up': ')', 'mac_low': 'º', 'mac_up': '‚'},
\   '1': {'low': '1', 'up': '!', 'mac_low': '¡', 'mac_up': '⁄'},
\   '2': {'low': '2', 'up': '@', 'mac_low': '™', 'mac_up': '€'},
\   '3': {'low': '3', 'up': '#', 'mac_low': '£', 'mac_up': '‹'},
\   '4': {'low': '4', 'up': '$', 'mac_low': '¢', 'mac_up': '›'},
\   '5': {'low': '5', 'up': '%', 'mac_low': '∞', 'mac_up': 'ﬁ'},
\   '6': {'low': '6', 'up': '^', 'mac_low': '§', 'mac_up': 'ﬂ'},
\   '7': {'low': '7', 'up': '&', 'mac_low': '¶', 'mac_up': '‡'},
\   '8': {'low': '8', 'up': '*', 'mac_low': '•', 'mac_up': '°'},
\   '9': {'low': '9', 'up': '(', 'mac_low': 'ª', 'mac_up': '·'},
\}

let s:alt_maps = {

    let &cpo = l:save_cpo
\   'dir_up': {
\       '<Esc><Esc>[%s': ['n', 'i'],
\       '<Esc>[1;3%s':   ['n', 'i'],
\       '<Esc>[1;9%s':   ['n', 'i'],
\       '<Esc>[%s':      ['n'],
\   },
\   'literal': {
\       '<T-%s>': ['n', 'i'],
\       '<M-%s>': ['n', 'i'],
\   },
\   'low': {
\       '<Esc>%s': ['n', 'i'],
\       '<T-%s>':  ['n', 'i'],
\       '<M-%s>':  ['n', 'i'],
\   },
\   'mac_low': {
\       '%s': ['n'],
\   },
\}

let s:shift_alt_maps = {
\   'dir_up': {
\       '<Esc>[1;4%s':  ['n', 'i'],
\       '<Esc>[1;10%s': ['n', 'i'],
\   },
\   'literal': {
\       '<T-S-%s>': ['n', 'i'],
\       '<M-S-%s>': ['n', 'i'],
\   },
\   'low': {
\       '<T-S-%s>': ['n', 'i'],
\       '<M-S-%s>': ['n', 'i'],
\   },
\   'up': {
\       '<Esc>%s': ['n', 'i'],
\   },
\   'mac_up': {
\       '%s': ['n'],
\   },
\}

function! s:map(maps, types, cmd)

    for [type, code] in items(a:types)
        if !empty(code) && has_key(a:maps, type)

            for [from, modes] in items(a:maps[type])
                for lmode in modes
                    if has_key(a:cmd, lmode)

                        if s:esc_mappings || lmode != 'i' || code !~ '^<Esc>'

                            let l:is_s = type(a:cmd) == 1

                            let l:expr  = lmode . 'noremap '
                            let l:expr .= l:is_s ? '' : join(a:cmd[0:-2]) . ' '
                            let l:expr .= printf(from, code) . ' '
                            let l:expr .= l:is_s ? a:cmd : a:cmd[-1]

                            execute l:expr
                        endif
                    endif
                endfor
            endfor
        endif
    endfor
endfunction

function! s:check_globals(prefix, maps)

    for [key, types] in items(s:keycodes)
        if exists('g:' . a:prefix . key)
            call s:map(a:maps, types, get(g:, a:prefix . key))
        endif
    endfor
endfunction

function! s:apply()

    let l:save_cpo = &cpo
    set cpo&vim

    call s:check_globals('waltz_alt_', s:alt_maps)
    call s:check_globals('waltz_alt_shift_', s:shift_alt_maps)
    call s:check_globals('waltz_shift_alt_', s:shift_alt_maps)

    let &cpo = l:save_cpo
endfunction

autocmd VimEnter * call s:apply()
