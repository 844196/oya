class Oya::Watcher
  include Observable

  @@default_attributes = {
    :target       => nil,
    :interval     => 1,
    :startup_msg  => 'Watch start!',
    :shutdown_msg => 'Bye!'
  }
  @@default_attributes.each_key {|name| attr_accessor(name) }

  def initialize(target, params={}, &block)
    @@default_attributes.merge(params).each {|k,v| send("#{k.to_s}=", v) }
    @target = target
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
