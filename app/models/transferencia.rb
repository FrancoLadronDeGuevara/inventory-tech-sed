require "csv"

class Transferencia < ApplicationRecord
  belongs_to :articulo
  belongs_to :portador_anterior, class_name: "Persona", optional: true
  belongs_to :portador_nuevo, class_name: "Persona"

  validates :fecha_transferencia, presence: true
  validate :fecha_no_futura
  validate :portador_diferente

  after_save :actualizar_portador_actual

  private

  def portador_diferente
    if portador_anterior_id == portador_nuevo_id
      errors.add(:portador_nuevo, "debe ser diferente al portador anterior")
    end
  end

  def actualizar_portador_actual
    articulo.update!(portador_actual: portador_nuevo)
  end

  def fecha_no_futura
    return if fecha_transferencia.blank?

    fecha = fecha_transferencia.is_a?(String) ? Date.parse(fecha_transferencia) : fecha_transferencia.to_date

    if fecha > Date.today
      errors.add(:fecha_transferencia, "no puede ser en el futuro")
    end
  end

  def self.to_csv
    headers = [ "id", "articulo", "portador_anterior", "portador_nuevo", "fecha_transferencia" ]

    CSV.generate(headers: true) do |csv|
      csv << headers
      all.includes(:articulo, :portador_anterior, :portador_nuevo).find_each do |transferencia|
        csv << [
          transferencia.id,
          "#{transferencia.articulo&.marca} #{transferencia.articulo&.modelo}",
          "#{transferencia.portador_anterior&.nombre} #{transferencia.portador_anterior&.apellido}",
          "#{transferencia.portador_nuevo&.nombre} #{transferencia.portador_nuevo&.apellido}",
          transferencia.fecha_transferencia
        ]
      end
    end
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      transferencia = Transferencia.new

      if row["articulo"].present?
        marca, modelo = row["articulo"].to_s.strip.split(" ", 2)
        articulo = Articulo.find_or_create_by!(marca: marca, modelo: modelo)
        transferencia.articulo = articulo
      end

      if row["portador_anterior"].present?
        nombre, apellido = row["portador_anterior"].to_s.strip.split(" ", 2)
        persona_anterior = Persona.find_or_create_by!(nombre: nombre, apellido: apellido)
        transferencia.portador_anterior = persona_anterior
      end

      if row["portador_nuevo"].present?
        nombre, apellido = row["portador_nuevo"].to_s.strip.split(" ", 2)
        persona_nuevo = Persona.find_or_create_by!(nombre: nombre, apellido: apellido)
        transferencia.portador_nuevo = persona_nuevo
      end

      transferencia.fecha_transferencia = row["fecha_transferencia"]

      transferencia.save!
    end
  end
end
