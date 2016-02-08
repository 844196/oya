class Oya::Handler
  include Observable

  attr_accessor :target, :interval, :startup_msg, :shutdown_msg

  def initialize
    yield(self) if block_given?
    @last_status  = current_status
  end

  def watch
    Signal.trap(:INT) do
      notify_observers(:message => shutdown_msg, :command => ':')
      exit(1)
    end

    notify_observers(:message => startup_msg, :command => ':')
    loop do
      sleep interval
      notify_observers(:changed_file => target) if target_changed?
    end
  end

  def notify_observers(params={})
    changed
    super(params.merge(:time => Time.now))
  end

  private

  def current_status
    Digest::MD5.file(target)
  end

  def target_changed?
    (current_status != @last_status).tap { @last_status = current_status }
  end
end
