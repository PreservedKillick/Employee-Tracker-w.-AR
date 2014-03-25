require 'spec_helper'

describe Employee do
  it {should belong_to :department}
  it { should have_many :projects}
end
