""" BEG Plugins
call plug#begin()
  " Plug 'ap/vim-buftabline'
  " Plug 'bling/vim-bufferline'
  " Plug 'ervandew/supertab'
  " Plug 'liuchengxu/eleline.vim'
  " Plug 'webdevel/tabulous'
  " Plug 'bfrg/vim-jqplay' " stopped working, saying it needs vim?
  " Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " seems nifty
  Plug 'overcache/NeoSolarized'
  Plug 'andrewradev/splitjoin.vim'
  Plug 'cespare/vim-toml'
  Plug 'dhruvasagar/vim-table-mode'
  Plug 'direnv/direnv.vim'
  Plug 'ekalinin/dockerfile.vim'
  Plug 'elzr/vim-json'
  Plug 'farmergreg/vim-lastplace'
  Plug 'google/vim-jsonnet'
  Plug 'ianks/vim-tsx'
  Plug 'kevinoid/vim-jsonc'
  Plug 'kyazdani42/nvim-web-devicons' " this is used by barbar.nvim
  Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary' }
  Plug 'liuchengxu/vim-which-key'
  Plug 'liuchengxu/vista.vim'
  Plug 'mbbill/undotree'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'puremourning/vimspector'
  Plug 'romgrk/barbar.nvim'
  Plug 'rust-lang/rust.vim'
  Plug 'shougo/echodoc'
  Plug 'tomtom/tcomment_vim'
  Plug 'tpope/vim-obsession'
  Plug 'tpope/vim-sensible'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'vimwiki/vimwiki'
  Plug 'vito-c/jq.vim'
  Plug 'yggdroot/indentline'
  Plug 'zinit-zsh/zinit-vim-syntax'
call plug#end()
""" END Plugins

"""" BEG File stuff
  filetype plugin on
  set undodir=~/.vimundo
  set undofile " Maintain undo history between sessions
  " set mouse=a
  set nowrap
  set tabstop=8 softtabstop=2 shiftwidth=2 expandtab " let's see how this works
  set formatoptions+=j  "Delete comment character when joining commented lines

  autocmd FileType json syntax match Comment +\/\/.\+$+

  augroup pyre_settings " {
    autocmd BufNewFile,BufRead *pyre_configuration* set ft=json
  augroup END " }
  autocmd FileType *pyre_configuration set ft=json

  au BufRead,BufNewFile *.sbt,*.sc set filetype=scala

  au FileType python let b:coc_root_patterns = ['pyproject.toml', 'poetry.lock', '.git', '.env', 'venv', '.venv', 'setup.cfg', 'setup.py', 'pyrightconfig.json']

  let g:vimspector_enable_mappings = 'HUMAN'

  " indentline
  let g:indentLine_setColors = 1
  let g:indentLine_char = '▏'
  " echodoc
  let g:echodoc#enable_at_startup = 1
  let g:echodoc#type = "virtual"
  " rust.vim
  let g:rust_recommended_style = 0 " stops this from overriding custom settings. still would likely be better to use editorconfig or something

  " let g:rustfmt_autosave = 1
""" END File stuff
""" BEG tab/buffers/statusline/undo

  " airline tab/buffer bar stuff- replaced with barbar for now
  " let g:airline#extensions#tabline#enabled = 1 " persistent tab/buffer bar on top
  " let g:airline#extensions#tabline#show_tab_nr = 1 " enable tab num
  " let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
  " let g:airline#extensions#tabline#buffer_idx_mode = 1
  " nmap <leader>1 <Plug>AirlineSelectTab1
  " nmap <leader>2 <Plug>AirlineSelectTab2
  " nmap <leader>3 <Plug>AirlineSelectTab3
  " nmap <leader>4 <Plug>AirlineSelectTab4
  " nmap <leader>5 <Plug>AirlineSelectTab5
  " nmap <leader>6 <Plug>AirlineSelectTab6
  " nmap <leader>7 <Plug>AirlineSelectTab7
  " nmap <leader>8 <Plug>AirlineSelectTab8
  " nmap <leader>9 <Plug>AirlineSelectTab9

  " airline line stuff, not tab/buffer bar
  let g:airline_theme='solarized'
  let g:airline_solarized_bg='dark'
  let g:airline#extensions#vista#enabled = 1

  " barbar
  let bufferline = get(g:, 'bufferline', {})
  let bufferline.animation = v:false
  " let bufferline.auto_hide = v:true

  " undotree
  let g:undotree_WindowLayout = 2 " tree and wide diff
  let g:undotree_ShortIndicators = 1 " d/s instead of day/second
  let g:undotree_SetFocusWhenToggle = 1
  let g:undotree_HelpLine = 0 " hide the 'press ? for help'
  let g:undotree_SplitWidth = 30
  let g:undotree_DiffCommand = 'diff'
""" END tab/buffers/statusline

