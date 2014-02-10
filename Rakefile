gem 'rspec', '~>2'
require 'rspec/core/rake_task'

desc "run checkers specs"
RSpec::Core::RakeTask.new do |task|
  task.pattern = "spec/*_spec.rb"
  task.rspec_opts = [ '-f documentation', '-r ./spec/rspec_config' ]
  task.verbose = false
end

task :play do
  require "./lib/checkers"
  game = Checkers::Game.new
  game.play
end

task default: :play

