class Articulo < ApplicationRecord
  belongs_to :portador_actual, class_name: "Persona", optional: true

  has_many :transferencias, dependent: :destroy

  validates :modelo, :marca, :fecha_ingreso, presence: true

  def portador_actual
    transferencias.order(:fecha_transferencia).last&.portador_nuevo
  end

  def ultima_transferencia
    transferencias.order(fecha_transferencia: :desc).first
  end
end
