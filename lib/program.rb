require File.join File.dirname(__FILE__), 'vim-epidemic'
require 'commander/import'

program :name, 'vim-epidemic'
program :version, VimEpidemic::VERSION
program :description, 'Downloads vim plugins and installs them into the pathogen.vim bundle directory.'

