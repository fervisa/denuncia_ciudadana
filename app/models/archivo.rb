class Archivo < ActiveRecord::Base
  belongs_to :denuncia
  attr_accessible :adjunto

  validates :url_id, uniqueness: true, presence: true

  before_validation :generate_url_id

  mount_uploader :adjunto, AdjuntoUploader

  def nombre
    File.basename self.adjunto.url
  end

  def generate_url_id
    self.url_id ||= Digest::SHA1.hexdigest([Time.now, rand].join)
  end
end
