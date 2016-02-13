class Oya::Watcher
  include Observable

  attr_accessor :target, :interval, :startup_msg, :shutdown_msg
  @@default_options = {:interval => 1, :startup_msg => 'Watch start!', :shutdown_msg => 'Bye!'}

  def initialize(target, params={}, &block)
    @target = target
    @@default_options.merge(params).each {|k,v| send("#{k.to_s}=", v) }
    yield self if block_given?
  end

  def add_handler(handler)
    add_observer(handler)
  end

  def start
    Signal.trap(:INT) do
      notify_handlers(:message => shutdown_msg, :command => ':')
      exit(1)
    end

    notify_handlers(:message => startup_msg, :command => ':')
    loop do
      sleep interval
      notify_handlers(:changed_file => target) if target.changed?
    end
  end

  private

  def notify_handlers(params={})
    changed
    notify_observers(params.merge(:time => Time.now))
  end
end
