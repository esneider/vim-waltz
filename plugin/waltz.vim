" Default options

let s:esc_mappings = get(g:, 'waltz_esc_mappings', 0)
let s:leave_insert = get(g:, 'waltz_leave_insert', 0)

" Move through tabs with Alt-Shift-{Right,Left}

let s:tab_cmds = [':tabnext<CR>', ':tabprev<CR>']

let s:tab_maps = [
\   [['n', 'i'], '<Esc>[1;4%s',  ['C', 'D']],
\   [['n', 'i'], '<Esc>[1;10%s', ['C', 'D']],
\   [['n', 'i'], '<T-S-%s>',     ['Right', 'Left']],
\   [['n', 'i'], '<M-S-%s>',     ['Right', 'Left']]
\]

" Move through windows with Alt-{Up,Right,Down,Left}

let s:win_cmds = [':wincmd k<CR>', ':wincmd j<CR>', ':wincmd l<CR>', ':wincmd h<CR>']

let s:win_maps = [
\   [['n', 'i'], '<Esc><Esc>[%s', ['A',  'B',  'C', 'D']],
\   [['n'],      '<Esc>[%s',      ['A',  'B',  'C', 'D']],
\   [['n', 'i'], '<Esc>[1;9%s',   ['A',  'B',  'C', 'D']],
\   [['n', 'i'], '<Esc>[1;3%s',   ['A',  'B',  'C', 'D']],
\   [['n', 'i'], '<T-%s>',        ['Up', 'Down', 'Right', 'Left']],
\   [['n', 'i'], '<M-%s>',        ['Up', 'Down', 'Right', 'Left']]
\]

" Vim mappings

function! s:map(maps, list)
    let l:prep = {'n': '', 'i': s:leave_insert ? '<Esc>' : '<C-O>'}
    for [modes, code, dir] in a:maps
        for lmode in modes
            if s:esc_mappings || lmode != 'i' || code !~ '^<Esc>'
                for pos in range(len(a:list))
                    execute lmode . 'noremap <silent> ' . printf(code, dir[pos]) . ' ' . l:prep[lmode] . a:list[pos]
                endfor
            endif
        endfor
    endfor
endfunction

call s:map(s:tab_maps, s:tab_cmds)
call s:map(s:win_maps, s:win_cmds)

