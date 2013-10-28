require 'spec_helper'

describe Denuncia do

  def valid_attributes
    { 'funcionario' => 'Nombre Funcionario', 'queja' => 'Descripcion de la denuncia', 'email' => 'denunciante@mail.com', dependencia_id: dependencia.id}
  end

  let(:dependencia) { FactoryGirl.create :dependencia }

  it { should belong_to :dependencia }
  it { should have_many :archivos }

  it { should validate_presence_of :email }
  it { should validate_presence_of :funcionario }
  it { should validate_presence_of :queja }
  it { should validate_presence_of :dependencia }
  it { should validate_presence_of :finalizada }

  it { should accept_nested_attributes_for :archivos }

  it { should allow_mass_assignment_of :email }
  it { should allow_mass_assignment_of :funcionario }
  it { should allow_mass_assignment_of :queja }
  it { should allow_mass_assignment_of :dependencia_id }
  it { should allow_mass_assignment_of :archivos_attributes }

  describe '#email' do
    it { should allow_value("denunciante@mail.com").for(:email) }
    it { should_not allow_value("foo").for(:email) }
  end

  describe '#finalize' do
    it 'returns true' do
      denuncia = Denuncia.new
      denuncia.finalize(valid_attributes).should be_true
    end

    it 'returns false' do
      denuncia = Denuncia.new
      denuncia.finalize({}).should be_false
    end
  end

end
