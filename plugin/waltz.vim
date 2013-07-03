" Default options

let s:alt_cmds       = [':wincmd k<CR>', ':wincmd j<CR>', ':wincmd l<CR>', ':wincmd h<CR>']
let s:shift_alt_cmds = ['',              '',              ':tabnext<CR>',  ':tabprev<CR>' ]

let s:alt_cmds       = get(g:, 'waltz_alt_cmds', s:alt_cmds)
let s:shift_alt_cmds = get(g:, 'waltz_shift_alt_cmds', s:shift_alt_cmds)
let s:dir_keys       = get(g:, 'waltz_dir_keys', 0)
let s:esc_mappings   = get(g:, 'waltz_esc_mappings', 0)
let s:leave_insert   = get(g:, 'waltz_leave_insert', 0)

" Alt-{Up,Right,Down,Left} mappings

let s:alt_maps = [
\   [0, ['n', 'i'], '<Esc><Esc>[%s', ['A', 'B', 'C', 'D']],
\   [0, ['n'],      '<Esc>[%s',      ['A', 'B', 'C', 'D']],
\   [0, ['n', 'i'], '<Esc>[1;3%s',   ['A', 'B', 'C', 'D']],
\   [0, ['n', 'i'], '<Esc>[1;9%s',   ['A', 'B', 'C', 'D']],
\   [0, ['n', 'i'], '<T-%s>',        ['Up', 'Down', 'Right', 'Left']],
\   [0, ['n', 'i'], '<M-%s>',        ['Up', 'Down', 'Right', 'Left']],
\   [1, ['n', 'i'], '<Esc>%s',       ['k', 'j', 'l', 'h']],
\   [1, ['n'],      '%s',            ['˚', '∆', '¬', '˙']],
\   [1, ['n', 'i'], '<T-%s>',        ['k', 'j', 'l', 'h']],
\   [1, ['n', 'i'], '<M-%s>',        ['k', 'j', 'l', 'h']]
\]

" Alt-Shift-{Up,Right,Down,Left} mappings

let s:shift_alt_maps = [
\   [0, ['n', 'i'], '<Esc>[1;4%s',  ['A', 'B', 'C', 'D']],
\   [0, ['n', 'i'], '<Esc>[1;10%s', ['A', 'B', 'C', 'D']],
\   [0, ['n', 'i'], '<T-S-%s>',     ['Up', 'Down', 'Right', 'Left']],
\   [0, ['n', 'i'], '<M-S-%s>',     ['Up', 'Down', 'Right', 'Left']],
\   [1, ['n', 'i'], '<Esc>%s',      ['K', 'J', 'L', 'H']],
\   [1, ['n'],      '%s',           ['', 'Ô', 'Ó', 'Ò']],
\   [1, ['n', 'i'], '<T-S-%s>',     ['k', 'j', 'l', 'h']],
\   [1, ['n', 'i'], '<M-S-%s>',     ['k', 'j', 'l', 'h']]
\]

" Vim mappings

function! s:map(maps, cmds)
    let l:prep = {'n': '', 'i': s:leave_insert ? '<Esc>' : '<C-O>'}
    for [keys, modes, code, dirs] in a:maps
        if s:dir_keys == 2 || keys == s:dir_keys
            for lmode in modes
                if s:esc_mappings || lmode != 'i' || code !~ '^<Esc>'
                    for pos in range(len(a:cmds))
                        if len(a:cmds[pos])
                            execute lmode . 'noremap <silent> ' . printf(code, dirs[pos]) . ' ' . l:prep[lmode] . a:cmds[pos]
                        endif
                    endfor
                endif
            endfor
        endif
    endfor
endfunction

call s:map(s:alt_maps, s:alt_cmds)
call s:map(s:shift_alt_maps, s:shift_alt_cmds)

