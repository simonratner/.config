if exists("g:moria_style")
    let s:moria_style = g:moria_style
else
    let s:moria_style = &background
endif

if exists("g:moria_fontface")
    let s:moria_fontface = g:moria_fontface
else
    let s:moria_fontface = "plain"
endif

execute "command! -nargs=1 Colo let g:moria_style = \"<args>\" | colo moria"

if s:moria_style == "black" || s:moria_style == "dark" || s:moria_style == "darkslategray"
    set background=dark
elseif s:moria_style == "light" || s:moria_style == "white"
    set background=light
else
    let s:moria_style = &background 
endif

hi clear

if exists("syntax_on")
    syntax reset
endif

let colors_name = "moria"

if &background == "dark"
    if s:moria_style == "darkslategray"
        hi Normal   ctermbg=238	 ctermfg=252	 cterm=none

        hi CursorColumn ctermbg=238	 cterm=none
        hi CursorLine ctermbg=238	 cterm=none
        hi FoldColumn  ctermbg=bg	 ctermfg=152	 cterm=none
        hi LineNr ctermfg=152	 cterm=none
        hi NonText  ctermbg=bg	 ctermfg=152	 cterm=bold
        hi Pmenu ctermbg=109	 ctermfg=0	 cterm=none
        hi PmenuSbar ctermbg=66	 ctermfg=fg	 cterm=none
        hi PmenuThumb ctermbg=188	 ctermfg=bg	 cterm=none
        hi SignColumn  ctermbg=bg	 ctermfg=152	 cterm=none
        hi StatusLine   ctermbg=66	 ctermfg=fg	 cterm=bold
        hi StatusLineNC   ctermbg=240	 ctermfg=fg	 cterm=none
        hi TabLine ctermbg=66	 ctermfg=fg	 cterm=underline
        hi TabLineFill ctermbg=66	 ctermfg=fg	 cterm=underline
        hi VertSplit   ctermbg=240	 ctermfg=fg	 cterm=none
        if version >= 700
            hi Visual   ctermbg=66	 cterm=none
        else
            hi Visual   ctermbg=66	 ctermfg=fg	 cterm=none
        endif
        hi VisualNOS ctermbg=bg	 ctermfg=109	 cterm=bold,underline

        if s:moria_fontface == "mixed"
            hi Folded ctermbg=240	 ctermfg=188	 cterm=bold
        else
            hi Folded ctermbg=240	 ctermfg=188	 cterm=none
        endif
    else
        if s:moria_style == "dark"
            hi Normal   ctermbg=235	 ctermfg=252	 cterm=none

            hi CursorColumn ctermbg=238	 cterm=none
            hi CursorLine ctermbg=238	 cterm=none
        elseif s:moria_style == "black"
            hi Normal   ctermbg=0	 ctermfg=252	 cterm=none

            hi CursorColumn ctermbg=237	 cterm=none
            hi CursorLine ctermbg=237	 cterm=none
        endif
        hi FoldColumn  ctermbg=bg	 ctermfg=110	 cterm=none
        hi LineNr ctermfg=110	 cterm=none
        hi NonText  ctermbg=bg	 ctermfg=110	 cterm=bold
        hi Pmenu ctermbg=67	 ctermfg=0	 cterm=none
        hi PmenuSbar ctermbg=60	 ctermfg=fg	 cterm=none
        hi PmenuThumb ctermbg=252	 ctermfg=bg	 cterm=none
        hi SignColumn  ctermbg=bg	 ctermfg=110	 cterm=none
        hi StatusLine   ctermbg=240	 ctermfg=fg	 cterm=bold
        hi StatusLineNC   ctermbg=237	 ctermfg=fg	 cterm=none
        hi TabLine ctermbg=60	 ctermfg=fg	 cterm=underline
        hi TabLineFill ctermbg=60	 ctermfg=fg	 cterm=underline
        hi VertSplit   ctermbg=237	 ctermfg=fg	 cterm=none
        if version >= 700
            hi Visual   ctermbg=60	 cterm=none
        else
            hi Visual   ctermbg=60	 ctermfg=fg	 cterm=none
        endif
        hi VisualNOS ctermbg=bg	 ctermfg=103	 cterm=bold,underline

        if s:moria_fontface == "mixed"
            hi Folded ctermbg=240	 ctermfg=252	 cterm=bold
        else
            hi Folded ctermbg=240	 ctermfg=252	 cterm=none
        endif
    endif
    hi Cursor ctermbg=214	 ctermfg=bg	 cterm=none
    hi DiffAdd ctermbg=28	 ctermfg=fg	 cterm=none
    hi DiffChange ctermbg=18	 ctermfg=fg	 cterm=none
    hi DiffDelete ctermbg=88	 ctermfg=fg	 cterm=none
    hi DiffText ctermbg=20	 ctermfg=fg	 cterm=bold
    hi Directory ctermbg=bg	 ctermfg=33	 cterm=none
    hi ErrorMsg ctermbg=9	 ctermfg=15	 cterm=bold
    hi IncSearch ctermbg=186	 ctermfg=0	 cterm=none
    hi ModeMsg ctermbg=bg	 ctermfg=fg	 cterm=bold
    hi MoreMsg ctermbg=bg	 ctermfg=111	 cterm=bold
    hi PmenuSel ctermbg=184	 ctermfg=0	 cterm=none
    hi Question ctermbg=bg	 ctermfg=180	 cterm=bold
    hi Search ctermbg=114	 ctermfg=0	 cterm=none
    hi SpecialKey ctermbg=bg	 ctermfg=180	 cterm=none
    if has("spell")
        hi SpellBad ctermbg=bg ctermfg=196 cterm=undercurl
        hi SpellCap ctermbg=bg ctermfg=202 cterm=undercurl
        hi SpellLocal ctermbg=bg ctermfg=220 cterm=undercurl
        hi SpellLRare ctermbg=bg ctermfg=220 cterm=undercurl
    endif
    hi TabLineSel ctermbg=bg	 ctermfg=fg	 cterm=bold
    hi Title   ctermfg=fg	 cterm=bold
    hi WarningMsg ctermbg=bg	 ctermfg=9	 cterm=bold
    hi WildMenu ctermbg=184	 ctermfg=0	 cterm=bold

    hi Comment ctermbg=bg	 ctermfg=187	 cterm=none
    hi Constant ctermbg=bg	 ctermfg=113	 cterm=none
    hi Error ctermbg=bg	 ctermfg=9	 cterm=none
    hi Identifier ctermbg=bg	 ctermfg=116	 cterm=none
    hi Ignore ctermbg=bg	 ctermfg=bg	 cterm=none
    hi lCursor ctermbg=40	 ctermfg=0	 cterm=none
    hi MatchParen ctermbg=30	 cterm=none
    hi PreProc ctermbg=bg	 ctermfg=182	 cterm=none
    hi Special ctermbg=bg	 ctermfg=180	 cterm=none
    hi Todo ctermbg=184	 ctermfg=0	 cterm=none
    hi Underlined ctermbg=bg	 ctermfg=39	 cterm=underline    

    if s:moria_fontface == "mixed"
        hi Statement ctermbg=bg	 ctermfg=111	 cterm=bold
        hi Type ctermbg=bg	 ctermfg=210	 cterm=bold
    else
        hi Statement ctermbg=bg	 ctermfg=111	 cterm=none
        hi Type ctermbg=bg	 ctermfg=210	 cterm=none
    endif

    hi htmlBold   ctermbg=bg	 ctermfg=fg	 cterm=bold
    hi htmlItalic   ctermbg=bg	 ctermfg=fg	 cterm=italic
    hi htmlUnderline   ctermbg=bg	 ctermfg=fg	 cterm=underline
    hi htmlBoldItalic   ctermbg=bg	 ctermfg=fg	 cterm=bold,italic
    hi htmlBoldUnderline   ctermbg=bg	 ctermfg=fg	 cterm=bold,underline
    hi htmlBoldUnderlineItalic   ctermbg=bg	 ctermfg=fg	 cterm=bold,underline,italic
    hi htmlUnderlineItalic   ctermbg=bg	 ctermfg=fg	 cterm=underline,italic
