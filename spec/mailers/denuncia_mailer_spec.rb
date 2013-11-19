# encoding: UTF-8
require "spec_helper"

describe DenunciaMailer do
  describe "confirmar_denuncia" do
    let(:denuncia) { FactoryGirl.create :denuncia }
    let(:archivo_1) { FactoryGirl.create :archivo, adjunto: File.open('spec/fixtures/files/image-1.png') }
    let(:archivo_2) { FactoryGirl.create :archivo, adjunto: File.open('spec/fixtures/files/image-2.png') }
    let(:mail) { DenunciaMailer.confirmar_denuncia(denuncia) }

    it "renders the headers" do
      mail.subject.should eq 'Denuncia generada desde Denuncia Ciudadana'
      mail.to.should eq ["denunciante@mail.com"]
      mail.from.should eq ["from@example.com"]
    end

    it "renders number of denuncia in body" do
      folio = "%010d" % denuncia.id
      mail.body.encoded.should match(/#{folio}/)
    end

    context 'with files' do
      it 'attaches files' do
        denuncia.archivos << archivo_1
        denuncia.archivos << archivo_2
        mail.attachments.size.should == 2
      end
    end

    context 'without files' do
      it 'does not attach files' do
        mail.attachments.should be_empty
      end
    end
  end

end
