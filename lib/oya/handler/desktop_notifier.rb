module Oya::Handler::DesktopNotifiers
  class Notifier
    def executable?
      env_paths.any? {|path| File.exist?(File.join(path, @command)) }
    end

    private

    def env_paths
      ENV['PATH']&.split(File::PATH_SEPARATOR) || %w(/usr/local/bin/ /usr/bin /bin)
    end
  end

  class NotifySend < Notifier
    def initialize
      @command = 'notify-send'
    end

    def execute(params)
      command_line = [
        @command,
        '--app-name', params[:app_name],
        '--icon', params[:icon_path],
        params[:title],
        params[:message]
      ]
      system(*command_line)
    end
  end
end

class Oya::Handler::DesktopNotifier < Oya::Handler::Base
  def initialize(message)
    @message = message
  end

  def show(params={})
    command&.execute(
      :app_name => app_name,
      :icon_path => icon_path,
      :title => (params[:title] || app_name),
      :message => (params[:message] || @message)
    )
  end

  alias :update :show

  private

  def command
    @command ||= commands.find {|cmd| cmd.executable? }
  end

  def commands
    [
      Oya::Handler::DesktopNotifiers::NotifySend.new
    ]
  end
end
