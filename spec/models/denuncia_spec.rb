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

  describe '#cerrar' do
    before :each do
      @denuncia = Denuncia.new
      @denuncia.finalize(valid_attributes)
    end

    it 'should return true' do
      @denuncia.cerrar.should be_true
    end

    it 'marks denuncia as finalizada' do
      @denuncia.cerrar
      @denuncia.finalizada.should be_true
    end
  end

  describe '#abrir' do
    before :each do
      @denuncia = Denuncia.new
      @denuncia.finalize(valid_attributes)
    end

    it 'should return true' do
      @denuncia.abrir.should be_true
    end

    it 'marks denuncia as abierta' do
      @denuncia.abrir
      @denuncia.finalizada.should be_false
    end
  end

  describe '#cambiar_estado' do
    before :each do
      @denuncia = Denuncia.new
      @denuncia.finalize(valid_attributes)
    end

    context 'cerrada' do
      before :each do
        @denuncia.update_column :finalizada, true
      end

      it 'should return true' do
        @denuncia.cambiar_estado.should be_true
      end

      it 'marks denuncia as abierta' do
        @denuncia.cambiar_estado
        @denuncia.finalizada.should be_false
      end
    end

    context 'abierta' do
      it 'should return true' do
        @denuncia.cambiar_estado.should be_true
      end

      it 'marks denuncia as cerrada' do
        @denuncia.cambiar_estado
        @denuncia.finalizada.should be_true
      end
    end
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

    it 'does not mark denuncia as finalizada' do
      denuncia = Denuncia.new
      denuncia.finalize(valid_attributes)
      denuncia.finalizada.should be_false
    end
  end

  context 'scopes' do
    before :each do
      Denuncia.new.finalize(valid_attributes)
      Denuncia.new.finalize(valid_attributes)
    end

    describe '.abiertas' do
      it 'returns denuncias with finalizadas == false' do
        Denuncia.abiertas.count.should == 2
      end
    end

    describe '.finalizadas' do
      it 'returns denuncias with finalizadas == true' do
        Denuncia.update_all finalizada: true
        Denuncia.finalizadas.count.should == 2
      end
    end
  end

end
