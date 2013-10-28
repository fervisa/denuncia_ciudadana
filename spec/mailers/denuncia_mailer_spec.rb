# encoding: UTF-8
require "spec_helper"

describe DenunciaMailer do
  describe "confirmar_denuncia" do
    let(:denuncia) { FactoryGirl.create :denuncia }
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
  end

end
