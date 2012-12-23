color desert256
set guifont=Menlo\ Regular:h12
nmap <space> <c-w><c-w>
au FocusLost * silent! wa
set foldlevelstart=99
set foldmethod=syntax
" Fuzzy finder: ignore stuff that can't be opened, and generated files
let g:fuzzy_ignore = "*.png;*.PNG;*.JPG;*.jpg;*.GIF;*.gif;vendor/**;coverage/**;tmp/**;rdoc/**"

" Strip trailing whitespace
function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Test-running stuff
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RunCurrentTest()
  let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\|_test.rb\)$') != -1
  if in_test_file
    call SetTestFile()

    if match(expand('%'), '\.feature$') != -1
      exec CorrectTestRunner() g:bjo_test_file
    elseif match(expand('%'), '_spec\.rb$') != -1
      exec CorrectTestRunner() g:bjo_test_file
    else
      exec CorrectTestRunner() g:bjo_test_file
    endif
  else
    exec CorrectTestRunner() g:bjo_test_file
  endif
endfunction

function! SetTestRunner(runner)
  let g:bjo_test_runner=a:runner
endfunction

function! RunCurrentLineInTest()
  let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\|_test.rb\)$') != -1
  if in_test_file
    call SetTestFileWithLine()
  end

  exec CorrectTestRunner() g:bjo_test_file . ":" . g:bjo_test_file_line
endfunction

function! SetTestFile()
  let g:bjo_test_file=@%
endfunction

function! SetTestFileWithLine()
  let g:bjo_test_file=@%
  let g:bjo_test_file_line=line(".")
endfunction

function! CorrectTestRunner()
  if match(expand('%'), '\.feature$') != -1
    return "!cucumber"
  elseif match(expand('%'), '_spec\.rb$') != -1
    return "!bundle exec rspec --drb --format Fuubar"
  else
    return "!ruby"
  endif
endfunction

map <Leader>cs :RScontroller
map <Leader>cv :RVcontroller
map <Leader>ms :RSmodel
map <Leader>mv :RVmodel
map <Leader>ss :AS<CR>
map <Leader>sv :AV<CR>
map <Leader>t :call RunCurrentTest()<CR>
map <Leader>vs :RVview
map <Leader>vv :RSview
map <Leader>y :call RunCurrentLineInTest()<CR>
map '' cs"'
map "" cs'"
map '; wF's:f'x
map "; wF"s:f"x
map ;" F:xcsw"
map ;' F:xcsw'
map [] F[xs.wwxx

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Macros
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let @l = 'ilet(:ea)f=xxysE{'