elseif &background == "light"
    if s:moria_style == "light"
        hi Normal   ctermbg=7	 ctermfg=0	 cterm=none

        hi CursorColumn ctermbg=188	 cterm=none
        hi CursorLine ctermbg=188	 cterm=none
    elseif s:moria_style == "white"
        hi Normal   ctermbg=15	 ctermfg=0	 cterm=none

        hi CursorColumn ctermbg=253	 cterm=none
        hi CursorLine ctermbg=253	 cterm=none
    endif
    hi Cursor ctermbg=94	 ctermfg=bg	 cterm=none
    hi DiffAdd ctermbg=28	 ctermfg=15	 cterm=none
    hi DiffChange ctermbg=18	 ctermfg=15	 cterm=none
    hi DiffDelete ctermbg=88	 ctermfg=15	 cterm=none
    hi DiffText ctermbg=20	 ctermfg=15	 cterm=bold
    hi Directory ctermbg=bg	 ctermfg=4	 cterm=none
    hi ErrorMsg ctermbg=9	 ctermfg=15	 cterm=bold
    hi FoldColumn  ctermbg=bg	 ctermfg=60	 cterm=none
    hi Folded ctermbg=251	 ctermfg=237	 cterm=bold
    hi IncSearch ctermbg=222	 cterm=none
    hi LineNr ctermfg=60	 cterm=none
    hi ModeMsg   ctermbg=bg	 ctermfg=fg	 cterm=bold
    hi MoreMsg ctermbg=bg	 ctermfg=24	 cterm=bold
    hi NonText  ctermbg=bg	 ctermfg=60	 cterm=bold
    hi Pmenu ctermbg=103	 ctermfg=0	 cterm=none
    hi PmenuSbar ctermbg=67	 ctermfg=fg	 cterm=none
    hi PmenuSel ctermbg=11	 ctermfg=0	 cterm=none
    hi PmenuThumb ctermbg=146	 ctermfg=fg	 cterm=none
    hi Question ctermbg=bg	 ctermfg=94	 cterm=bold
    hi Search ctermbg=157	 cterm=none
    hi SignColumn  ctermbg=bg	 ctermfg=60	 cterm=none
    hi SpecialKey ctermbg=bg	 ctermfg=88	 cterm=none
    if has("spell")
        hi SpellBad guisp=#ee2c2c cterm=undercurl
        hi SpellCap guisp=#2c2cee cterm=undercurl
        hi SpellLocal guisp=#008b8b cterm=undercurl
        hi SpellRare guisp=#ee2cee cterm=undercurl
    endif
    hi StatusLine   ctermbg=110	 ctermfg=fg	 cterm=bold
    hi StatusLineNC   ctermbg=146	 ctermfg=fg	 cterm=none
    hi TabLine ctermbg=146	 ctermfg=fg	 cterm=underline
    hi TabLineFill ctermbg=146	 ctermfg=fg	 cterm=underline
    hi TabLineSel ctermbg=bg	 ctermfg=fg	 cterm=bold
    hi Title ctermfg=fg	 cterm=bold
    hi VertSplit   ctermbg=146	 ctermfg=fg	 cterm=none
    if version >= 700
        hi Visual   ctermbg=252	 cterm=none
    else
        hi Visual   ctermbg=252	 ctermfg=fg	 cterm=none
    endif    
    hi VisualNOS ctermbg=bg	 ctermfg=103	 cterm=bold,underline
    hi WarningMsg ctermbg=bg	 ctermfg=9	 cterm=bold
    hi WildMenu ctermbg=11	 ctermfg=fg	 cterm=bold

    hi Comment ctermbg=bg	 ctermfg=94	 cterm=none
    hi Constant ctermbg=bg	 ctermfg=28	 cterm=none
    hi Error ctermbg=bg	 ctermfg=9	 cterm=none
    hi Identifier ctermbg=bg	 ctermfg=24	 cterm=none
    hi Ignore ctermbg=bg	 ctermfg=bg	 cterm=none
    hi lCursor ctermbg=28	 ctermfg=15	 cterm=none
    hi MatchParen ctermbg=14	 cterm=none
    hi PreProc ctermbg=bg	 ctermfg=90	 cterm=none
    hi Special ctermbg=bg	 ctermfg=88	 cterm=none
    hi Statement ctermbg=bg	 ctermfg=24	 cterm=bold
    hi Todo ctermbg=11	 ctermfg=fg	 cterm=none
    hi Type ctermbg=bg	 ctermfg=88	 cterm=bold
    hi Underlined ctermbg=bg	 ctermfg=20	 cterm=underline

    hi htmlBold ctermbg=bg	 ctermfg=fg	 cterm=bold
    hi htmlItalic ctermbg=bg	 ctermfg=fg	 cterm=italic
    hi htmlUnderline ctermbg=bg	 ctermfg=fg	 cterm=underline
    hi htmlBoldItalic ctermbg=bg	 ctermfg=fg	 cterm=bold,italic
    hi htmlBoldUnderline ctermbg=bg	 ctermfg=fg	 cterm=bold,underline
    hi htmlBoldUnderlineItalic ctermbg=bg	 ctermfg=fg	 cterm=bold,underline,italic
    hi htmlUnderlineItalic ctermbg=bg	 ctermfg=fg	 cterm=underline,italic
endif
