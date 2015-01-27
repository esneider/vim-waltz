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
\}

let s:alt_shift_lhs = {
\   'dir_up': {
\       '<Esc>[1;4%s':  'ni',
\       '<Esc>[1;10%s': 'ni',
\   },
\   'literal': {
\       '<T-S-%s>': 'ni',
\   },
\}

function s:map(cmd)

    let l:expr  = a:cmd.mode
    let l:expr .= get(a:cmd, 'noremap') ? 'noremap '  : 'map '
    let l:expr .= get(a:cmd, 'silent' ) ? '<silent> ' : ''
    let l:expr .= get(a:cmd, 'expr'   ) ? '<expr> '   : ''
    let l:expr .= get(a:cmd, 'buffer' ) ? '<buffer> ' : ''
    let l:expr .= get(a:cmd, 'nowait' ) ? '<nowait> ' : ''
    let l:expr .= a:cmd.lhs . ' ' . a:cmd.rhs

    execute l:expr
endf

function s:find_lhs(cmd, key, lhs_dic)

    for [type, code] in items(s:keycodes[a:key])
        if !empty(code) && has_key(a:lhs_dic, type)

            for [lhs, modes] in items(a:lhs_dic[type])
                if stridx(modes, a:cmd.mode) >= 0

                    if s:esc_mappings || a:cmd.mode == 'n' || lhs !~? '^<Esc>'

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

            let lhs = printf(a:format, key)
            let rhs = maparg(lhs, mmode)

            if !empty(rhs)

                " This is an imperfect approximation to the full maparg(), but
                " the last parameter of maparg(), dict, was added pretty
                " recently (vim 7.3.032), so we need a backup solution.
                let cmd = {
                \   'rhs': rhs,
                \   'mode': mmode,
                \   'noremap': 1,
                \}

                " Since this might not work (see above) we have to use silent.
                silent! let cmd = maparg(lhs, mmode, 0, 1)

                call s:find_lhs(cmd, key, a:lhs_dic)
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
