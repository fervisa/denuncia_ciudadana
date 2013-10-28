class Denuncia < ActiveRecord::Base
  # relations
  belongs_to :dependencia
  has_many :archivos

  # scopes
  scope :finalizadas, where(:finalizada => true)
  scope :abiertas, where("finalizada IS NULL")

  # accessors
  attr_accessible :email, :funcionario, :queja, :dependencia_id, :archivos_attributes

  # nested attributes
  accepts_nested_attributes_for :archivos, allow_destroy: true

  # validations
  validates :funcionario, :queja, :dependencia, :email, :finalizada, presence: true
  validates :email, format: { with: /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/ }

  def finalize(attributes)
    self.assign_attributes attributes
    self.finalizada = true
    result = self.save
    DenunciaMailer.confirmar_denuncia(self).deliver if result
    result
  end
end
