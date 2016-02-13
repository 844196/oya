class Oya::Watcher
  include Observable

  @@default_attributes = {
    :target       => nil,
    :interval     => 1,
    :thread       => nil,
    :startup_msg  => 'Watch start!',
    :shutdown_msg => 'Bye!'
  }
  @@default_attributes.each_key {|name| attr_accessor(name) }

  def initialize(target, params={}, &block)
    @@default_attributes.merge(params).each {|k,v| send("#{k.to_s}=", v) }
    @target = target
    instance_eval(&block) if block_given?
  end

  def add_handler(handler)
    add_observer(handler)
  end

  def start
    @thread = Thread.fork do
      begin
        notify_handlers(:message => startup_msg, :startup => true)
        loop do
          sleep interval
          notify_handlers if target.changed?
        end
      ensure
        notify_handlers(:message => shutdown_msg, :shutdown => true)
      end
    end
    @thread.run
  end

  def stop
    @thread&.kill
    @thread = nil
  end

  def to_h
    @@default_attributes.map {|key,_| [key, instance_variable_get("@#{key}")] }.to_h
  end

  private

  def notify_handlers(params={})
    changed
    notify_observers(to_h.merge(params).merge(:time => Time.now))
  end
end