""" BEG leaders and keybinds
  " which-key setup: leader is space. see https://github.com/liuchengxu/vim-which-key
  let g:mapleader = "\<Space>"
  let g:maplocalleader = '\'
  nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
  nnoremap <silent> <localleader> :<c-u>WhichKey  '\'<CR>
  " nnoremap <silent> g 		:<c-u>WhichKey  'g'<CR> " this overrides all g* commands, including gg

  " undotree
  nnoremap <silent> <leader><leader>u  :UndotreeToggle<cr>
  nnoremap  :UndotreeToggle<cr>

  " buffer - barbar
  " nnoremap <silent> <leader>bn :<c-u>bn<CR>
  " nnoremap <silent> <leader>bp :<c-u>bp<CR>
  " nnoremap <silent> <leader>bd :<c-u>bd<CR>

  nnoremap <silent> <leader>bs :BufferPick<CR>
  nnoremap <silent> <leader>bn :BufferNext<CR>
  nnoremap <silent> <leader>bp :BufferPrevious<CR>
  nnoremap <silent> <leader>bd :BufferClose<CR>

  " vim-clap
  " let g:clap_layout = { 'width': '67%', 'height': '33%', 'row': '33%', 'col': '17%' } " these are the defaults
  nnoremap <silent> <localleader>f :<c-u>Clap files<CR>
  nnoremap <silent> <localleader>s :<c-u>Clap grep2<CR>
  nnoremap <silent> <localleader>e :<c-u>Clap filer<CR>
  nnoremap <silent> <localleader>t :<c-u>Clap tags<CR>

  " vista
  nnoremap <silent> <leader>t :<c-u>Vista!!<CR>
  let g:vista_default_executive = 'coc'
  let g:vista_fzf_preview = ['right:50%']
  let g:vista_icon_indent = ["▸ ", ""]
  let g:vista_sidebar_width = 60
  let g:vista_keep_fzf_colors = 1

  " eleline
  " let g:eleline_slim = 0
  " let g:eleline_powerline_fonts = 1
  """ eleline+vista: show function in statusline
  " function! NearestMethodOrFunction() abort
  "   return get(b:, 'vista_nearest_method_or_function', '')
  " endfunction
  " set statusline+=%{NearestMethodOrFunction()}

  " By default vista.vim never run if you don't call it explicitly.
  "
  " If you want to show the nearest function in your statusline automatically,
  " you can add the following line to your vimrc
  " autocmd VimEnter * call vista#RunForNearestMethodOrFunction()
