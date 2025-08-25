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

  validates :nombre, :apellido, presence: true
end
