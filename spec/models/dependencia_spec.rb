require 'spec_helper'

describe Dependencia do
  it { should have_many :denuncias }
  it { should validate_presence_of :nombre }
end
