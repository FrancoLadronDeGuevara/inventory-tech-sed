require 'rails_helper'

RSpec.describe "Transferencias", type: :request do
  let!(:persona) { Persona.create!(nombre: "Franco", apellido: "Guevara") }
  let!(:persona2) { Persona.create!(nombre: "Melina", apellido: "Gomez") }
  let!(:articulo) { Articulo.create!(marca: "Dell", modelo: "XPS", fecha_ingreso: Date.today, portador_actual: persona) }
  let!(:transferencia) { Transferencia.create!(articulo: articulo, portador_anterior: nil, portador_nuevo: persona, fecha_transferencia: Date.today) }

  describe "GET /index" do
    it "retorna http success" do
      get "/transferencias"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "retorna http success" do
      get "/transferencias/#{transferencia.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "retorna http success" do
      get "/transferencias/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    it "crear una nueva transferencia" do
      expect {
        post "/transferencias", params: {
          transferencia: {
            articulo_id: articulo.id,
            portador_nuevo_id: persona2.id,
            fecha_transferencia: Date.today
          }
        }
      }.to change(Transferencia, :count).by(1)

      expect(response).to redirect_to(transferencia_path(Transferencia.last))

      last_transferencia = Transferencia.last
      expect(last_transferencia.articulo).to eq(articulo)
      expect(last_transferencia.portador_nuevo).to eq(persona2)
      expect(last_transferencia.portador_anterior).to eq(persona)
    end
  end
end
