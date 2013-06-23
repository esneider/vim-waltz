" Default options

let s:dir_keys     = get(g:, 'waltz_dir_keys', 0)
let s:esc_mappings = get(g:, 'waltz_esc_mappings', 0)
let s:leave_insert = get(g:, 'waltz_leave_insert', 0)

" Move through tabs with Alt-Shift-{Right,Left}

let s:tab_cmds = [':tabnext<CR>', ':tabprev<CR>']

let s:tab_maps = [
\   [0, ['n', 'i'], '<Esc>[1;4%s',  ['C', 'D']],
\   [0, ['n', 'i'], '<Esc>[1;10%s', ['C', 'D']],
\   [0, ['n', 'i'], '<T-S-%s>',     ['Right', 'Left']],
\   [0, ['n', 'i'], '<M-S-%s>',     ['Right', 'Left']],
\   [1, ['n', 'i'], '<Esc>%s',      ['L', 'H']],
\   [1, ['n'],      '%s',           ['Ó', 'Ò']],
\   [1, ['n', 'i'], '<T-S-%s>',     ['l', 'h']],
\   [1, ['n', 'i'], '<M-S-%s>',     ['l', 'h']]
\]

" Move through windows with Alt-{Up,Right,Down,Left}

let s:win_cmds = [':wincmd k<CR>', ':wincmd j<CR>', ':wincmd l<CR>', ':wincmd h<CR>']

let s:win_maps = [
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

" Vim mappings

function! s:map(maps, cmds)
    let l:prep = {'n': '', 'i': s:leave_insert ? '<Esc>' : '<C-O>'}
    for [keys, modes, code, dirs] in a:maps
        if s:dir_keys == 2 || keys == s:dir_keys
            for lmode in modes
                if s:esc_mappings || lmode != 'i' || code !~ '^<Esc>'
                    for pos in range(len(a:cmds))
                        execute lmode . 'noremap <silent> ' . printf(code, dirs[pos]) . ' ' . l:prep[lmode] . a:cmds[pos]
                    endfor
                endif
            endfor
        endif
    endfor
endfunction

call s:map(s:tab_maps, s:tab_cmds)
call s:map(s:win_maps, s:win_cmds)

