class Oya::Handler::ShellNotifier < Oya::Handler::Base
  def initialize(message)
    @message = message
  end

  def show(params={})
    puts "\n[#{params[:time]}] #{(params[:message] || @message)}"
  end

  alias :update :show
end
