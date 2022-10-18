if exists("$VIRTUAL_ENV")
    if has('win64')
        let s:python3_venv_path = "$VIRTUAL_ENV/Scripts/python.exe"
        if !empty(glob(s:python3_venv_path))
            let g:python3_host_prog = s:python3_venv_path
        endif
    elseif has('unix') || has('mac')
        let s:python3_venv_path = "$VIRTUAL_ENV/bin/python3"
        if !empty(glob(s:python3_venv_path))
            let g:python3_host_prog = s:python3_venv_path
        endif
    endif
endif
