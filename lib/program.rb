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

command :add do |c|
  c.syntax = 'vim-epidemic add <REPO>'
  c.description = 'Adds a plugin repository to install (run "update" to install)'
  c.action do |args, options|
    controller.add args, options
  end
end

default_command :info

