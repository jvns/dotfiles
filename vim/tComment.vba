" Vimball Archiver by Charles E. Campbell, Jr., Ph.D.
UseVimball
finish
doc/tComment.txt	[[[1
208
*tComment.txt*  tComment -- An easily extensible & universal comment plugin

Author: Thomas Link, micathom AT gmail com?subject=vim

tComment provides easy to use, file-type sensible comments for Vim. It 
can handle embedded syntax.


                                                    *tComment-Installation*
Installation~
Edit the vba file and type:

    :so %

See :help vimball for details. If you use vim 7.0, you may need to 
update your vimball installation first.


                                                    *tComment-Usage*
Usage~
TComment works like a toggle, i.e., it will comment out text that 
contains uncommented lines, and it will remove comment markup for 
already commented text (i.e. text that contains no uncommented lines).

If the file-type is properly defined, TComment will figure out which 
comment string to use. Otherwise you use |TCommentDefineType()| to 
override the default choice.

TComment can properly handle an embedded syntax, e.g., ruby/python/perl 
regions in vim scripts, HTML or JavaScript in php code etc.


                                                    *tComment-Key-Bindings*
Key bindings~

Most of the time the default toggle keys will do what you want (or to be 
more precise: what I think you want it to do ;-).

                                                    *g:tcommentMapLeaderOp1*
                                                    *g:tcommentMapLeaderOp2*
As operator (the prefix can be customized via g:tcommentMapLeaderOp1 
and g:tcommentMapLeaderOp2):

    gc{motion}   :: Toggle comments (for small comments within one line 
                    the &filetype_inline style will be used, if 
                    defined)
    gcc          :: Toggle comment for the current line
    gC{motion}   :: Comment region
    gCc          :: Comment the current line

                                                    *g:tcommentOpModeExtra*
By default the cursor stays put. If you want the cursor to the end of 
the commented text, set g:tcommentOpModeExtra to '>' (but this may not 
work properly with exclusive motions).

Primary key maps:

    <c-_><c-_>   :: :TComment
    <c-_><space> :: :TComment <QUERY COMMENT-BEGIN ?COMMENT-END>
    <c-_>b       :: :TCommentBlock
    <c-_>a       :: :TCommentAs <QUERY COMMENT TYPE>
    <c-_>n       :: :TCommentAs &filetype <QUERY COUNT>
    <c-_>s       :: :TCommentAs &filetype_<QUERY COMMENT SUBTYPE>
    <c-_>i       :: :TCommentInline
    <c-_>r       :: :TCommentRight
    <c-_>p       :: Comment the current inner paragraph

A secondary set of key maps is defined for normal mode.

    <Leader>__       :: :TComment
    <Leader>_p       :: Comment the current inner paragraph
    <Leader>_<space> :: :TComment <QUERY COMMENT-BEGIN ?COMMENT-END>
    <Leader>_i       :: :TCommentInline
    <Leader>_r       :: :TCommentRight
    <Leader>_b       :: :TCommentBlock
    <Leader>_a       :: :TCommentAs <QUERY COMMENT TYPE>
    <Leader>_n       :: :TCommentAs &filetype <QUERY COUNT>
    <Leader>_s       :: :TCommentAs &filetype_<QUERY COMMENT SUBTYPE>

Keymaps are configurable via the following variables:

                                                    *g:tcommentMapLeader1*
g:tcommentMapLeader1    string (default: <c-_>)
        Prefix for the keymaps. Set to '' to disable keymaps with this 
        prefix.
                                                    *g:tcommentMapLeader2*
g:tcommentMapLeader2    string (default: <Leader>_)
        Secondary prefix. (The reason for why there are two prefixes is 
        that <c-_> appears preferable with gvim but can be difficult to 
        type on the terminal. The secondary prefix isn't used for insert 
        mode maps. Set to '' to disable keymaps with this prefix.

                                                    *tComment-commands*
Alternatively, you can type (? meaning "optional argument"):

                                                    *:TComment*
    :?<range> TComment ?commentBegin ?commentEnd
    :?<range> TComment! ?commentBegin ?commentEnd
    NOTE: If there is a visual selection that begins and ends in the same 
    line, then TCommentInline is used instead.

    NOTE: The range is optional and defaults to the current line.

                                                    *:TCommentInline*
    :?<range> TCommentInline ?commentBegin ?commentEnd
    :?<range> TCommentInline! ?commentBegin ?commentEnd
    Use the {&ft}_inline comment style.

                                                    *:TCommentBlock*
    :?<range> TCommentBlock ?commentBegin ?commentEnd
    :?<range> TCommentBlock! ?commentBegin ?commentEnd
    Comment as "block", e.g. use the {&ft}_block comment style.
    NOTE: This command is kind of crude. It doesn't indent or reformat 
    the text.

                                                    *:TCommentAs*
    :?<range> TCommentAs filetype
    :?<range> TCommentAs! filetype
    NOTE: TCommentAs requires g:tcomment_{filetype} to be defined.
    NOTE: This command supports command line completion. See 'wildmode' 
    and 'wildmenu' for how to get the most out of it.

                                                    *:TCommentRight*
    :?<range> TCommentRight
    :?<range> TCommentRight!
    NOTE: This command comments out the text to the right of the cursor. 
    If a visual selection was made (be it block-wise or not), all lines 
    are commented out at from the current cursor position downwards.

    The bang (!) variants always comment out the selected text and don't 
    work as toggles.

                                                    *TCommentDefineType()*
    Using this command you can also use different comment styles with 
    the TCommentDefineType(name, commentstring) function. This function 
    takes two arguments:
        name :: The name is either &filetype or {&filetype}_{style}. 
            I.e., For block comments the {&filetype}_block and for 
            inline comments the {&filetype}_inline styles are used.
        comment string :: a string mostly as described in 
            'commentstring'.
    
    If you want to define, e.g., a fancy block comment style for html 
    you put something like this into ~/.vim/after/plugin/tComment.vim:>

        call TCommentDefineType("html_fancy_block", "<!--%s  -->\n  -- ")

<   The part after the newline character is used for marking "middle" 
    lines.

    This comment style could then be accessed via (this command has 
    command line completion): >

        '<,'>TCommentAs html_fancy_block

<   If you're editing a html file, this could best be done by the <c-_>s     
    key map.


Goals~
- Maintain indentation of selected text; the comment markers are left 
  aligned but the text on the right (i.e., the comment) is indented 
  like the original text

- Handle embedded syntax like php+html or html+javaScript+css; you 
  have to set g:tcommentGuessFileType_{&filetype} to 1 or to the 
  fall-back file-type in order to activate this feature for other file 
  types than php or html
  
  tComment deduces the correct file type from the syntax name, similar 
  to the way EnhancedCommentify.vim does it. In opposition to 
  EnhancedCommentify.vim, it matches the syntax name against a list the 
  known file types, so that it can deal with, e.g., embedded javaScript

- Easy to customize/adapt for an yet unknown syntax by setting buffer 
  local variables (b:commentStart, b:commentEnd, or b:commentstring), 
  global variables (g:tcomment_{&ft} and g:tcomment_{&ft}_block), or the 
  buffer local &commentstring option (which can be set on a vim 
  |modeline|)

- Use 'commentstring' or 'comments' as a fallback (i.e., if a file-type 
  is properly defined, TComment will automatically support it)

- Same short-cut for commenting text and for removing comment markup

- The decision whether text should be commented or uncommented is made 
  on the basis of the whole selection (not line by line); comments in 
  code that should be commented aren't uncommented as it is the case 
  with some other plug-ins

As of version 1.5, the following file types are explicitly defined 
(other file-types are most likely supported through the 'commentstring' 
or 'comments' variables):

    ada, apache, autoit, catalog, cpp, css, c, cfg, conf, desktop, 
    docbk, dosbatch, dosini, dsl, dylan, eiffel, gtkrc, haskell, html, 
    io, javaScript, java, lisp, m4, nroff, objc, ocaml, pascal, perl, 
    php, prolog, ruby, r, scheme, sgml, sh, sql, spec, sps, tcl, tex, 
    tpl, viki, vim, websec, xml, xslt, yaml


Credits~
The way we check for embedded syntax was originally adapted 
from/inspired by Meikel Brandmeyer's EnhancedCommentify.vim
(vimscript #23) but has evolved since.


vim: tw=72
plugin/tComment.vim	[[[1
378
" tComment.vim -- An easily extensible & universal comment plugin 
" @Author:      Thomas Link (micathom AT gmail com)
" @License:     GPL (see http://www.gnu.org/licenses/gpl.txt)
" @Created:     27-Dez-2004.
" @Last Change: 2008-05-15.
" @Revision:    1.9.664
" 
" GetLatestVimScripts: 1173 1 tComment.vim

if &cp || exists('loaded_tcomment')
    finish
endif
let loaded_tcomment = 109

" If true, comment blank lines too
if !exists("g:tcommentBlankLines")
    let g:tcommentBlankLines = 1
endif

if !exists("g:tcommentMapLeader1")
    let g:tcommentMapLeader1 = '<c-_>'
endif
if !exists("g:tcommentMapLeader2")
    let g:tcommentMapLeader2 = '<Leader>_'
endif
if !exists("g:tcommentMapLeaderOp1")
    let g:tcommentMapLeaderOp1 = 'gc'
endif
if !exists("g:tcommentMapLeaderOp2")
    let g:tcommentMapLeaderOp2 = 'gC'
endif
if !exists("g:tcommentOpModeExtra")
    let g:tcommentOpModeExtra = ''
endif

" Guess the file type based on syntax names always or for some fileformat only
if !exists("g:tcommentGuessFileType")
    let g:tcommentGuessFileType = 0
endif
" In php documents, the php part is usually marked as phpRegion. We thus 
" assume that the buffers default comment style isn't php but html
if !exists("g:tcommentGuessFileType_dsl")
    let g:tcommentGuessFileType_dsl = 'xml'
endif
if !exists("g:tcommentGuessFileType_php")
    let g:tcommentGuessFileType_php = 'html'
endif
if !exists("g:tcommentGuessFileType_html")
    let g:tcommentGuessFileType_html = 1
endif
if !exists("g:tcommentGuessFileType_tskeleton")
    let g:tcommentGuessFileType_tskeleton = 1
endif
if !exists("g:tcommentGuessFileType_vim")
    let g:tcommentGuessFileType_vim = 1
endif

if !exists("g:tcommentIgnoreTypes_php")
    let g:tcommentIgnoreTypes_php = 'sql'
endif

if !exists('g:tcommentSyntaxMap') "{{{2
    let g:tcommentSyntaxMap = {
            \ 'vimMzSchemeRegion': 'scheme',
            \ 'vimPerlRegion':     'perl',
            \ 'vimPythonRegion':   'python',
            \ 'vimRubyRegion':     'ruby',
            \ 'vimTclRegion':      'tcl',
            \ }
endif

" If you don't define these variables, TComment will use &commentstring 
" instead. We override the default values here in order to have a blank after 
" the comment marker. Block comments work only if we explicitly define the 
" markup.
" The format for block comments is similar to normal commentstrings with the 
" exception that the format strings for blocks can contain a second line that 
" defines how "middle lines" (see :h format-comments) should be displayed.

" I personally find this style rather irritating but here is an alternative 
" definition that does this left-handed bar thing
if !exists("g:tcommentBlockC")
    let g:tcommentBlockC = "/*%s */\n * "
endif
if !exists("g:tcommentBlockC2")
    let g:tcommentBlockC2 = "/**%s */\n * "
endif
if !exists("g:tcommentInlineC")
    let g:tcommentInlineC = "/* %s */"
endif

if !exists("g:tcommentBlockXML")
    let g:tcommentBlockXML = "<!--%s-->\n  "
endif
if !exists("g:tcommentInlineXML")
    let g:tcommentInlineXML = "<!-- %s -->"
endif

let g:tcommentFileTypesDirty = 1

" Currently this function just sets a variable
function! TCommentDefineType(name, commentstring)
    if !exists('g:tcomment_'. a:name)
        let g:tcomment_{a:name} = a:commentstring
    endif
    let g:tcommentFileTypesDirty = 1
endf

function! TCommentTypeExists(name)
    return exists('g:tcomment_'. a:name)
endf

call TCommentDefineType('aap',              '# %s'             )
call TCommentDefineType('ada',              '-- %s'            )
call TCommentDefineType('apache',           '# %s'             )
call TCommentDefineType('autoit',           '; %s'             )
call TCommentDefineType('asm',              '; %s'             )
call TCommentDefineType('awk',              '# %s'             )
call TCommentDefineType('catalog',          '-- %s --'         )
call TCommentDefineType('catalog_block',    "--%s--\n  "       )
call TCommentDefineType('cpp',              '// %s'            )
call TCommentDefineType('cpp_inline',       g:tcommentInlineC  )
call TCommentDefineType('cpp_block',        g:tcommentBlockC   )
call TCommentDefineType('css',              '/* %s */'         )
call TCommentDefineType('css_inline',       g:tcommentInlineC  )
call TCommentDefineType('css_block',        g:tcommentBlockC   )
call TCommentDefineType('c',                '/* %s */'         )
call TCommentDefineType('c_inline',         g:tcommentInlineC  )
call TCommentDefineType('c_block',          g:tcommentBlockC   )
call TCommentDefineType('cfg',              '# %s'             )
call TCommentDefineType('conf',             '# %s'             )
call TCommentDefineType('desktop',          '# %s'             )
call TCommentDefineType('docbk',            '<!-- %s -->'      )
call TCommentDefineType('docbk_inline',     g:tcommentInlineXML)
call TCommentDefineType('docbk_block',      g:tcommentBlockXML )
call TCommentDefineType('dosbatch',         'rem %s'           )
call TCommentDefineType('dosini',           '; %s'             )
call TCommentDefineType('dsl',              '; %s'             )
call TCommentDefineType('dylan',            '// %s'            )
call TCommentDefineType('eiffel',           '-- %s'            )
call TCommentDefineType('eruby',            '<%%# %s%%>'       )
call TCommentDefineType('gtkrc',            '# %s'             )
call TCommentDefineType('gitcommit',        '# %s'             )
call TCommentDefineType('haskell',          '-- %s'            )
call TCommentDefineType('haskell_block',    "{-%s-}\n   "      )
call TCommentDefineType('haskell_inline',   '{- %s -}'         )
call TCommentDefineType('html',             '<!-- %s -->'      )
call TCommentDefineType('html_inline',      g:tcommentInlineXML)
call TCommentDefineType('html_block',       g:tcommentBlockXML )
call TCommentDefineType('io',               '// %s'            )
call TCommentDefineType('javaScript',       '// %s'            )
call TCommentDefineType('javaScript_inline', g:tcommentInlineC )
call TCommentDefineType('javaScript_block', g:tcommentBlockC   )
call TCommentDefineType('javascript',       '// %s'            )
call TCommentDefineType('javascript_inline', g:tcommentInlineC )
call TCommentDefineType('javascript_block', g:tcommentBlockC   )
call TCommentDefineType('java',             '/* %s */'         )
call TCommentDefineType('java_inline',      g:tcommentInlineC  )
call TCommentDefineType('java_block',       g:tcommentBlockC   )
call TCommentDefineType('java_doc_block',   g:tcommentBlockC2  )
call TCommentDefineType('lisp',             '; %s'             )
call TCommentDefineType('m4',               'dnl %s'           )
call TCommentDefineType('mail',             '> %s'             )
call TCommentDefineType('msidl',            '// %s'            )
call TCommentDefineType('msidl_block',      g:tcommentBlockC   )
call TCommentDefineType('nroff',            '.\\" %s'          )
call TCommentDefineType('nsis',             '# %s'             )
call TCommentDefineType('objc',             '/* %s */'         )
call TCommentDefineType('objc_inline',      g:tcommentInlineC  )
call TCommentDefineType('objc_block',       g:tcommentBlockC   )
call TCommentDefineType('ocaml',            '(* %s *)'         )
call TCommentDefineType('ocaml_inline',     '(* %s *)'         )
call TCommentDefineType('ocaml_block',      "(*%s*)\n   "      )
call TCommentDefineType('pascal',           '(* %s *)'         )
call TCommentDefineType('pascal_inline',    '(* %s *)'         )
call TCommentDefineType('pascal_block',     "(*%s*)\n   "      )
call TCommentDefineType('perl',             '# %s'             )
call TCommentDefineType('perl_block',       "=cut%s=cut"       )
call TCommentDefineType('php',              '// %s'            )
call TCommentDefineType('php_inline',       g:tcommentInlineC  )
call TCommentDefineType('php_block',        g:tcommentBlockC   )
call TCommentDefineType('php_2_block',      g:tcommentBlockC2  )
call TCommentDefineType('po',               '# %s'             )
call TCommentDefineType('prolog',           '%% %s'            )
call TCommentDefineType('rc',               '// %s'            )
call TCommentDefineType('readline',         '# %s'             )
call TCommentDefineType('ruby',             '# %s'             )
call TCommentDefineType('ruby_3',           '### %s'           )
call TCommentDefineType('ruby_block',       "=begin rdoc%s=end")
call TCommentDefineType('ruby_nodoc_block', "=begin%s=end"     )
call TCommentDefineType('r',                '# %s'             )
call TCommentDefineType('sbs',              "' %s"             )
call TCommentDefineType('scheme',           '; %s'             )
call TCommentDefineType('sed',              '# %s'             )
call TCommentDefineType('sgml',             '<!-- %s -->'      )
call TCommentDefineType('sgml_inline',      g:tcommentInlineXML)
call TCommentDefineType('sgml_block',       g:tcommentBlockXML )
call TCommentDefineType('sh',               '# %s'             )
call TCommentDefineType('sql',              '-- %s'            )
call TCommentDefineType('spec',             '# %s'             )
call TCommentDefineType('sps',              '* %s.'            )
call TCommentDefineType('sps_block',        "* %s."            )
call TCommentDefineType('spss',             '* %s.'            )
call TCommentDefineType('spss_block',       "* %s."            )
call TCommentDefineType('tcl',              '# %s'             )
call TCommentDefineType('tex',              '%% %s'            )
call TCommentDefineType('tpl',              '<!-- %s -->'      )
call TCommentDefineType('viki',             '%% %s'            )
call TCommentDefineType('viki_3',           '%%%%%% %s'        )
call TCommentDefineType('viki_inline',      '{cmt: %s}'        )
call TCommentDefineType('vim',              '" %s'             )
call TCommentDefineType('vim_3',            '""" %s'           )
call TCommentDefineType('websec',           '# %s'             )
call TCommentDefineType('xml',              '<!-- %s -->'      )
call TCommentDefineType('xml_inline',       g:tcommentInlineXML)
call TCommentDefineType('xml_block',        g:tcommentBlockXML )
call TCommentDefineType('xs',               '// %s'            )
call TCommentDefineType('xs_block',         g:tcommentBlockC   )
call TCommentDefineType('xslt',             '<!-- %s -->'      )
call TCommentDefineType('xslt_inline',      g:tcommentInlineXML)
call TCommentDefineType('xslt_block',       g:tcommentBlockXML )
call TCommentDefineType('yaml',             '# %s'             )


" :line1,line2 TCommentAs commenttype
command! -bang -complete=customlist,tcomment#FileTypes -range -nargs=+ TCommentAs 
            \ call tcomment#CommentAs(<line1>, <line2>, "<bang>", <f-args>)

" :line1,line2 TComment ?commentBegin ?commentEnd
command! -bang -range -nargs=* TComment keepjumps call tcomment#Comment(<line1>, <line2>, 'G', "<bang>", <f-args>)

" :line1,line2 TCommentRight ?commentBegin ?commentEnd
command! -bang -range -nargs=* TCommentRight keepjumps call tcomment#Comment(<line1>, <line2>, 'R', "<bang>", <f-args>)

" :line1,line2 TCommentBlock ?commentBegin ?commentEnd
command! -bang -range -nargs=* TCommentBlock keepjumps call tcomment#Comment(<line1>, <line2>, 'B', "<bang>", <f-args>)

" :line1,line2 TCommentInline ?commentBegin ?commentEnd
command! -bang -range -nargs=* TCommentInline keepjumps call tcomment#Comment(<line1>, <line2>, 'I', "<bang>", <f-args>)

" :line1,line2 TCommentMaybeInline ?commentBegin ?commentEnd
command! -bang -range -nargs=* TCommentMaybeInline keepjumps call tcomment#Comment(<line1>, <line2>, 'i', "<bang>", <f-args>)



if (g:tcommentMapLeader1 != '')
    exec 'noremap <silent> '. g:tcommentMapLeader1 .'<c-_> :TComment<cr>'
    exec 'vnoremap <silent> '. g:tcommentMapLeader1 .'<c-_> :TCommentMaybeInline<cr>'
    exec 'inoremap <silent> '. g:tcommentMapLeader1 .'<c-_> <c-o>:TComment<cr>'
    exec 'noremap <silent> '. g:tcommentMapLeader1 .'p m`vip:TComment<cr>``'
    exec 'inoremap <silent> '. g:tcommentMapLeader1 .'p <c-o>:norm! m`vip<cr>:TComment<cr><c-o>``'
    exec 'noremap '. g:tcommentMapLeader1 .'<space> :TComment '
    exec 'inoremap '. g:tcommentMapLeader1 .'<space> <c-o>:TComment '
    exec 'inoremap <silent> '. g:tcommentMapLeader1 .'r <c-o>:TCommentRight<cr>'
    exec 'noremap <silent> '. g:tcommentMapLeader1 .'r :TCommentRight<cr>'
    exec 'vnoremap <silent> '. g:tcommentMapLeader1 .'i :TCommentInline<cr>'
    exec 'vnoremap <silent> '. g:tcommentMapLeader1 .'r :TCommentRight<cr>'
    exec 'noremap '. g:tcommentMapLeader1 .'b :TCommentBlock<cr>'
    exec 'inoremap '. g:tcommentMapLeader1 .'b <c-o>:TCommentBlock<cr>'
    exec 'noremap '. g:tcommentMapLeader1 .'a :TCommentAs '
    exec 'inoremap '. g:tcommentMapLeader1 .'a <c-o>:TCommentAs '
    exec 'noremap '. g:tcommentMapLeader1 .'n :TCommentAs <c-r>=&ft<cr> '
    exec 'inoremap '. g:tcommentMapLeader1 .'n <c-o>:TCommentAs <c-r>=&ft<cr> '
    exec 'noremap '. g:tcommentMapLeader1 .'s :TCommentAs <c-r>=&ft<cr>_'
    exec 'inoremap '. g:tcommentMapLeader1 .'s <c-o>:TCommentAs <c-r>=&ft<cr>_'
endif
if (g:tcommentMapLeader2 != '')
    exec 'noremap <silent> '. g:tcommentMapLeader2 .'_ :TComment<cr>'
    exec 'vnoremap <silent> '. g:tcommentMapLeader2 .'_ :TCommentMaybeInline<cr>'
    exec 'noremap <silent> '. g:tcommentMapLeader2 .'p vip:TComment<cr>'
    exec 'noremap '. g:tcommentMapLeader2 .'<space> :TComment '
    exec 'vnoremap <silent> '. g:tcommentMapLeader2 .'i :TCommentInline<cr>'
    exec 'noremap <silent> '. g:tcommentMapLeader2 .'r :TCommentRight<cr>'
    exec 'vnoremap <silent> '. g:tcommentMapLeader2 .'r :TCommentRight<cr>'
    exec 'noremap '. g:tcommentMapLeader2 .'b :TCommentBlock<cr>'
    exec 'noremap '. g:tcommentMapLeader2 .'a :TCommentAs '
    exec 'noremap '. g:tcommentMapLeader2 .'n :TCommentAs <c-r>=&ft<cr> '
    exec 'noremap '. g:tcommentMapLeader2 .'s :TCommentAs <c-r>=&ft<cr>_'
endif
if (g:tcommentMapLeaderOp1 != '')
    exec 'nnoremap <silent> '. g:tcommentMapLeaderOp1 .' :let w:tcommentPos = getpos(".") \| set opfunc=tcomment#Operator<cr>g@'
    exec 'nnoremap <silent> '. g:tcommentMapLeaderOp1 .'c :let w:tcommentPos = getpos(".") \| set opfunc=tcomment#OperatorLine<cr>g@$'
    exec 'vnoremap <silent> '. g:tcommentMapLeaderOp1 .' :TCommentMaybeInline<cr>'
endif 
if (g:tcommentMapLeaderOp2 != '')
    exec 'nnoremap <silent> '. g:tcommentMapLeaderOp2 .' :let w:tcommentPos = getpos(".") \| set opfunc=tcomment#OperatorAnyway<cr>g@'
    exec 'nnoremap <silent> '. g:tcommentMapLeaderOp2 .'c :let w:tcommentPos = getpos(".") \| set opfunc=tcomment#OperatorLineAnyway<cr>g@$'
    exec 'vnoremap <silent> '. g:tcommentMapLeaderOp2 .' :TCommentMaybeInline<cr>'
endif 

finish


-----------------------------------------------------------------------
History

0.1
- Initial release

0.2
- Fixed uncommenting of non-aligned comments
- improved support for block comments (with middle lines and indentation)
- using TCommentBlock for file types that don't have block comments creates 
single line comments
- removed the TCommentAsBlock command (TCommentAs provides its functionality)
- removed g:tcommentSetCMS
- the default key bindings have slightly changed

1.3
- slightly improved recognition of embedded syntax
- if no commentstring is defined in whatever way, reconstruct one from 
&comments
- The TComment... commands now have bang variants that don't act as toggles 
but always comment out the selected text
- fixed problem with commentstrings containing backslashes
- comment as visual block (allows commenting text to the right of the main 
text, i.e., this command doesn't work on whole lines but on the text to the 
right of the cursor)
- enable multimode for dsl, vim filetypes
- added explicit support for some other file types I ran into

1.4
- Fixed problem when &commentstring was invalid (e.g. lua)
- perl_block by Kyosuke Takayama.
- <c-_>s mapped to :TCommentAs <c-r>=&ft<cr>

1.5
- "Inline" visual comments (uses the &filetype_inline style if 
available; doesn't check if the filetype actually supports this kind of 
comments); tComment can't currently deduce inline comment styles from 
&comments or &commentstring (I personally hardly ever use them); default 
map: <c-_>i or <c-_>I
- In visual mode: if the selection spans several lines, normal mode is 
selected; if the selection covers only a part of one line, inline mode 
is selected
- Fixed problem with lines containing ^M or ^@ characters.
- It's no longer necessary to call TCommentCollectFileTypes() after 
defining a new filetype via TCommentDefineType()
- Disabled single <c-_> mappings
- Renamed TCommentVisualBlock to TCommentRight
- FIX: Forgot 'x' in ExtractCommentsPart() (thanks to Fredrik Acosta)

1.6
- Ignore sql when guessing the comment string in php files; tComment 
sometimes chooses the wrong comment string because the use of sql syntax 
is used too loosely in php files; if you want to comment embedded sql 
code you have to use TCommentAs
- Use keepjumps in commands.
- Map <c-_>p & <L>_p to vip:TComment<cr>
- Made key maps configurable via g:tcommentMapLeader1 and 
g:tcommentMapLeader2

1.7
- gc{motion} (see g:tcommentMapLeaderOp1) functions as a comment toggle 
operator (i.e., something like gcl... works, mostly); gC{motion} (see 
g:tcommentMapLeaderOp2) will unconditionally comment the text.
- TCommentAs takes an optional second argument (the comment level)
- New "n" map: TCommentAs &filetype [COUNT]
- Defined mail comments/citations
- g:tcommentSyntaxMap: Map syntax names to filetypes for buffers with 
mixed syntax groups that don't match the filetypeEmbeddedsyntax scheme (e.g.  
'vimRubyRegion', which should be commented as ruby syntax, not as vim 
syntax)
- FIX: Comments in vim*Region
- TComment: The use of the type argument has slightly changed (IG -> i, 
new: >)

1.8
- Definitly require vim7
- Split the plugin into autoload & plugin.
- g:TCommentFileTypes is a list
- Fixed some block comment strings
- Removed extraneous newline in some block comments.
- Maps for visal mode (thanks Krzysztof Goj)

1.9
- Fix left offset for inline comments (via operator binding)

autoload/tcomment.vim	[[[1
557
" tcomment.vim
" @Author:      Thomas Link (mailto:micathom AT gmail com?subject=[vim])
" @Website:     http://www.vim.org/account/profile.php?user_id=4037
" @License:     GPL (see http://www.gnu.org/licenses/gpl.txt)
" @Created:     2007-09-17.
" @Last Change: 2008-05-07.
" @Revision:    0.0.46

if &cp || exists("loaded_tcomment_autoload")
    finish
endif
let loaded_tcomment_autoload = 1


function! s:DefaultValue(option)
    exec 'let '. a:option .' = &'. a:option
    exec 'set '. a:option .'&'
    exec 'let default = &'. a:option
    exec 'let &'. a:option .' = '. a:option
    return default
endf

let s:defaultComments      = s:DefaultValue('comments')
let s:defaultCommentString = s:DefaultValue('commentstring')
let s:nullCommentString    = '%s'

" tcomment#Comment(line1, line2, ?commentMode, ?commentAnyway, ?commentBegin, ?commentEnd)
" commentMode:
"   G ... guess
"   B ... block
"   i ... maybe inline, guess
"   I ... inline
"   R ... right
"   v ... visual
"   o ... operator
function! tcomment#Comment(beg, end, ...)
    " save the cursor position
    let co = col('.')
    let li = line('.')
    let s:pos_end = getpos("'>")
    let commentMode   = a:0 >= 1 ? a:1 : 'G'
    let commentAnyway = a:0 >= 2 ? (a:2 == '!') : 0
    " TLogVAR a:beg, a:end, a:1, commentMode, commentAnyway
    if commentMode =~# 'i'
        let commentMode = substitute(commentMode, '\Ci', line("'<") == line("'>") ? 'I' : 'G', 'g')
    endif
    if commentMode =~# 'R' || commentMode =~# 'I'
        let cstart = col("'<")
        if cstart == 0
            let cstart = col('.')
        endif
        if commentMode =~# 'R'
            let commentMode = substitute(commentMode, '\CR', 'G', 'g')
            let cend = 0
        else
            let cend = col("'>")
            if commentMode =~# 'o'
                let cend += 1
            endif
        endif
    else
        let cstart = 0
        let cend   = 0
    endif
    " TLogVAR commentMode, cstart, cend
    " get the correct commentstring
    if a:0 >= 3 && a:3 != ''
        let cms = s:EncodeCommentPart(a:3) .'%s'
        if a:0 >= 4 && a:4 != ''
            let cms = cms . s:EncodeCommentPart(a:4)
        endif
    else
        let [cms, commentMode] = s:GetCommentString(a:beg, a:end, commentMode)
    endif
    let cms0 = s:BlockGetCommentString(cms)
    let cms0 = escape(cms0, '\')
    " make whitespace optional; this conflicts with comments that require some 
    " whitespace
    let cmtCheck = substitute(cms0, '\([	 ]\)', '\1\\?', 'g')
    " turn commentstring into a search pattern
    let cmtCheck = s:SPrintF(cmtCheck, '\(\_.\{-}\)')
    " set commentMode and indentStr
    let [indentStr, uncomment] = s:CommentDef(a:beg, a:end, cmtCheck, commentMode, cstart, cend)
    " TLogVAR indentStr, uncomment
    if commentAnyway
        let uncomment = 0
    endif
    " go
    if commentMode =~# 'B'
        " We want a comment block
        call s:CommentBlock(a:beg, a:end, uncomment, cmtCheck, cms, indentStr)
    else
        " We want commented lines
        " final search pattern for uncommenting
        let cmtCheck   = escape('\V\^\(\s\{-}\)'. cmtCheck .'\$', '"/\')
        " final pattern for commenting
        let cmtReplace = escape(cms0, '"/')
        silent exec a:beg .','. a:end .'s/\V'. 
                    \ s:StartRx(cstart) . indentStr .'\zs\(\.\{-}\)'. s:EndRx(cend) .'/'.
                    \ '\=s:ProcessedLine('. uncomment .', submatch(0), "'. cmtCheck .'", "'. cmtReplace .'")/ge'
    endif
    " reposition cursor
    " TLogVAR commentMode
    if commentMode =~ '>'
        call setpos('.', s:pos_end)
    else
        " TLogVAR li, co
        call cursor(li, co)
    endif
endf


function! tcomment#Operator(type, ...) "{{{3
    let commentMode = a:0 >= 1 ? a:1 : ''
    let bang = a:0 >= 2 ? a:2 : ''
    let sel_save = &selection
    let &selection = "inclusive"
    let reg_save = @@
    " let pos = getpos('.')
    " TLogVAR a:type
    try
        if a:type == 'line'
            silent exe "normal! '[V']"
            let commentMode1 = 'G'
        elseif a:type == 'block'
            silent exe "normal! `[\<C-V>`]"
            let commentMode1 = 'I'
        else
            silent exe "normal! `[v`]"
            let commentMode1 = 'i'
        endif
        if empty(commentMode)
            let commentMode = commentMode1
        endif
        let beg = line("'[")
        let end = line("']")
        norm! 
        let commentMode .= g:tcommentOpModeExtra
        call tcomment#Comment(beg, end, commentMode.'o', bang)
    finally
        let &selection = sel_save
        let @@ = reg_save
        if g:tcommentOpModeExtra !~ '>'
            " TLogVAR pos
            " call setpos('.', pos)
            call setpos('.', w:tcommentPos)
            unlet! w:tcommentPos
        endif
    endtry
endf


function! tcomment#OperatorLine(type) "{{{3
    call tcomment#Operator(a:type, 'G')
endf


function! tcomment#OperatorAnyway(type) "{{{3
    call tcomment#Operator(a:type, '', '!')
endf


function! tcomment#OperatorLineAnyway(type) "{{{3
    call tcomment#Operator(a:type, 'G', '!')
endf


" comment text as if it were of a specific filetype
function! tcomment#CommentAs(beg, end, commentAnyway, filetype, ...)
    let ccount = a:0 >= 1 ? a:1 : 1
    " TLogVAR ccount
    if a:filetype =~ '_block$'
        let commentMode = 'B'
        let ft = substitute(a:filetype, '_block$', '', '')
    elseif a:filetype =~ '_inline$'
        let commentMode = 'I'
        let ft = substitute(a:filetype, '_inline$', '', '')
    else 
        let commentMode = 'G'
        let ft = a:filetype
    endif
    let [cms, commentMode] = s:GetCommentString(a:beg, a:end, commentMode, ft)
    let pre  = substitute(cms, '%s.*$', '', '')
    let pre  = substitute(pre, '%%', '%', 'g')
    let post = substitute(cms, '^.\{-}%s', '', '')
    let post = substitute(post, '%%', '%', 'g')
    if ccount > 1
        let pre_l = matchlist(pre, '^\(\S\+\)\(.*\)$')
        " TLogVAR pre_l
        if !empty(get(pre_l, 1))
            let pre  = repeat(pre_l[1], ccount) . pre_l[2]
        endif
        let post_l = matchlist(post, '^\(\s*\)\(.\+\)$')
        " TLogVAR post_l
        if !empty(get(post_l, 2))
            let post = post_l[1] . repeat(post_l[2], ccount)
        endif
    endif
    keepjumps call tcomment#Comment(a:beg, a:end, commentMode, a:commentAnyway, pre, post)
endf


" ----------------------------------------------------------------
" collect all variables matching ^tcomment_
function! tcomment#CollectFileTypes()
    if g:tcommentFileTypesDirty
        redir => vars
        silent let
        redir END
        let g:tcommentFileTypes = split(vars, '\n')
        call filter(g:tcommentFileTypes, 'v:val =~ "tcomment_"')
        call map(g:tcommentFileTypes, 'matchstr(v:val, ''tcomment_\zs\S\+'')')
        call sort(g:tcommentFileTypes)
        let g:tcommentFileTypesRx = '\V\^\('. join(g:tcommentFileTypes, '\|') .'\)\(\u\.\*\)\?\$'
        let g:tcommentFileTypesDirty = 0
    endif
endf

call tcomment#CollectFileTypes()

" return a list of filetypes for which a tcomment_{&ft} is defined
function! tcomment#FileTypes(ArgLead, CmdLine, CursorPos)
    " TLogVAR a:ArgLead, a:CmdLine, a:CursorPos
    call tcomment#CollectFileTypes()
    let types = copy(g:tcommentFileTypes)
    if index(g:tcommentFileTypes, &filetype) != -1
        " TLogVAR &filetype
        call insert(types, &filetype)
    endif
    if empty(a:ArgLead)
        return types
    else
        return filter(types, 'v:val =~ ''\V''.a:ArgLead')
    endif
endf

function! s:EncodeCommentPart(string)
    return substitute(a:string, '%', '%%', 'g')
endf

" s:GetCommentString(beg, end, commentMode, ?filetype="")
function! s:GetCommentString(beg, end, commentMode, ...)
    let ft = a:0 >= 1 ? a:1 : ''
    if ft != ''
        let [cms, commentMode] = s:GetCustomCommentString(ft, a:commentMode)
    else
        let cms = ''
        let commentMode = a:commentMode
    endif
    if empty(cms)
        if exists('b:commentstring')
            let cms = b:commentstring
            return s:GetCustomCommentString(&filetype, a:commentMode, cms)
        elseif exists('b:commentStart') && b:commentStart != ''
            let cms = s:EncodeCommentPart(b:commentStart) .' %s'
            if exists('b:commentEnd') && b:commentEnd != ''
                let cms = cms .' '. s:EncodeCommentPart(b:commentEnd)
            endif
            return s:GetCustomCommentString(&filetype, a:commentMode, cms)
        elseif g:tcommentGuessFileType || (exists('g:tcommentGuessFileType_'. &filetype) 
                    \ && g:tcommentGuessFileType_{&filetype} =~ '[^0]')
            if g:tcommentGuessFileType_{&filetype} == 1
                let altFiletype = ''
            else
                let altFiletype = g:tcommentGuessFileType_{&filetype}
            endif
            return s:GuessFileType(a:beg, a:end, a:commentMode, &filetype, altFiletype)
        else
            return s:GetCustomCommentString(&filetype, a:commentMode, s:GuessCurrentCommentString(a:commentMode))
        endif
    endif
    return [cms, commentMode]
endf

" s:SPrintF(formatstring, ?values ...)
" => string
function! s:SPrintF(string, ...)
    let n = 1
    let r = ''
    let s = a:string
    while 1
        let i = match(s, '%\(.\)')
        if i >= 0
            let x = s[i + 1]
            let r = r . strpart(s, 0, i)
            let s = strpart(s, i + 2)
            if x == '%'
                let r = r.'%'
            else
                if a:0 >= n
                    let v = a:{n}
                    let n = n + 1
                else
                    echoerr 'Malformed format string (too many arguments required): '. a:string
                endif
                if x ==# 's'
                    let r = r.v
                elseif x ==# 'S'
                    let r = r.'"'.v.'"'
                else
                    echoerr 'Malformed format string: '. a:string
                endif
            endif
        else
            return r.s
        endif
    endwh
endf

function! s:StartRx(pos)
    if a:pos == 0
        return '\^'
    else
        return '\%'. a:pos .'c'
    endif
endf

function! s:EndRx(pos)
    if a:pos == 0
        return '\$'
    else
        return '\%'. a:pos .'c'
    endif
endf

function! s:GetIndentString(line, start)
    let start = a:start > 0 ? a:start - 1 : 0
    return substitute(strpart(getline(a:line), start), '\V\^\s\*\zs\.\*\$', '', '')
endf

function! s:CommentDef(beg, end, checkRx, commentMode, cstart, cend)
    let mdrx = '\V'. s:StartRx(a:cstart) .'\s\*'. a:checkRx .'\s\*'. s:EndRx(0)
    let line = getline(a:beg)
    if a:cstart != 0 && a:cend != 0
        let line = strpart(line, 0, a:cend - 1)
    endif
    let uncomment = (line =~ mdrx)
    let it = s:GetIndentString(a:beg, a:cstart)
    let il = indent(a:beg)
    let n  = a:beg + 1
    while n <= a:end
        if getline(n) =~ '\S'
            let jl = indent(n)
            if jl < il
                let it = s:GetIndentString(n, a:cstart)
                let il = jl
            endif
            if a:commentMode =~# 'G'
                if !(getline(n) =~ mdrx)
                    let uncomment = 0
                endif
            endif
        endif
        let n = n + 1
    endwh
    if a:commentMode =~# 'B'
        let t = @t
        try
            silent exec 'norm! '. a:beg.'G1|v'.a:end.'G$"ty'
            let uncomment = (@t =~ mdrx)
        finally
            let @t = t
        endtry
    endif
    return [it, uncomment]
endf

function! s:ProcessedLine(uncomment, match, checkRx, replace)
    if !(a:match =~ '\S' || g:tcommentBlankLines)
        return a:match
    endif
    let ml = len(a:match)
    if a:uncomment
        let rv = substitute(a:match, a:checkRx, '\1\2', '')
    else
        let rv = s:SPrintF(a:replace, a:match)
    endif
    " let md = len(rv) - ml
    let s:pos_end = getpos('.')
    let s:pos_end[2] += len(rv)
    " TLogVAR pe, md, a:match
    let rv = escape(rv, '\')
    let rv = substitute(rv, '\n', '\\\n', 'g')
    return rv
endf

function! s:CommentBlock(beg, end, uncomment, checkRx, replace, indentStr)
    let t = @t
    try
        silent exec 'norm! '. a:beg.'G1|v'.a:end.'G$"td'
        let ms = s:BlockGetMiddleString(a:replace)
        let mx = escape(ms, '\')
        if a:uncomment
            let @t = substitute(@t, '\V\^\s\*'. a:checkRx .'\$', '\1', '')
            if ms != ''
                let @t = substitute(@t, '\V\n'. a:indentStr . mx, '\n'. a:indentStr, 'g')
            endif
            let @t = substitute(@t, '^\n', '', '')
            let @t = substitute(@t, '\n\s*$', '', '')
        else
            let cs = s:BlockGetCommentString(a:replace)
            let cs = a:indentStr . substitute(cs, '%s', '%s'. a:indentStr, '')
            if ms != ''
                let ms = a:indentStr . ms
                let mx = a:indentStr . mx
                let @t = substitute(@t, '^'. a:indentStr, '', 'g')
                let @t = ms . substitute(@t, '\n'. a:indentStr, '\n'. mx, 'g')
            endif
            let @t = s:SPrintF(cs, "\n". @t ."\n")
        endif
        silent norm! "tP
    finally
        let @t = t
    endtry
endf

" inspired by Meikel Brandmeyer's EnhancedCommentify.vim
" this requires that a syntax names are prefixed by the filetype name 
" s:GuessFileType(beg, end, commentMode, filetype, ?fallbackFiletype)
function! s:GuessFileType(beg, end, commentMode, filetype, ...)
    if a:0 >= 1 && a:1 != ''
        let [cms, commentMode] = s:GetCustomCommentString(a:1, a:commentMode)
        if cms == ''
            let cms = s:GuessCurrentCommentString(a:commentMode)
        endif
    else
        let commentMode = s:CommentMode(a:commentMode, 'G')
        let cms = s:GuessCurrentCommentString(0)
    endif
    let n  = a:beg
    while n <= a:end
        let m  = indent(n) + 1
        let le = col('$')
        while m < le
            let syntaxName = synIDattr(synID(n, m, 1), 'name')
            let ftypeMap   = get(g:tcommentSyntaxMap, syntaxName)
            if !empty(ftypeMap)
                return s:GetCustomCommentString(ftypeMap, a:commentMode, cms)
            elseif syntaxName =~ g:tcommentFileTypesRx
                let ft = substitute(syntaxName, g:tcommentFileTypesRx, '\1', '')
                if exists('g:tcommentIgnoreTypes_'. a:filetype) && g:tcommentIgnoreTypes_{a:filetype} =~ '\<'.ft.'\>'
                    let m = m + 1
                else
                    return s:GetCustomCommentString(ft, a:commentMode, cms)
                endif
            elseif syntaxName == '' || syntaxName == 'None' || syntaxName =~ '^\u\+$' || syntaxName =~ '^\u\U*$'
                let m = m + 1
            else
                break
            endif
        endwh
        let n = n + 1
    endwh
    return [cms, commentMode]
endf

function! s:CommentMode(commentMode, newmode) "{{{3
    return substitute(a:commentMode, '\w\+', a:newmode, 'g')
endf

function! s:GuessCurrentCommentString(commentMode)
    let valid_cms = (stridx(&commentstring, '%s') != -1)
    if &commentstring != s:defaultCommentString && valid_cms
        " The &commentstring appears to have been set and to be valid
        return &commentstring
    endif
    if &comments != s:defaultComments
        " the commentstring is the default one, so we assume that it wasn't 
        " explicitly set; we then try to reconstruct &cms from &comments
        let cms = s:ConstructFromComments(a:commentMode)
        if cms != s:nullCommentString
            return cms
        endif
    endif
    if valid_cms
        " Before &commentstring appeared not to be set. As we don't know 
        " better we return it anyway if it is valid
        return &commentstring
    else
        " &commentstring is invalid. So we return the identity string.
        return s:nullCommentString
    endif
endf

function! s:ConstructFromComments(commentMode)
    exec s:ExtractCommentsPart('')
    if a:commentMode =~# 'G' && line != ''
        return line .' %s'
    endif
    exec s:ExtractCommentsPart('s')
    if s != ''
        exec s:ExtractCommentsPart('e')
        " if a:commentMode
        "     exec s:ExtractCommentsPart("m")
        "     if m != ""
        "         let m = "\n". m
        "     endif
        "     return s.'%s'.e.m
        " else
        return s.' %s '.e
        " endif
    endif
    if line != ''
        return line .' %s'
    else
        return s:nullCommentString
    endif
endf

function! s:ExtractCommentsPart(key)
    " let key   = a:key != "" ? a:key .'[^:]*' : ""
    let key = a:key . '[bnflrxO0-9-]*'
    let val = substitute(&comments, '^\(.\{-},\)\{-}'. key .':\([^,]\+\).*$', '\2', '')
    if val == &comments
        let val = ''
    else
        let val = substitute(val, '%', '%%', 'g')
    endif
    let var = a:key == '' ? 'line' : a:key
    return 'let '. var .'="'. escape(val, '"') .'"'
endf

" s:GetCustomCommentString(ft, commentMode, ?default="")
function! s:GetCustomCommentString(ft, commentMode, ...)
    let commentMode   = a:commentMode
    let customComment = exists('g:tcomment_'. a:ft)
    if commentMode =~# 'B' && exists('g:tcomment_'. a:ft .'_block')
        let cms = g:tcomment_{a:ft}_block
    elseif commentMode =~? 'I' && exists('g:tcomment_'. a:ft .'_inline')
        let cms = g:tcomment_{a:ft}_inline
    elseif customComment
        let cms = g:tcomment_{a:ft}
        let commentMode = s:CommentMode(commentMode, 'G')
    elseif a:0 >= 1
        let cms = a:1
        let commentMode = s:CommentMode(commentMode, 'G')
    else
        let cms = ''
        let commentMode = s:CommentMode(commentMode, 'G')
    endif
    return [cms, commentMode]
endf

function! s:BlockGetCommentString(cms)
    " return substitute(a:cms, '\n.*$', '', '')
    return matchstr(a:cms, '^.\{-}\ze\(\n\|$\)')
endf

function! s:BlockGetMiddleString(cms)
    " let rv = substitute(a:cms, '^.\{-}\n\([^\n]*\)', '\1', '')
    let rv = matchstr(a:cms, '\n\zs.*')
    return rv == a:cms ? '' : rv
endf


redraw

