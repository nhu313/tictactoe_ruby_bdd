require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:default)

RSpec::Core::RakeTask.new(:slow_test) do |t|
  t.rspec_opts = "--tag slow_test"
end

RSpec::Core::RakeTask.new(:test) do |t|
  t.rspec_opts = "--tag ~slow_test"
end

task :play do
  ruby "bin/tic_tac_toe"
end
