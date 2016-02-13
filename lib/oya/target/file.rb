class Oya::Target::File
  def initialize(path)
    @path = File.expand_path(path)
    @last_hashsum = current_hashsum
  end

  def changed?
    (current_hashsum != @last_hashsum).tap { @last_hashsum = current_hashsum }
  end

  private

  def current_hashsum
    Digest::MD5.file(@path)
  end
end
