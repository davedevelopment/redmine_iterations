ActionController::Routing::Routes.draw do |map|
    map.connect '/iterations', :action => 'list', :controller => 'iterations'
    map.connect '/iterations/rss', :action => 'rss', :controller => 'iterations'
    map.connect '/iterations/comment', :action => 'comment', :controller => 'iterations'
    map.connect '/iterations/suggest', :action => 'suggest', :controller => 'iterations'
    map.connect '/iterations/create', :action => 'create', :controller => 'iterations'
    map.connect '/iterations/:id', :action => 'view', :controller => 'iterations', :requirements => { :id => /\d+/ }
    map.connect '/iterations/:status', :action => 'list', :controller => 'iterations'
end
