require 'rails_helper'

RSpec.describe Articulo, type: :model do
  let(:persona) { Persona.create!(nombre: "Melina", apellido: "Gomez") }

  it "es válido con marca, modelo y fecha_ingreso" do
    articulo = Articulo.new(marca: "Dell", modelo: "XPS", fecha_ingreso: Date.today, portador_actual: persona)
    expect(articulo).to be_valid
  end

  it "no es válido sin marca" do
    articulo = Articulo.new(marca: nil, modelo: "XPS", fecha_ingreso: Date.today)
    expect(articulo).not_to be_valid
  end

  it "no es válido con fecha futura" do
    articulo = Articulo.new(marca: "Dell", modelo: "XPS", fecha_ingreso: Date.tomorrow)
    expect(articulo).not_to be_valid
  end
end
