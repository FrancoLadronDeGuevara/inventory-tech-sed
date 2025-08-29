require 'rails_helper'

RSpec.describe Persona, type: :model do
  it "es válido con nombre y apellido" do
    persona = Persona.new(nombre: "Franco", apellido: "Guevara")
    expect(persona).to be_valid
  end

  it "no es válido sin nombre" do
    persona = Persona.new(nombre: nil, apellido: "Guevara")
    expect(persona).not_to be_valid
  end

  it "no es válido sin apellido" do
    persona = Persona.new(nombre: "Franco", apellido: nil)
    expect(persona).not_to be_valid
  end

  it "solo permite letras en nombre y apellido" do
    persona = Persona.new(nombre: "Franco123", apellido: "Guevara")
    expect(persona).not_to be_valid
  end

  it "devuelve el nombre completo correctamente" do
    persona = Persona.new(nombre: "Franco", apellido: "Guevara")
    expect(persona.nombre_completo).to eq("Franco Guevara")
  end
end
