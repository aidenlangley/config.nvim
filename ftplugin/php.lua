local utils = require('utils')
local linters = require('lint').linters
linters.phpstan.cmd = utils.path_or({
  './vendor/bin/phpstan',
  './vendor/bin/phpstan.phar',
}, 'phpstan')

local psalm = linters.psalm
psalm.cmd = utils.path_or({
  './vendor/bin/psalm',
  './vendor/bin/psalm.phar',
}, 'psalm')
psalm.ignore_exitcode = true
