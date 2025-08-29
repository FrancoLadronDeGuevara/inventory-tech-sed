require 'rails_helper'

RSpec.describe "Articulos", type: :request do
  let(:persona) { Persona.create!(nombre: "Melina", apellido: "Gomez") }
  let(:articulo) { Articulo.create!(marca: "Dell", modelo: "XPS", fecha_ingreso: Date.today, portador_actual: persona) }

  describe "GET /index" do
    it "retorna http success" do
      get articulos_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "retorna http success" do
      get articulo_path(articulo)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "retorna http success" do
      get new_articulo_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    it "crea un nuevo articulo" do
      expect {
        post articulos_path, params: { articulo: { marca: "HP", modelo: "Elitebook", fecha_ingreso: Date.today, portador_actual_id: persona.id } }
      }.to change(Articulo, :count).by(1)
      expect(response).to redirect_to(articulo_path(Articulo.last))
    end
  end

  describe "GET /edit" do
    it "retorna http success" do
      get edit_articulo_path(articulo)
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH /update" do
    it "actualiza el articulo" do
      patch articulo_path(articulo), params: { articulo: { modelo: "XPS 13" } }
      expect(response).to redirect_to(articulo_path(articulo))
      expect(articulo.reload.modelo).to eq("XPS 13")
    end
  end

  describe "DELETE /destroy" do
    it "elimina el articulo" do
      articulo_to_delete = Articulo.create!(marca: "Lenovo", modelo: "ThinkPad", fecha_ingreso: Date.today, portador_actual: persona)
      expect {
        delete articulo_path(articulo_to_delete)
      }.to change(Articulo, :count).by(-1)
      expect(response).to redirect_to(articulos_path)
    end
  end
end
