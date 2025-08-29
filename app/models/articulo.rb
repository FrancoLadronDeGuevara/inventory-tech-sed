require "csv"

class Articulo < ApplicationRecord
  belongs_to :portador_actual, class_name: "Persona", optional: true

  has_many :transferencias, dependent: :destroy

  validates :modelo, :marca, :fecha_ingreso, presence: true
  validate :fecha_no_futura

  def ver_portador_actual
    transferencias.order(:fecha_transferencia).last&.portador_nuevo
  end

  def ultima_transferencia
    transferencias.order(fecha_transferencia: :desc).first
  end

  def historial_portadores
    transferencias.includes(:portador_anterior, :portador_nuevo).order(fecha_transferencia: :desc)
  end

  def fecha_no_futura
    return if fecha_ingreso.blank?

    fecha = fecha_ingreso.is_a?(String) ? Date.parse(fecha_ingreso) : fecha_ingreso.to_date

    if fecha > Date.today
      errors.add(:fecha_ingreso, "no puede ser en el futuro")
    end
  end

  def self.to_csv
    attributes = %w[id marca modelo fecha_ingreso]

    CSV.generate(headers: true) do |csv|
      csv << attributes
      all.each do |articulo|
        csv << attributes.map { |attr| articulo.send(attr) }
      end
    end
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      articulo = Articulo.new
      articulo.marca = row["marca"]
      articulo.modelo = row["modelo"]
      articulo.fecha_ingreso = row["fecha_ingreso"]

      if row["portador_actual"].present?
        nombre, apellido = row["portador_actual"].to_s.strip.split(" ", 2)
        persona = Persona.find_or_create_by!(nombre: nombre, apellido: apellido)
        articulo.portador_actual = persona
      end

      articulo.save!
    end
  end
end
