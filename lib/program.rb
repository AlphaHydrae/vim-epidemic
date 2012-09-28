require File.join File.dirname(__FILE__), 'vim-epidemic'
require 'commander/import'

program :name, 'vim-epidemic'
program :version, VimEpidemic::VERSION
program :description, 'Downloads vim plugins and installs them into the pathogen.vim bundle directory.'

controller = VimEpidemic::Controller.new

command :info do |c|
  c.syntax = 'vim-epidemic'
  c.description = 'Show configuration and list installed plugins (default action)'
  c.action do |args,options|
    controller.info options
  end
end

command :update do |c|
  c.syntax = 'vim-epidemic update'
  c.description = 'Installs configured plugins'
  c.action do |args,options|
    controller.update options
  end
end

default_command :info

