desc 'Bootstrap the project'
task :bootstrap do
  sh 'bundle install'
end

namespace :spec do
  def specs dir = '**'
    FileList["spec/#{dir}/*_spec.rb"].shuffle.join ' '
  end

  desc "Automatically run specs for updated files"
  task :kick do
    exec "bundle exec kicker -c"
  end

  desc "Run all specs"
  task :all do
    sh "bundle exec bacon #{specs}"
  end
end

desc "Run all specs"
task :spec => 'spec:all'

task :default => :spec

begin
  desc "Starts processes for local development"
  task :serve do
    exec "env PORT=7777 RACK_ENV=development foreman start"
  end
end
