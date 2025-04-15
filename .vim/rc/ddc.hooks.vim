" hook_source {{{
let s:config_path = expand('~/.vim/rc') .. '/ddc.ts'
call ddc#custom#load_config(s:config_path)
call ddc#enable()
" }}}
