# ruby default bundle library
require 'digest/md5'
require 'observer'

# handmade library
module Oya; end
require 'oya/version'
require 'oya/handler'

module Oya::Observers; end
require 'oya/observers/observer'
require 'oya/observers/command'
require 'oya/observers/shell_notifier'
require 'oya/observers/desktop_notifier'
