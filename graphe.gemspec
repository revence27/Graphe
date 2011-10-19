Gem::Specification.new do |s|
  s.name    = 'graphe'
  s.version = '1.0'
  s.date    = '2011-10-19'
  s.summary = %[Generates a static HTML Bible from the XML files at http://code.google.com/p/churchsoftware/downloads/list]
  s.files   = ['lib/graphe.rb', 'lib/template.html']
  s.add_dependency 'hpricot'
  s.add_dependency 'pagina'
  s.files   = ['lib/template.html']
  s.author  = 'Revence Kalibwani'
  s.requirements << 'pagina can be got from https://github.com/revence27/pagina'
end
