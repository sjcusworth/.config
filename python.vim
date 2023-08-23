" Python ##############################################################################
au BufNewFile,BufRead *.py
	\ set tabstop=4 | 
	\ set softtabstop=4 | 
	\ set shiftwidth=4 |
	\ set textwidth=79 |
	\ set expandtab |
	\ set autoindent |
	\ set fileformat=unix |
	\ set foldmethod=indent |
    \ set nu 

let python_highlight_all=1

" deoplete settings
let g:deoplete#enable_at_startup = 1
call g:deoplete#custom#option("min_pattern_length", 1)
call g:deoplete#custom#option("smart_case", 1)
imap <expr><a-TAB> pumvisible() ? "\<C-n>" : (neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>")
imap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
" imap <expr><CR> pumvisible() ? deoplete#mappings#close_popup() : "\<CR>\<Plug>AutoPairsReturn"

" Ale
let g:ale_linters = {'python': 'all'}
"let g:ale_fixers = {'python': ['isort', 'yapf', 'remove_trailing_lines', 'trim_whitespace']}
"let g:ale_lsp_suggestions = 1
let g:ale_virtualtext_cursor = 'current'
let g:ale_fix_on_save = 0
let g:ale_completion_enabled = 0
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_sign_error = 'E'
let g:ale_sign_warning = 'W'
highlight clear ALEErrorSign
highlight clear ALEWarningSign
let g:ale_set_highlights = 0
" Write this in your vimrc file
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_enter = 1

" indent-blankline

" echodoc
let b:echodoc_enabled = 1
let g:echodoc#events = ['CompleteDone', 'TextChangedP']
let g:echodoc#type = "echo"
set cmdheight=2
let g:echodoc_enable_at_startup = 1

" dap
lua << EOF
	local std_debugpy_python = os.getenv('HOME') .. '/.virtualenvs/debugpy/bin/python3.10'
	local dap = require('dap')

	dap.adapters.python = {
		type = 'executable';
		command = std_debugpy_python;
		args = { '-m', 'debugpy.adapter' };
	}

	dap.configurations.python = {
	  {
		type = 'python';
		-- console = 'externalTerminal';
		request = 'launch';
		name = "Launch file";
		program = "${file}";
		pythonPath = function()
		if vim.fn.environ()['CONDA_PREFIX'] ~= 'base' then
			local active_python = vim.fn.environ()['CONDA_PREFIX'] .. '/bin/python'
			local yes_no_active_python = vim.fn.input('Use active python (' ..
													  active_python
													  .. ')? (y/n) ')
			if yes_no_active_python == 'n' or yes_no_active_python == 'N' then
			  local yes_no_default_python = vim.fn.input('Use default python (' ..
														 std_debugpy_python
														 .. ')? (y/n) ')
			  if yes_no == 'n' or yes_no == 'N' then
			   -- python.exe from user given path
				return vim.fn.input("Input python.exe path (cwd is " .. vim.fn.getcwd() .. "): ")
			  else
				-- python.exe from base anaconda environment
				return std_debugpy_python
			  end
			else
			  -- python.exe from active anaconda environment
			  return active_python
			end
		  else
			local yes_no_default_python = vim.fn.input('Use default python (' ..
													   std_debugpy_python
													   .. ')? (y/n) ')
			if yes_no == 'n' or yes_no == 'N' then
			 -- python.exe from user given path
			  return vim.fn.input("Input python.exe path (cwd is " .. vim.fn.getcwd() .. "): ")
			else
			  -- python.exe from base anaconda environment
			  return std_debugpy_python
			end
		  end
		end
	  },
	}

	local dap = require('dap')
	dap.defaults.fallback.external_terminal = {
		command = '/opt/homebrew/bin/kitty';
		args = {'-e'};
	}
	-- Use "tabnew" for all debug adapters
	-- dap.defaults.fallback.terminal_win_cmd = 'tabnew'
	-- dap.defaults.fallback.focus_terminal = false
	-- dap.defaults.fallback.force_external_terminal = false

	local user_config = {
	  icons = { expanded = "", collapsed = "", current_frame = "" },
	  mappings = {
		-- Use a table to apply multiple mappings
		expand = { "<CR>", "<2-LeftMouse>" },
		open = "o",
		remove = "d",
		edit = "e",
		repl = "r",
		toggle = "t",
	  },
	  element_mappings = {},
	  expand_lines = vim.fn.has("nvim-0.7") == 1,
	  force_buffers = true,
	  layouts = {
		{
		  -- You can change the order of elements in the sidebar
		  elements = {
			-- Provide IDs as strings or tables with "id" and "size" keys
			{ id = "scopes", size = 0.45 },
			{ id = "breakpoints", size = 0.5 },
			-- { id = "stacks", size = 0.25 },
			{ id = "watches", size = 0.1 },
			{ id = "console", size = 0.1 },
		  },
		  size = 30,
		  position = "right", -- Can be "left" or "right"
		},
		{
		  elements = {
			"repl",
		  },
		  size = 15,
		  position = "bottom", -- Can be "bottom" or "top"
		},
	  },
	  floating = {
		max_height = nil,
		max_width = nil,
		border = "single",
		mappings = {
		  ["close"] = { "q", "<Esc>" },
		},
	  },
	  controls = {
		enabled = true,
		element = "repl",
		icons = {
		  pause = "",
		  play = "",
		  step_into = "",
		  step_over = "",
		  step_out = "",
		  step_back = "",
		  run_last = "",
		  terminate = "",
		  disconnect = "",
		},
	  },
	  render = {
		max_type_length = nil, -- Can be integer or nil.
		max_value_lines = 100, -- Can be integer or nil.
		indent = 1,
	  },
	}
	require("dapui").setup(user_config)
EOF

map <Bslash>b :lua require'dap'.toggle_breakpoint()<CR> 
map <Bslash>r :lua require'dap'.continue()<CR> 
map <Bslash>g :lua require'dapui'.open()<CR> 

