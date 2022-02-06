" Requires the fzf-vim plugin to work.
" Performs cscope queries against
"     .cscope.big
"     .cscope.small
"     cscope.out
" Uses fzf-vim to display results and previews.

if has("cscope")
" type values copied from :cs command
"        a: Find assignments to this symbol
"        c: Find functions calling this function
"        d: Find functions called by this function
"        e: Find this egrep pattern
"        f: Find this file
"        g: Find this definition
"        i: Find files #including this file
"        s: Find this C symbol
"        t: Find this text string
function! CscopeFZF(type, query, ...)
	let path    = get(a:, 2, ".")

	if a:type == "a"
		let arg = "-9"
	elseif a:type == "c"
		let arg = "-3"
	elseif a:type == "d"
		let arg = "-2"
	elseif a:type == "e"
		let arg = "-6"
	elseif a:type == "f"
		let arg = "-7"
	elseif a:type == "g"
		let arg = "-1"
	elseif a:type == "i"
		let arg = "-8"
	elseif a:type == "s"
		let arg = "-0"
	elseif a:type == "t"
		let arg = "-4"
	else
		echom "invalid type; use types from :cs command"
		return
	end

	" Native cscope
	let l:native_cmd = ""

	" cscope_dynamic
	let l:small_ref = ".cscope.small"
	let l:big_ref = ".cscope.big"
	let l:small_cmd = ""
	let l:big_cmd = ""

	if filereadable(l:big_ref)
		if filereadable(l:small_ref)
			let l:small_cmd = "cscope -dL -f " . l:small_ref . " " . arg . " '" . a:query . "'; "
		endif
		let l:big_cmd = "cscope -dL -f " . l:big_ref . " " . arg . " '" . a:query . "'; "
	else
		let l:native_cmd = "cscope -dL " . arg . " '" . a:query . "'; "
	endif

	" convert "<file> <func> <line number> <line>" into a colorized
	"         "<file>:<line number> <func> <line>"
	let var = "file = $1; $1 = \"\"; $2 = \"\\033[32m<\"$2\">\\033[0m\" ;line_num = $3; $3 = \"\";"
	let color = "{ " . var . ' printf "\033[36m%s\033[0m:\033[33m%s\033[0m\011\033[37m%s\033[0m\n", file, line_num, $0; }'
	let cmd = "(" . l:small_cmd . l:big_cmd . l:native_cmd . ") | awk '" . color . "'"
	call fzf#vim#grep(cmd, 1, fzf#vim#with_preview(), 0)
endfunction

command! -bang -nargs=* CscopeFZFAssignment    call CscopeFZF("a", <q-args>)
command! -bang -nargs=* CscopeFZFCaller        call CscopeFZF("c", <q-args>)
command! -bang -nargs=* CscopeFZFCallee        call CscopeFZF("d", <q-args>)
command! -bang -nargs=* CscopeFZFEgrep         call CscopeFZF("e", <q-args>)
command! -bang -nargs=* CscopeFZFFile          call CscopeFZF("f", <q-args>)
command! -bang -nargs=* CscopeFZFGlobal        call CscopeFZF("g", <q-args>)
command! -bang -nargs=* CscopeFZFInclude       call CscopeFZF("i", <q-args>)
command! -bang -nargs=* CscopeFZFSymbol        call CscopeFZF("s", <q-args>)
command! -bang -nargs=* CscopeFZFText          call CscopeFZF("t", <q-args>)

" Frequently used mappings
nnoremap <silent> <Leader>cg :call CscopeFZF("g", "<C-R><C-W>")<CR>
nnoremap <silent> <Leader>cc :call CscopeFZF("c", "<C-R><C-W>")<CR>
nnoremap <silent> <Leader>cf :call CscopeFZF("f", "<C-R><C-W>")<CR>
nnoremap <silent> <Leader>cs :call CscopeFZF("s", "<C-R><C-W>")<CR>
nnoremap <silent> <Leader>ct :call CscopeFZF("t", "<C-R><C-W>")<CR>

nnoremap <Leader>cG :CscopeFZFGlobal<SPACE>
nnoremap <Leader>cC :CscopeFZFCaller<SPACE>
nnoremap <Leader>cF :CscopeFZFFile<SPACE>
nnoremap <Leader>cT :CscopeFZFText<SPACE>
nnoremap <Leader>cS :CscopeFZFSymbol<SPACE>

endif
