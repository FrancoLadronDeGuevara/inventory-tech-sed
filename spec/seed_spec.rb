require 'rails_helper'

RSpec.describe "Seeds" do
  it "crea usuarios, articulos, personas y transferencias" do
    Rails.application.load_seed

    expect(User.find_by(email_address: "admin@inventario.com")).not_to be_nil
    expect(Articulo.count).to be > 0
    expect(Persona.count).to be > 0
    expect(Transferencia.count).to be > 0
  end
end
