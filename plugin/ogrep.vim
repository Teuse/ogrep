
function! s:DoOgrep(grepString)
    silent execute "grep " . shellescape(a:grepString) . " ."
    copen
endfunction

"set grepprg=ag\ --ignore-case\ --ignore={*.pyc,*.json\} --ignore-dir={build*}\ --anr\ --vimgrep\ $* 
set grepprg=ag\ --ignore-case\ --vimgrep\ $* 
set grepformat=%f:%l:%m

command! -nargs=+ Ogrep call <SID>DoOgrep('<args>')

nnoremap <leader>gr :Ogrep <right>
nnoremap <leader>g  :set operatorfunc=<SID>GrepOperator<cr>g@
vnoremap <leader>g  :<c-u>call <SID>GrepOperator(visualmode())<cr>


function! s:GrepOperator(type)
    let saved_unnamed_register = @@

    if a:type ==# 'v'
        execute "normal! `<v`>y"
    elseif a:type ==# 'char'
        execute "normal! `[v`]y"
    else
        return
    endif

    call <SID>DoOgrep(@@)
    let @@ = saved_unnamed_register
endfunction


