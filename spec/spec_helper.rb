require 'sunspot'
require 'sunspot_matchers'
require 'delayed_sunspot/sunspot/session_proxy/delayed_job_session_proxy'
require 'delayed_sunspot/delayed_job/sunspot_job'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.before :suite do
    Sunspot.session = SunspotMatchers::SunspotSessionSpy.new(Sunspot.session)
  end
  config.include SunspotMatchers
end
