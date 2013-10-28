class Dependencia < ActiveRecord::Base
  # accessors
  attr_accessible :nombre

  # relations
  has_many :denuncias

  # validations
  validates :nombre, presence: true

  # methods
  def to_s
    self.nombre
  end
end
