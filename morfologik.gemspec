Gem::Specification.new do |s|
  s.name        = 'morfologik'
  s.version     = '0.0.3'
  s.date        = '2012-09-22'
  s.authors     = ["snukky"]
  s.email       = ['snk987@gmail.com']
  s.homepage    = 'http://github.com/snukky/morfologik'
  s.summary     = "Ruby MRI bindings for morfologik-stemming library."
  s.files       = %w{lib/morfologik.rb 
                     lib/morfologik/output_parser.rb 
                     lib/morfologik/tagset_parser.rb
                     lib/morfologik/jar/morfologik-tools-1.5.2-standalone.jar}
end
