class Oya::Observers::Command < Oya::Observers::Observer
  def initialize(command_str)
    @command_str = command_str
  end

  def execute(params={})
    system(params[:command] || @command_str)
  end

  alias :update :execute
end
