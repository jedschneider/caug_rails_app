ActionController::Routing::Routes.draw do |map|
  map.resources :flu_report, :has_many => :us_states
  map.root :controller=>'flu_report', :action=>'index'

end
