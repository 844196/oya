class Oya::Observers::ShellNotifier < Oya::Observers::Observer
  def initialize(message)
    @message = message
  end

  def show(params={})
    puts "\n[#{params[:time]}] #{(params[:message] || @message)}"
  end

  alias :update :show
end
