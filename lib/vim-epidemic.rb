# encoding: UTF-8
require 'paint'
require 'which_works'

module VimEpidemic
  VERSION = '0.0.1'
end

[ :config, :controller, :plugin ].each do |lib|
  require File.join(File.dirname(__FILE__), 'vim-epidemic', lib.to_s)
end