""" END leaders and keybinds

""" BEG init from https://github.com/neoclide/coc.nvim
  " TextEdit might fail if hidden is not set.
  set hidden

  " Some servers have issues with backup files, see #649.
  set nobackup
  set nowritebackup
  set noswapfile

  " Give more space for displaying messages.
  set cmdheight=2

  " Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
  " delays and poor user experience.
  set updatetime=300

  " Don't pass messages to |ins-completion-menu|.
  set shortmess+=c

  " Always show the signcolumn, otherwise it would shift the text each time
  " diagnostics appear/become resolved.
  set signcolumn=yes

  " Use tab for trigger completion with characters ahead and navigate.
  " NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
  " other plugin before putting this into your config.

  " NOTE:this is an alternavite to the supertab plugin and was recommended
  " in the coc.vim documentation.
  " inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : coc#refresh()
  inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
  let g:coc_snippet_next = '<tab>'
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  " Use <c-space> to trigger completion.
  inoremap <silent><expr> <c-space> coc#refresh()

  " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
  " position. Coc only does snippet and additional edit on confirm.
  if has('patch8.1.1068')
    " Use `complete_info` if your (Neo)Vim version supports it.
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
  else
    imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
  endif

  " nmap <leader>ts :let &scrolloff=999-&scrolloff<CR>
  nmap <leader>ts :let &scrolloff=999-&scrolloff<CR>

  " Use `[g` and `]g` to navigate diagnostics
  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)

  " GoTo code navigation.
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

  " Use K to show documentation in preview window.
  nnoremap <silent> K :call <SID>show_documentation()<CR>

  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
      call CocActionAsync('doHover')
    else
      execute '!' . &keywordprg . " " . expand('<cword>')
    endif
  endfunction

  " function! s:show_documentation()
  "   if (index(['vim','help'], &filetype) >= 0)
  "     execute 'h '.expand('<cword>')
  "   else
  "     call CocAction('doHover')
  "   endif
  " endfunction

  " Highlight the symbol and its references when holding the cursor.
  autocmd CursorHold * silent call CocActionAsync('highlight')

  " Symbol renaming.
  nmap <leader>rn <Plug>(coc-rename)
  " Refactor window
  nmap <leader>re  <Plug>(coc-refactor)

  """ floating window stuff
  " if there is a floating window(K or something), C-f will scroll that window
  nnoremap <expr><C-f> coc#float#has_float() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <expr><C-b> coc#float#has_float() ? coc#float#scroll(0) : "\<C-b>"
  " Jump to floating window, then you can use vim stuff in there. :q quits it
  nmap <leader>fj  <Plug>(coc-float-jump)
  " Hide floating windows
  nmap <leader>fh  <Plug>(coc-float-hide)

  " Formatting selected code.
  xmap <leader>f  <Plug>(coc-format-selected)
  nmap <leader>f  <Plug>(coc-format-selected)

  augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  augroup end

  " Applying codeAction to the selected region.
  " Example: `<leader>aap` for current paragraph
  xmap <leader>a  <Plug>(coc-codeaction-selected)
  nmap <leader>a  <Plug>(coc-codeaction-selected)

  " Remap keys for applying codeAction to the current line.
  nmap <leader>ac  <Plug>(coc-codeaction)
  " Apply AutoFix to problem on the current line.
  nmap <leader>qf  <Plug>(coc-fix-current)

  " Introduce function text object
  " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
  xmap if <Plug>(coc-funcobj-i)
  xmap af <Plug>(coc-funcobj-a)
  omap if <Plug>(coc-funcobj-i)
  omap af <Plug>(coc-funcobj-a)

  " Use <TAB> for selections ranges.
  " NOTE: Requires 'textDocument/selectionRange' support from the language server.
  " coc-tsserver, coc-python are the examples of servers that support it.
  " nmap <silent> <TAB> <Plug>(coc-range-select)
  " xmap <silent> <TAB> <Plug>(coc-range-select)

  " Add `:Format` command to format current buffer.
  command! -nargs=0 Format :call CocActionAsync('format')

  " Add `:Fold` command to fold current buffer.
  command! -nargs=? Fold :call     CocAction('fold', <f-args>)

  " Add `:OR` command for organize imports of the current buffer.
  command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

  " Add (Neo)Vim's native statusline support.
  " NOTE: Please see `:h coc-status` for integrations with external plugins that
  " provide custom statusline: lightline.vim, vim-airline.
  set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

  " Mappings using CoCList:
  " Show all diagnostics.
  nnoremap <silent> <leader><leader>a  :<C-u>CocList diagnostics<cr>
  " Manage extensions.
  nnoremap <silent> <leader><leader>e  :<C-u>CocList extensions<cr>
  " Show commands.
  nnoremap <silent> <leader><leader>c  :<C-u>CocList commands<cr>
  " Find symbol of current document.
  nnoremap <silent> <leader><leader>o  :<C-u>CocList outline<cr>
  " Search workspace symbols.
  nnoremap <silent> <leader><leader>s  :<C-u>CocList -I symbols<cr>
  " Do default action for next item.
  nnoremap <silent> <leader><leader>j  :<C-u>CocNext<CR>
  " Do default action for previous item.
  nnoremap <silent> <leader><leader>k  :<C-u>CocPrev<CR>
  " Resume latest coc list.
  nnoremap <silent> <leader><leader>p  :<C-u>CocListResume<CR>

  nnoremap <silent> <leader><leader>f  :call CocAction('format')<CR>
""" END init

""" BEG neosolarized stuff
  set termguicolors
  colorscheme NeoSolarized
  set background=dark
  " Default value is "normal", Setting this option to "high" or "low" does use the
  " same Solarized palette but simply shifts some values up or down in order to
  " expand or compress the tonal range displayed.
  let g:neosolarized_contrast = "high"

  " Special characters such as trailing whitespace, tabs, newlines, when displayed
  " using ":set list" can be set to one of three levels depending on your needs.
  " Default value is "normal". Provide "high" and "low" options.
  let g:neosolarized_visibility = "normal"

  " I make vertSplitBar a transparent background color. If you like the origin
  " solarized vertSplitBar style more, set this value to 0.
  let g:neosolarized_vertSplitBgTrans = 1

  " If you wish to enable/disable NeoSolarized from displaying bold, underlined
  " or italicized" typefaces, simply assign 1 or 0 to the appropriate variable.
  " Default values:
  let g:neosolarized_bold = 1
  let g:neosolarized_underline = 1
  let g:neosolarized_italic = 1

  " Used to enable/disable "bold as bright" in Neovim terminal. If colors of bold
  " text output by commands like `ls` aren't what you expect, you might want to
  " try disabling this option. Default value:
  let g:neosolarized_termBoldAsBright = 1
""" END

"""coc extensions
  let g:coc_global_extensions = ['coc-json', 'coc-diagnostic', 'coc-sh', 'coc-pyright', 'coc-highlight', 'coc-prettier', 'coc-toml', 'coc-tsserver', 'coc-yaml', 'coc-pydocstring', 'coc-rust-analyzer', 'coc-snippets']
"""

" this is after the plugins load so it overrides the setting from
" elzr/vim-json in the ftdetect/json.vim stuff where it looks for *.template
" and sets the filetype to json
autocmd BufNewFile,BufRead *.service.template setlocal filetype=systemd
