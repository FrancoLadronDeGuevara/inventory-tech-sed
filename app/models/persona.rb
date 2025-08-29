require "csv"

class Persona < ApplicationRecord
  has_many :articulos, foreign_key: :portador_actual_id, dependent: :nullify

  has_many :transferencias_como_anterior,
           class_name: "Transferencia",
           foreign_key: :portador_anterior_id,
           dependent: :nullify

  has_many :transferencias_como_nuevo,
           class_name: "Transferencia",
           foreign_key: :portador_nuevo_id,
           dependent: :restrict_with_error

  validates :nombre,
  presence: { message: "no puede estar vacio" },
  format: {
    with: /\A[a-zA-ZÁÉÍÓÚáéíóúÑñ\s]+\z/,
    message: "solo puede contener letras",
    allow_blank: true
  }

  validates :apellido,
  presence: { message: "no puede estar vacio" },
  format: {
    with: /\A[a-zA-ZÁÉÍÓÚáéíóúÑñ\s]+\z/,
    message: "solo puede contener letras",
    allow_blank: true
  }

  def nombre_completo
    "#{nombre} #{apellido}"
  end

  def historial_transferencias
    Transferencia.where("portador_anterior_id = ? OR portador_nuevo_id = ?", id, id).order(fecha_transferencia: :desc)
  end

  def articulo_actual
    articulos.order(fecha_ingreso: :desc)
  end


  def self.to_csv
    attributes = %w[id nombre apellido]

    CSV.generate(headers: true) do |csv|
      csv << attributes
      all.each { |persona| csv << attributes.map { |attr| persona.send(attr) } }
    end
  end

  def self.import(file)
      CSV.foreach(file.path, headers: true) do |row|
        persona_hash = row.to_hash.except("id")
        Persona.create!(persona_hash)
      end
  end
end
