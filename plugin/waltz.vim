""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File:        plugin/waltz.vim
" Description: Portably map Alt key combinations
" Author:      Dario Sneidermanis <github.com/esneider>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if exists("g:loaded_waltz")
    finish
endif

let g:loaded_waltz = 1

let s:esc_mappings = get(g:, 'waltz_esc_mappings', 0)

let s:keycodes = {
\   'Up':    {'dir_up': 'A', 'literal': 'Up'   },
\   'Down':  {'dir_up': 'B', 'literal': 'Down' },
\   'Right': {'dir_up': 'C', 'literal': 'Right'},
\   'Left':  {'dir_up': 'D', 'literal': 'Left' },
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
\   'o': {'low': 'o', 'up':  '', 'mac_low': 'ø', 'mac_up': 'Ø'},
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
\   '0': {'low': '0', 'up':  '', 'mac_low': 'º', 'mac_up': '‚'},
\   '1': {'low': '1', 'up':  '', 'mac_low': '¡', 'mac_up': '⁄'},
\   '2': {'low': '2', 'up':  '', 'mac_low': '™', 'mac_up': '€'},
\   '3': {'low': '3', 'up':  '', 'mac_low': '£', 'mac_up': '‹'},
\   '4': {'low': '4', 'up':  '', 'mac_low': '¢', 'mac_up': '›'},
\   '5': {'low': '5', 'up':  '', 'mac_low': '∞', 'mac_up': 'ﬁ'},
\   '6': {'low': '6', 'up':  '', 'mac_low': '§', 'mac_up': 'ﬂ'},
\   '7': {'low': '7', 'up':  '', 'mac_low': '¶', 'mac_up': '‡'},
\   '8': {'low': '8', 'up':  '', 'mac_low': '•', 'mac_up': '°'},
\   '9': {'low': '9', 'up':  '', 'mac_low': 'ª', 'mac_up': '·'},
\}

let s:alt_lhs = {
\   'dir_up': {
\       '<Esc><Esc>[%s': 'ni',
\       '<Esc>[1;3%s': 'ni',
\       '<Esc>[1;9%s': 'ni',
\       '<Esc>[%s': 'n',
\   },
\   'literal': {
\       '<T-%s>': 'ni',
\   },
\   'low': {
\       '<Esc>%s': 'ni',
\       '<T-%s>': 'ni',
\   },
\   'mac_low': {
\       '%s': 'n',
\   },
\}

let s:alt_shift_lhs = {
\   'dir_up': {
\       '<Esc>[1;4%s':  'ni',
\       '<Esc>[1;10%s': 'ni',
\   },
\   'literal': {
\       '<T-S-%s>': 'ni',
\   },
\   'low': {
\       '<T-S-%s>': 'ni',
\   },
\   'up': {
\       '<Esc>%s': 'ni',
\   },
\   'mac_up': {
\       '%s': 'n',
\   },
\}

function s:map(cmd)

    let l:expr = a:cmd.mode
    let l:expr .= a:cmd.noremap ? 'noremap  ' : 'map '
    let l:expr .= a:cmd.silent  ? '<silent> ' : ''
    let l:expr .= a:cmd.expr    ? '<expr>   ' : ''
    let l:expr .= a:cmd.buffer  ? '<buffer> ' : ''
    let l:expr .= a:cmd.lhs . ' ' . a:cmd.rhs

    execute l:expr
endf

function s:find_lhs(lhs_dic, cmd)

    for [type, code] in items(s:keycodes[a:cmd.key])
        if !empty(code) && has_key(a:lhs_dic, type)

            for [lhs, modes] in items(a:lhs_dic[type])
                if stridx(modes, a:cmd.mode) >= 0

                    if s:esc_mappings || a:cmd.mode == 'n' || lhs !~ '^<Esc>'

                        let a:cmd.lhs = printf(lhs, code)
                        call s:map(a:cmd)
                    endif
                endif
            endfor
        endif
    endfor
endf

function s:find_mappings(format, lhs_dic)

    for mmode in split('nvoicsxl', '\zs')
        for key in keys(s:keycodes)

            silent! let l:cmd = maparg(printf(a:format, key), mmode, 0, 1)
            silent! if !empty(l:cmd)

                let l:cmd.key = key
                call s:find_lhs(a:lhs_dic, l:cmd)
            endif
        endfor
    endfor
endf

function s:apply()

    let l:save_cpo = &cpo
    set cpo&vim

    call s:find_mappings('<M-%s>', s:alt_lhs)
    call s:find_mappings('<M-S-%s>', s:alt_shift_lhs)

    let &cpo = l:save_cpo
endf

call s:apply()
