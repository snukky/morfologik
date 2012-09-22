$:.unshift File.expand_path("../lib", __FILE__)

require 'rake'
require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.test_files = FileList['test/test_*.rb']
  t.ruby_opts = ['-rubygems -I.'] if defined? Gem
end

task :build do
  system "gem build morfologik.gemspec"
end

task :install do
  gem_file = Dir.glob('./morfologik-*.*.*.gem').sort.last
  system "gem install #{gem_file}"
end
