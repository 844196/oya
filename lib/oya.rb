# ruby default bundle library
require 'digest/md5'
require 'observer'

# handmade library
module Oya; end
require 'oya/version'
require 'oya/watcher'

module Oya::Target; end
require 'oya/target/file'

module Oya::Handler; end
require 'oya/handler/base'
require 'oya/handler/command'
require 'oya/handler/shell_notifier'
require 'oya/handler/desktop_notifier'

# syntax sugar
module Oya::Watch; end
class << Oya::Watch
  def to(path, *params, &block)
    target = Oya::Target::File.new(path)
    Oya::Watcher.new(target, *params, &block).start
  end
end
