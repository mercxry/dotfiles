--
-- ##   ## ######## #######   ###### ###  ## #######  ###  ##
-- ### ###                ## ###     ###  ##       ## ###  ##
-- #######  #######  ######  ###      #####   ######  #######
-- ## # ##  ###      ##  ##  ###     ###  ##  ##  ##    ###  
-- ##   ##  #######  ##   ##  ###### ###  ##  ##   ##   ###  
-- ##                 6D 65 72 63 78 72 79              ###
--
-- Matteo Martellini
-- https://twitter.com/mttni
-- https://github.com/mercxry

-- Check if packer and the plugin impatient are installed before requiring it
local fn = vim.fn
local packer_install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) == 0 and packer_plugins['impatient'] then
  require 'impatient'
end

require 'globals'
require 'mappings'
require 'plugins'
require 'theme'

