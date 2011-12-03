require 'rubygems'
require 'wirble'
require 'hirb'
require 'interactive_editor'
require 'irb/completion'
require 'irb/ext/save-history'

Wirble.init
Wirble.colorize

Hirb::View.enable

IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb-save-history"
IRB.conf[:SAVE_HISTORY] = 100
IRB.conf[:AUTO_INDENT] = true
