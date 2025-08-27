class Persona < ApplicationRecord
  has_many :articulos, foreign_key: :portador_actual_id, dependent: :nullify

  has_many :transferencias_como_anterior,
           class_name: "Transferencia",
           foreign_key: :portador_anterior_id,
           dependent: :nullify

  has_many :transferencias_como_nuevo,
           class_name: "Transferencia",
           foreign_key: :portador_nuevo_id,
           dependent: :nullify

  validates :nombre, presence: { message: "no puede estar vacio" }
  validates :nombre, format: {
    with: /\A[a-zA-ZÁÉÍÓÚáéíóúÑñ\s]+\z/,
    message: "solo puede contener letras"
  }
  validates :apellido, presence: { message: "no puede estar vacio" }
  validates :apellido, format: {
    with: /\A[a-zA-ZÁÉÍÓÚáéíóúÑñ\s]+\z/,
    message: "solo puede contener letras"
  }
end
