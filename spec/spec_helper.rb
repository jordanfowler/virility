$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'virility'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true
  config.mock_with :rspec 
end

#
# Constants for Testing
#

module Virility
  TESTING_STRATEGIES = {:facebook => Virility::Facebook, :twitter => Virility::Twitter, :delicious => Virility::Delicious, :pinterest => Virility::Pinterest, :plus_one => Virility::PlusOne, :stumble_upon => Virility::StumbleUpon}
  FAKE_TESTING_STRATEGIES = [:digg, :reddit, :linked_in, :instagram, :tumblr]
  
  FB_RESULTS = {"like_count"=>"19", "click_count"=>"0", "share_count"=>"3", "comment_count"=>"0", "commentsbox_count"=>"0", "total_count"=>"22"}
  FAKE_FB_RESULTS = [:face_count, :pages, :friends]
end


#
# Example Groups
#

share_examples_for "no context results" do
  it "should not raise an error" do
    lambda { @virility.poll }.should_not raise_error
  end

  it "should return 0 for count" do
    @virility.count.should == 0
  end
end