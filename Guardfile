require 'guard/guard'
require 'guard/kitchen'
require 'guard/foodcritic'
require 'guard/rubocop'
require 'guard/rspec'
require 'guard/minitest'
require 'guard/sheller'
require 'mixlib/shellout'
require 'safe_yaml'
SafeYAML::OPTIONS[:deserialize_symbols] = true
SafeYAML::OPTIONS[:default_mode] = :safe

scope group: :development

#notification :terminal_notifier, sticky: true
notification :tmux,
  display_message: true,
  timeout: 10,
  default_message_format: '%s >> %s',
  line_separator: ' > ',
  color_location: 'status-left-bg'

group :verify do
  guard 'kitchen' do
    watch(%r{test/.+})
    watch(%r{^lib/(.+)\.rb$})
    watch('spec/spec_helper.rb')  { "spec" }
    watch(%r{^recipes/(.+)\.rb$}) { |m| "spec/unit/recipes/#{m[1]}_spec.rb" }
    watch(%r{^attributes/(.+)\.rb$})
    watch(%r{^files/(.+)})
    watch(%r{^templates/(.+)})
    watch(%r{^providers/(.+)\.rb}) { |m| "spec/unit/providers/#{m[1]}_spec.rb" }
    watch(%r{^resources/(.+)\.rb}) { |m| "spec/unit/resources/#{m[1]}_spec.rb" }
  end
end

group :development, :halt_on_fail => true do
  guard :foodcritic, :cookbook_paths => '.', :all_on_start => true, :cli => '--epic-fail any' do
    watch(%r{attributes/.+\.rb$})
    watch(%r{providers/.+\.rb$})
    watch(%r{recipes/.+\.rb$})
    watch(%r{resources/.+\.rb$})
    watch(%r{^templates/(.+)})
    watch('metadata.rb')
  end

  guard :rubocop, :all_on_start => true do # :cli => ['--lint']
    watch(%r{attributes/.+\.rb$})
    watch(%r{providers/.+\.rb$})
    watch(%r{recipes/.+\.rb$})
    watch(%r{resources/.+\.rb$})
    watch(%r{^templates/(.+)})
    watch('metadata.rb')
  end
end
