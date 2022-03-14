local mode = require('line.providers.mode')
local path = require('line.providers.path')
local pos  = require('line.providers.pos')
local fileinfo  = require('line.providers.fileinfo')

local stl = require('rabbitline.stl'):new { is_tab = false }

stl:new_group {
  mode.left, mode.mode, mode.right,
  path.left, path.path, path.right,
}

stl:new_group {
  fileinfo.left, fileinfo.fileinfo, fileinfo.right,
  pos.left, pos.pos, pos.right
}

require('rabbitline').setup {
  stl = {
    update_func = function() stl:update() end
  }
}
