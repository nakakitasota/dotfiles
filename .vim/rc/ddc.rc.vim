call ddc#custom#patch_global('ui', 'pum')
call ddc#custom#patch_global('sources', [
    \ 'lsp', 'around', 'file'])

call ddc#custom#patch_global('sourceOptions', {
    \ '_': {
    \   'matchers': ['matcher_head'],
    \   'sorters': ['sorter_rank'],
    \   'minAutoCompleteLength': 1,
    \ },
    \ 'lsp': {
    \   'mark': 'L',
    \   'forceCompletionPattern': '\.\w*|:\w*|->\w*',
    \ },
    \ 'around': {
    \   'mark': 'A',
    \ },
    \ 'file': {
    \   'mark': 'F',
    \   'isVolatile': v:true,
    \   'forceCompletionPattern': '\S/\S*',
    \ }})

call ddc#custom#patch_global('sourceParams', {
    \ 'lsp': {
    \     'snippetEngine': denops#callback#register({
    \         body -> vsnip#anonymous(body)
    \     }),
    \     'enableResolveItem': v:true,
    \     'enableAdditionalTextEdit': v:true,
    \ }})

call ddc#custom#patch_filetype(
    \ ['ps1', 'dosbatch', 'autohotkey', 'registry'], {
    \ 'sourceOptions': {
    \   'file': {
    \     'forceCompletionPattern': '\S\/\S*',
    \   },
    \ },
    \ 'sourceParams': {
    \   'file': {
    \     'mode': 'unix',
    \   },
    \ }})

call ddc#enable()
