require 'rails_helper'

RSpec.describe Transferencia, type: :model do
  let(:persona1) { Persona.create!(nombre: "Franco", apellido: "Guevara") }
  let(:persona2) { Persona.create!(nombre: "Melina", apellido: "Gomez") }
  let(:articulo) { Articulo.create!(marca: "Dell", modelo: "XPS", fecha_ingreso: Date.today, portador_actual: persona1) }

  it "cambia el portador del artículo al guardar la transferencia" do
    transferencia = Transferencia.create!(articulo: articulo, portador_anterior: persona1, portador_nuevo: persona2, fecha_transferencia: Date.today)
    expect(articulo.reload.portador_actual).to eq(persona2)
  end

  it "no permite que el portador nuevo sea igual al anterior" do
    transferencia = Transferencia.new(articulo: articulo, portador_anterior: persona1, portador_nuevo: persona1, fecha_transferencia: Date.today)
    expect(transferencia).not_to be_valid
  end

  it "no permite fecha futura" do
    transferencia = Transferencia.new(articulo: articulo, portador_anterior: persona1, portador_nuevo: persona2, fecha_transferencia: Date.tomorrow)
    expect(transferencia).not_to be_valid
  end
end
