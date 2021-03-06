require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Strategy" do
  before(:each) do
    @url = "http://creativeallies.com"
  end

  #
  # Initialization
  #

  context "initialization" do
    it "should raise an error if a URL is not set" do
      lambda {Virility::Strategy.new}.should raise_error
    end

    it "should set and encode the url" do
      Virility::Facebook.new(@url).url.should == "http%3A%2F%2Fcreativeallies.com"
    end
  end

  #
  # Interface
  #

  context "interface" do
    it "should raise an error on poll" do
      lambda { Virility::Strategy.new(@url).poll }.should raise_error
    end

    it "should raise an error on count" do
      lambda { Virility::Strategy.new(@url).count }.should raise_error
    end
  end

  #
  # Dynamic Methods
  #

  describe "dynamic methods" do
    before(:each) do
      @virility = Virility::Facebook.new(@url)
      @virility.stub(:results).and_return(Virility::FB_RESULTS)
    end

    context "overall testing" do
      Virility::FB_RESULTS.each do |key, value|
        it "should return #{value} when get_result is called with #{key}" do
          @virility.send(key).should == value
        end
      end

      Virility::FAKE_FB_RESULTS.each do |key|
        it "should_not raise an error if the result (#{key}) does not exist" do
          lambda { @virility.send(key) }.should_not raise_error
        end
        
        it "should return 0 if the result (#{key}) does not exist" do
          @virility.send(key).should == 0
        end
      end
    end

    context "result_exists?" do
      before(:each) do
        @virility = Virility::Facebook.new(@url)
        @virility.stub(:results).and_return(Virility::FB_RESULTS)
      end

      Virility::FB_RESULTS.keys.each do |result|
        it "should return true for #{result}" do
          @virility.result_exists?(result).should be true
        end
      end

      Virility::FAKE_FB_RESULTS.each do |result|
        it "should return false for #{result}" do
          @virility.result_exists?(result).should be false
        end
      end
    end

    context "get_result" do
      Virility::FB_RESULTS.each do |key, value|
        it "should return #{value} when get_result is called with #{key}" do
          @virility.get_result(key).should == value
        end
      end

      Virility::FAKE_FB_RESULTS.each do |key|
        it "should_not raise an error if the result (#{key}) does not exist" do
          lambda { @virility.send(key) }.should_not raise_error
        end
        
        it "should return 0 if the result (#{key}) does not exist" do
          @virility.send(key).should == 0
        end
      end
    end

  end
end
