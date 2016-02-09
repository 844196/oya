require 'rake'

TARGET   = 'oya'
PREFIX   = ENV['PREFIX'] || '/usr/local'
BINDIR   = "#{PREFIX}/bin"
LIBDIR   = "#{PREFIX}/lib"
SHAREDIR = "#{PREFIX}/share"

task :install_bin do
  `ruby -run -e mkdir -- -p #{BINDIR}`
  `ruby -run -e install -- -pm 755 ./bin/#{TARGET} #{BINDIR}/`
end

task :install_lib do
  `ruby -run -e mkdir -- -p #{LIBDIR}`
  `ruby -run -e cp -- -r ./lib/* #{LIBDIR}`
  Dir.glob("#{LIBDIR}/**/*").each {|path| `ruby -run -e chmod -- 644 #{path}` unless File.directory?(path)  }
end

task :install_share do
  `ruby -run -e mkdir -- -p #{SHAREDIR}/#{TARGET}`
  `ruby -run -e install -- -pvm 644 ./share/#{TARGET}/* #{SHAREDIR}/#{TARGET}/`
end

desc 'install package'
task :install => %w(install_bin install_lib install_share)
