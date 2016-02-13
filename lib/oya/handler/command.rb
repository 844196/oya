class Oya::Handler::Command < Oya::Handler::Base
  def initialize(command_str)
    @command_str = command_str
  end

  def execute(params={})
    system(params[:command] || @command_str) unless params[:startup] || params[:shutdown]
  end

  alias :update :execute
end
