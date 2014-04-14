# vim-waltz #

Waltz is a VIM plugin that provides a portable way of mapping the Alt key.

## Usage ##

Just add your Alt mappings in your vimrc, and waltz will take care of the rest.

The supported key sequences are:

```
<A-[a-z]>
<A-[0-9]>
<A-(Up|Down|Right|Left)>
<A-S-[a-z]>
<A-S-[0-9]>
<A-S-(Up|Down|Right|Left)>
```

## Examples ##

Using `Alt + Arrows` for window movements in normal mode:

```VimL
nnoremap <silent> <A-Up>    :wincmd k<CR>
nnoremap <silent> <A-Down>  :wincmd j<CR>
nnoremap <silent> <A-Left>  :wincmd h<CR>
nnoremap <silent> <A-Right> :wincmd l<CR>
```

Using `Alt + oO` to insert lines and remain in normal mode:

```VimL
nnoremap <silent> <A-o>   mzo<Esc>`z
nnoremap <silent> <A-S-o> mzO<Esc>`z
```

## Installation ##

If you don't have a preferred installation method, I recommend using
[Vundle](https://github.com/gmarik/vundle) and adding this to your vimrc:

```VimL
Bundle 'esneider/vim-waltz'
```
