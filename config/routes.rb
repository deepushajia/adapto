Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  match 'login' => 'sessions#show', :via => [:post,:options]
  match 'register' => 'sessions#create', :via => [:post,:options]
  match 'generate_test' => 'test_page#new', :via => :get
  match 'submission' => 'test_page#create', :via => [:post,:options]
  match 'get_analytics' => 'analytics#new', :via => :get
  match 'topics_list' => 'question_bank#new', :via => :get
  match 'topic_questions' => 'question_bank#display', :via => :get
  match 'get_current' => 'analytics#get_current', :via => :get
  match 'interface' => 'interface#index', :via => :get
  match 'interface/show' => 'interface#show', :via => [:post,:options]

end
