local fmt = string.format

local Pairs = {
  pairs = {
    ['*'] = {
      {'(', ')'},
      {'[', ']'},
      {'{', '}'},
      {"'", "'"},
      {'"', '"'},
    },
    lua = {
      {'(', ')', {ignore_pre = '[%\\]', ignore = {'%(', '%)'}}},
      {'[', ']', {ignore_pre = '[%\\]', ignore = {'%[', '%]'}}},
      {'{', '}', {ignore_pre = '[%\\]', ignore = {'%{', '%}'}}},
    },
    python = {
      {"'", "'", {triplet = true}},
      {'"', '"', {triplet = true}},
    },
    markdown = {
      {"'", "'", {triplet = true}},
      {'"', '"', {triplet = true}},
    }
  },
  extra_ignore = {
    lua = {'%(', '%)', '%[', '%]', '%{', '%}'}
  },
  cache = {}
}

Pairs.__index = Pairs

-- Pair
local Pr = {}
Pr.__index = Pr

function Pr:new(pair)
  if type(pair) ~= 'table' then
    error('expect a pair table, but get a ' .. type(pair))
  end
  if #pair < 2 then
    error('expect length of pair table to greater than 1, bug the length is ' .. #pair)
  end
  return setmetatable({left = pair[1], right = pair[2], opts = pair[3] or {}}, Pr)
end

function Pairs:set_keymap()
  local map = function(lhs, rhs)
    vim.api.nvim_set_keymap('i', lhs, rhs, {silent = true})
  end
  for _, pair in pairs(self.lr['*']) do
    local l, r = pair.left, pair.right
    map(l, fmt([[<cmd>lua require('pairs'):type_left("%s")<cr>]], l:gsub('"', '\\"')))
    map(r, fmt([[<cmd>lua require('pairs'):type_right("%s")<cr>]], r:gsub('"', '\\"')))
  end
  map('<space>', [[<cmd>lua require('pairs'):type_space()<cr>]])
  map('<bs>', [[<cmd>lua require('pairs'):type_del()<cr>]])
  -- vim.api.nvim_set_keymap('i', '<bs>', [[v:lua.require('pairs').type_del() ? '' : "\<bs>"]], {silent = true, expr = true})
end

function Pairs:set_buf_keymap()
  local map = function(lhs, rhs)
    vim.api.nvim_buf_set_keymap(0, 'i', lhs, rhs, {silent = true})
  end
  for _, pair in pairs(self.lr[vim.o.filetype]) do
    local l, r = pair.left, pair.right
    map(l, fmt([[<cmd>lua require('pairs'):type_left("%s")<cr>]], l:gsub('"', '\\"')))
    map(r, fmt([[<cmd>lua require('pairs'):type_right("%s")<cr>]], r:gsub('"', '\\"')))
  end
end

-- @field pairs table: custom pairs
function Pairs:setup(opts)
  opts = opts or {}
  for ft, pairs in pairs(opts.pairs or {}) do
    self.pairs[ft] = pairs
  end
  for ft, extra in pairs(opts.extra_ignore or {}) do
    self.extra_ignore[ft] = extra
  end
  -- init pair map
  self.lr, self.rl = {}, {}
  local new_pairs = {}
  for ft, pairs in pairs(self.pairs) do
    local ft_pairs = {}
    self.lr[ft], self.rl[ft] = {}, {}
    for _, pair in ipairs(pairs) do
      pair = Pr:new(pair)
      if not pair.opts.ignore_pre then
        if pair.left == "'" then
          pair.opts.ignore_pre = '[a-zA-Z\\]'
        else
          pair.opts.ignore_pre = '\\'
        end
      end
      table.insert(ft_pairs, pair)
      self.lr[ft][pair.left] = pair
      self.rl[ft][pair.right] = pair
    end
    new_pairs[ft] = ft_pairs
  end
  self.pairs = new_pairs
  self:set_keymap()
  vim.cmd([[
    aug Pairs
      au!
      au BufRead,BufNew * lua require('pairs'):set_keymap()
    aug END
  ]])
end

-- given right bracket, get the left one
-- @param right string right bracket
function Pairs:get_left(right)
  local ft = vim.o.filetype
  if self.rl[ft] and self.rl[ft][right] then
    return self.rl[ft][right].left
  end
  if self.rl['*'] and self.rl['*'][right] then
    return self.rl['*'][right].left
  end
  error(fmt('the right bracket %s is not defined', right))
end

-- given left bracket, get the right one
-- @param left string left bracket
function Pairs:get_right(left)
  local ft = vim.o.filetype
  if self.lr[ft] and self.lr[ft][left] then
    return self.lr[ft][left].right
  end
  if self.lr['*'] and self.lr['*'][left] then
    return self.lr['*'][left].right
  end
  error(fmt('the left bracket %s is not defined', left))
end

function Pairs:get_opts(left)
  local ft = vim.o.filetype
  if self.lr[ft] and self.lr[ft][left] then
    return self.lr[ft][left].opts
  end
  if self.lr['*'] and self.lr['*'][left] then
    return self.lr['*'][left].opts
  end
  error(fmt('the left bracket %s is not defined', left))
end

-- get extra ignore pattern by left bracket
function Pairs:get_ignore(left)
  local ignore = self:get_opts(left).ignore or {}
  if type(ignore) == 'string' then
    return {ignore}
  end
  return ignore
end

-- test whether the left bracket exists
function Pairs:exists(left)
  local ft = vim.o.filetype
  if self.lr[ft] and self.lr[ft][left] then
    return true
  end
  if self.lr['*'] and self.lr['*'][left] then
    return true
  end
  return false
end

function Pairs:get_pairs()
  local ft = vim.o.filetype
  if self.cache[ft] and self.cache[ft].pairs then
    return self.cache[ft].pairs
  end
  local lr = {}
  local _pairs = {}
  for _, pair in pairs(self.lr['*'] or {}) do
    lr[pair.left] = pair
  end
  for _, pair in pairs(self.lr[ft] or {}) do
    lr[pair.left] = pair
  end
  for _, pair in pairs(lr) do
    table.insert(_pairs, pair)
  end
  self.cache[ft] = self.cache[ft] or {}
  self.cache[ft].pairs = _pairs
  return _pairs
end

local function escape(str)
  local e = {'%', '(', ')', '[', '.', '*', '+', '-', '?', '^', '$'}
  for _, ch in ipairs(e) do
    str = str:gsub('%' .. ch, '%%%' .. ch)
  end
  return str
end

-- remove escaped brackets and ignore pattern
-- @param line string: line to be processed
-- @param left string: left bracket
-- @return string: clean line
local function clean(line, left)
  line = line:gsub('\\' .. escape(left), '')
  local right = Pairs:get_right(left)
  if right ~= left then
    line = line:gsub('\\' .. escape(right), '')
  end
  local ignore = Pairs:get_ignore(left)
  for _, pattern in ipairs(ignore) do
    line = line:gsub(escape(pattern), '')
  end
  return line
end

-- count the number of left brackets with remove of corresponding pairs
-- @param str string
-- @param left string: left bracket
-- @param right string: right bracket
local function count(str, left, right)
  local cur = 1
  local n = 0
  local ln, rn, sn = #left, #right, #str
  repeat
    if str:sub(cur, cur + ln - 1) == left then
      n = n + 1
      cur = cur + #left
    elseif str:sub(cur, cur + rn - 1) == right then
      n = n > 0 and n - 1 or n
      cur = cur + #right
    else
      cur = cur + 1
    end
  until (cur > sn)
  return n
end

-- @return left and right part of line separated by cursor
local function get_line()
  local col = vim.fn.col('.') - 1
  local line = vim.api.nvim_get_current_line()
  local left_line = vim.fn.strpart(line, 0, col)
  local right_line = vim.fn.strpart(line, col)
  return left_line, right_line
end

-- test whether to ignore the current bracket, e.g., just typeset one
-- @param left_line string: left part of current line separated by the cursor
-- @param left string: left bracket
-- @return boolean
function Pairs:get_ignore_pre(left_line, left)
  local opts = self:get_opts(left)
  local ignore_pre = opts.ignore_pre
  local pattern = ignore_pre:gsub('\\', '\\\\') .. '$'
  return ignore_pre and vim.fn.match(left_line, pattern) ~= -1
end

-- get left bracket count on the left and the right bracket count on the right
local function get_count(left_line, right_line, left, right)
  local l = clean(left_line, left)
  local r = clean(right_line, left)
  local lc = count(l, left, right)
  local rc = count(r:reverse(), right:reverse(), left:reverse())
  return lc, rc
end

-- action when typeset the left bracket
function Pairs:type_left_neq(left, right)
  local left_line, right_line = get_line()
  local ignore = self:get_ignore_pre(left_line, left)

  if not ignore then
    local lc, rc = get_count(left_line, right_line, left, right)
    if lc >= rc then
      right_line = right .. right_line
    end
  end

  left_line = left_line .. left
  vim.api.nvim_set_current_line(left_line .. right_line)
  local pos = vim.api.nvim_win_get_cursor(0)
  pos[2] = vim.api.nvim_strwidth(left_line)
  vim.api.nvim_win_set_cursor(0, pos)
end

-- action when typeset the right bracket
-- @param right bracket
function Pairs:type_right_neq(left, right)
  local left_line, right_line = get_line()
  local lc, rc = get_count(left_line, right_line, left, right)
  local pos = vim.api.nvim_win_get_cursor(0)
  -- lots of left brackets more than right, we need the right one
  -- or the first right bracket is to be typeset after revoming the counterbalances on the right
  if lc > rc or rc == 0 then
    left_line = left_line .. right
    pos[2] = vim.api.nvim_strwidth(left_line)
  -- now we have at least one right bracket on the right and then jump to it
  else
    local _, end_idx = right_line:find(right)
    pos[2] = pos[2] + vim.api.nvim_strwidth(right_line:sub(1, end_idx))
  end
  vim.api.nvim_set_current_line(left_line .. right_line)
  vim.api.nvim_win_set_cursor(0, pos)
end

-- count occurrences of bracket, ignore escaped ones
-- @param line string: line to be searched
-- @param bracket: pattern
-- @return number
local function match_count(line, bracket)
  line = clean(line, bracket)
  local n = 0
  for _ in line:gmatch(escape(bracket)) do n = n + 1 end
  return n
end

-- action when two brackets are equal
-- @param bracket string
function Pairs:type_eq(bracket)
  local left_line, right_line = get_line()
  local left_count = match_count(left_line, bracket)
  local right_count = match_count(right_line, bracket)
  local pos = vim.api.nvim_win_get_cursor(0)

  -- process triplet bracket
  if self:get_opts(bracket).triplet then
    local pattern = escape(bracket)
    local l = left_line
    local n = 0
    repeat
      local i, _ = l:find(pattern .. '$')
      if i then
        n = n + 1
        l = l:sub(1, i - 1)
      end
    until (n > 2 or i == nil)
    local valid = n == 2 and not right_line:match('^' .. pattern)
    if valid then
      left_line = left_line .. bracket
      right_line = string.rep(bracket, 3) .. right_line
      pos[2] = vim.api.nvim_strwidth(left_line)
      vim.api.nvim_set_current_line(left_line .. right_line)
      vim.api.nvim_win_set_cursor(0, pos)
      return
    end
  end

  -- complete anothor bracket
  local complete = function()
    left_line = left_line .. bracket
    pos[2] = vim.api.nvim_strwidth(left_line)
  end
  -- typeset two brackets
  local typeset = function()
    right_line = bracket .. right_line
    complete()
  end

  local ignore_pre = self:get_ignore_pre(left_line, bracket)

  -- number of brackets of current line is odd, always complete
  if ignore_pre or (left_count + right_count) % 2 == 1 then
    complete()
  -- number of brackets of current line is even
  -- number of brackets of left side is even, which means the right side is also even
  -- typeset two brackets
  elseif left_count % 2 == 0 then -- typeset all
    typeset()
  -- left side is odd and right side is odd, which means you are inside the bracket scope
  else
    local i, j = right_line:find(bracket)
    -- jump only if the right bracket is next to the cursor
    if i == 1 then
      pos[2] = pos[2] + vim.api.nvim_strwidth(right_line:sub(1, j))
    else -- typeset two brackets
      typeset()
    end
  end

  vim.api.nvim_set_current_line(left_line .. right_line)
  vim.api.nvim_win_set_cursor(0, pos)
end

function Pairs:type_left(left)
  local right = self:get_right(left)
  if left == right then
    self:type_eq(left)
  else
    self:type_left_neq(left, right)
  end
end

function Pairs:type_right(right)
  local left = self:get_left(right)
  if left == right then
    self:type_eq(right)
  else
    self:type_right_neq(left, right)
  end
end

function Pairs:type_space()
  local left_line, right_line = get_line()

  for _, pair in ipairs(self:get_pairs()) do
    local pl = escape(pair.left) .. '$'
    local pr = '^' .. escape(pair.right)
    if left_line:match(pl) and right_line:match(pr) then
      right_line = ' ' .. right_line
      break
    end
  end

  left_line = left_line .. ' '
  vim.api.nvim_set_current_line(left_line .. right_line)
  local pos = vim.api.nvim_win_get_cursor(0)
  pos[2] = vim.api.nvim_strwidth(left_line)
  vim.api.nvim_win_set_cursor(0, pos)
end

function Pairs:type_del()
  local left_line, right_line = get_line()
  local pos = vim.api.nvim_win_get_cursor(0)

  local bs = function()
    local key = vim.api.nvim_replace_termcodes("<bs>", true, false, true)
    vim.api.nvim_feedkeys(key, 'n', true)
  end

  local type_bs = function(del_l, del_r)
    left_line = left_line:sub(1, #left_line - del_l)
    right_line = right_line:sub(del_r + 1)
    vim.api.nvim_set_current_line(left_line .. right_line)
    pos[2] = vim.api.nvim_strwidth(left_line)
    vim.api.nvim_win_set_cursor(0, pos)
  end

  for _, pair in ipairs(Pairs:get_pairs()) do
    local left_blank = left_line:match(escape(pair.left) .. '(%s*)$')
    local right_blank = right_line:match('^(%s*)' .. escape(pair.right))
    if not left_blank or not right_blank then goto continue end
    local bnl = #left_blank
    local bnr = #right_blank
    if bnl == 1 and bnr == 0 then break
    elseif bnl == 1 and bnr == 1 then -- trim blank
      type_bs(1, 1)
      goto finish
    elseif bnl >= 1 and bnr >= 1 then -- leave two blank
      type_bs(bnl - 1, bnr - 1)
      goto finish
    else -- del bracket
      local lc, rc = get_count(left_line, right_line, pair.left, pair.right)
      if lc > rc then break end -- noraml deletion
      type_bs(1, bnr + 1)
      goto finish
    end
    ::continue::
  end

  bs()
  ::finish::
end

return Pairs
