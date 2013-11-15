require 'rubygems'
require 'irb/completion'
require 'irb/ext/save-history'

IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb-save-history"
IRB.conf[:SAVE_HISTORY] = 100
IRB.conf[:AUTO_INDENT] = true
