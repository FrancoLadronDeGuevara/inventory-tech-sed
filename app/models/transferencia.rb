class Transferencia < ApplicationRecord
  belongs_to :articulo
  belongs_to :portador_anterior, class_name: "Persona", optional: true
  belongs_to :portador_nuevo, class_name: "Persona"

  validates :fecha_transferencia, presence: true
  validate :portador_diferente

  after_create :actualizar_portador_actual

  private

  def portador_diferente
    if portador_anterior_id == portador_nuevo_id
      errors.add(:portador_nuevo, "debe ser diferente al portador anterior")
    end
  end

  def actualizar_portador_actual
    articulo.update!(portador_actual: portador_nuevo)
  end
end
