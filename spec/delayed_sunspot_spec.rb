require 'spec_helper'

describe Sunspot::SessionProxy::DelayedJobSessionProxy do
  before(:each) do
    @original_session = Sunspot::Session.new
    @proxy = Sunspot::SessionProxy::DelayedJobSessionProxy.new(@original_session)
  end

  describe :proxy do
    it "should wrap original session" do
      @proxy.session.should == @original_session
    end
  end

  describe "delegated method" do
    [:config, :delete_dirty?, :dirty?, :more_like_this, :new_more_like_this, :new_search, :optimize, :search].each do |method|
      it "#{method} should be called on the original session" do
        args = Array.new(Sunspot::Session.instance_method(method).arity.abs) do
          stub('arg')
        end
        @proxy.session.should_receive(method).with(*args)
        @proxy.send(method, *args)
      end
    end
  end

  describe "queued method" do
    [:batch, :commit, :index, :index!, :remove, :remove!, :remove_all, :remove_all!, :remove_by_id, :remove_by_id!].each do |method|
      it "#{method} should queue a job" do
        args = Array.new(Sunspot::Session.instance_method(method).arity.abs) do
          stub('arg')
        end
        @proxy.send(method, *args).should == true
      end
    end
  end
end
