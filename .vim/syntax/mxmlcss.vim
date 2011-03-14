" Vim syntax file
" Language:	Cascading Style Sheets
" Maintainer:	Claudio Fleiner <claudio@fleiner.com>
" URL:		http://www.fleiner.com/vim/syntax/css.vim
" Last Change:	2006 Jun 19
" CSS2 by Nikolai Weibull
" Full CSS2, HTML4 support by Yeti

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if !exists("main_syntax")
  if version < 600
    syntax clear
  elseif exists("b:current_syntax")
  finish
endif
  let main_syntax = 'css'
endif

syn case ignore

syn match cssSelectorOp "[+>.]"
syn match cssSelectorOp2 "[~|]\?=" contained
syn region cssAttributeSelector matchgroup=cssSelectorOp start="\[" end="]" transparent contains=cssUnicodeEscape,cssSelectorOp2,cssStringQ,cssStringQQ

try
syn match cssIdentifier "#[A-Za-zÀ-ÿ_@][A-Za-zÀ-ÿ0-9_@-]*"
catch /^.*/
syn match cssIdentifier "#[A-Za-z_@][A-Za-z0-9_@-]*"
endtry

syn match cssValueInteger contained "[-+]\=\d\+"
syn match cssValueNumber contained "[-+]\=\d\+\(\.\d*\)\="
syn match cssValueLength contained "[-+]\=\d\+\(\.\d*\)\=\(%\|mm\|cm\|in\|pt\|pc\|em\|ex\|px\)"
syn match cssValueAngle contained "[-+]\=\d\+\(\.\d*\)\=\(deg\|grad\|rad\)"
syn match cssValueTime contained "+\=\d\+\(\.\d*\)\=\(ms\|s\)"
syn match cssValueFrequency contained "+\=\d\+\(\.\d*\)\=\(Hz\|kHz\)"

syn match cssUnicodeRange contained "U+[0-9A-Fa-f?]\+"
syn match cssUnicodeRange contained "U+\x\+-\x\+"

syn keyword cssColor contained aqua black blue fuchsia gray green lime maroon navy olive purple red silver teal yellow
" FIXME: These are actually case-insentivie too, but (a) specs recommend using
" mixed-case (b) it's hard to highlight the word `Background' correctly in
" all situations
syn case match
syn keyword cssColor contained ActiveBorder ActiveCaption AppWorkspace ButtonFace ButtonHighlight ButtonShadow ButtonText CaptionText GrayText Highlight HighlightText InactiveBorder InactiveCaption InactiveCaptionText InfoBackground InfoText Menu MenuText Scrollbar ThreeDDarkShadow ThreeDFace ThreeDHighlight ThreeDLightShadow ThreeDShadow Window WindowFrame WindowText Background
syn case ignore
syn match cssColor contained "\<transparent\>"
syn match cssColor contained "\<white\>"
syn match cssColor contained "#[0-9A-Fa-f]\{3\}\>"
syn match cssColor contained "#[0-9A-Fa-f]\{6\}\>"
"syn match cssColor contained "\<rgb\s*(\s*\d\+\(\.\d*\)\=%\=\s*,\s*\d\+\(\.\d*\)\=%\=\s*,\s*\d\+\(\.\d*\)\=%\=\s*)"

syn region cssURL contained matchgroup=cssFunctionName start="\<url\s*(" end=")" oneline keepend
syn region cssFunction contained matchgroup=cssFunctionName start="\<\(rgb\|clip\|attr\|counter\|rect\|embed\|classreference\)\s*(" end=")" oneline keepend

syn match cssImportant contained "!\s*important\>"

syn match cssFont contained "\<\(sans-\)\=\<serif\>"
syn keyword cssFont contained cursive fantasy monospace italic oblique

" FIXME: This allows cssMediaBlock before the semicolon, which is wrong.
syn region cssInclude start="@import" end=";" contains=cssComment,cssURL,cssUnicodeEscape,cssMediaType
syn match cssBraces contained "[{}]"
syn match cssError contained "{@<>"
syn region cssDefinition transparent matchgroup=cssBraces start='{' end='}' contains=cssComment,cssValue.*,cssColor,cssURL,cssImportant,cssError,cssStringQ,cssStringQQ,cssFunction,cssUnicodeEscape
syn match cssBraceError "}"

syn match cssPseudoClass ":\S*" contains=cssPseudoClassId,cssUnicodeEscape
syn keyword cssPseudoClassId contained link visited active hover focus before after left right
syn match cssPseudoClassId contained "\<first\(-\(line\|letter\|child\)\)\=\>"
syn region cssPseudoClassLang matchgroup=cssPseudoClassId start=":lang(" end=")" oneline

syn region cssComment start="/\*" end="\*/" contains=@Spell

syn match cssUnicodeEscape "\\\x\{1,6}\s\?"
syn match cssSpecialCharQQ +\\"+ contained
syn match cssSpecialCharQ +\\'+ contained
syn region cssStringQQ start=+"+ skip=+\\\\\|\\"+ end=+"+ contains=cssUnicodeEscape,cssSpecialCharQQ
syn region cssStringQ start=+'+ skip=+\\\\\|\\'+ end=+'+ contains=cssUnicodeEscape,cssSpecialCharQ
syn match cssClassName "\.[A-Za-z][A-Za-z0-9-]\+"

if main_syntax == "css"
  syn sync minlines=10
endif

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_css_syn_inits")
  if version < 508
    let did_css_syn_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink cssComment Comment
  HiLink cssTagName Statement
  HiLink cssSelectorOp Special
  HiLink cssSelectorOp2 Special
  HiLink cssPseudoClassId PreProc
  HiLink cssPseudoClassLang Constant
  HiLink cssValueLength Number
  HiLink cssValueInteger Number
  HiLink cssValueNumber Number
  HiLink cssValueAngle Number
  HiLink cssValueTime Number
  HiLink cssValueFrequency Number
  HiLink cssFunction Constant
  HiLink cssURL String
  HiLink cssFunctionName PreProc
  HiLink cssFont Constant
  HiLink cssColor Constant
  HiLink cssIdentifier Function
  HiLink cssInclude Include
  HiLink cssImportant Special
  HiLink cssBraces Function
  HiLink cssBraceError Error
  HiLink cssError Error
  HiLink cssInclude Include
  HiLink cssUnicodeEscape Special
  HiLink cssStringQQ String
  HiLink cssStringQ String
  HiLink cssUnicodeRange Constant
  HiLink cssClassName Type
  delcommand HiLink
endif

let b:current_syntax = "css"

if main_syntax == 'css'
  unlet main_syntax
endif


" vim: ts=8

