class DenunciaMailer < ActionMailer::Base
  default from: "from@example.com", subject: 'Denuncia generada desde Denuncia Ciudadana', css: :mailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.denuncia_mailer.confirmar_denuncia.subject
  #
  def confirmar_denuncia(denuncia)
    @denuncia = denuncia
    adjunta_archivos unless @denuncia.archivos.empty?
    mail to: @denuncia.email
  end

  private

  def adjunta_archivos
    @denuncia.archivos.each do |archivo|
      attachments[archivo.nombre] = File.open(archivo.adjunto.file.path, 'r').read
    end
  end
end
