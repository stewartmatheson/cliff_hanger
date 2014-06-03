require 'spec_helper'
require 'cliff_hanger'

describe CliffHanger do
  it "should have a VERSION constant" do
    subject.const_get('VERSION').should_not be_empty
  end
end
