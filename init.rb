require 'redmine'

Redmine::Plugin.register :redmine_iterations do
  name 'Redmine Iterations plugin'
  author 'Dave Marshall'
  description 'Simple voting and volunteering to manage iterations'
  version '0.0.1'
  url 'http://davedevelopment.co.uk'
  author_url 'http://davedevelopment.co.uk'

  menu :top_menu, :iterations, { :controller => 'iterations', :action => 'list'}, :caption => 'Iterations'
end
