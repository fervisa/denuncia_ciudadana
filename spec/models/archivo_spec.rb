require 'spec_helper'

describe Archivo do
  it { should belong_to :denuncia }
  it { should allow_mass_assignment_of :adjunto }
  it { should_not allow_mass_assignment_of :denuncia_id }

  describe '#url_id' do
    context 'valid?' do
      before :each do
        @archivo = Archivo.new
        @archivo.valid?
      end

      it 'should not be when validated' do
        @archivo.url_id.should_not be_empty
      end

      it 'should contain a hash when validated' do
        @archivo.url_id.length.should == 40
      end
    end
  end
end
