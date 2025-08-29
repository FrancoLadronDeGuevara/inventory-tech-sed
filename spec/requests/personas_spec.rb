require 'rails_helper'

RSpec.describe "Personas", type: :request do
  let!(:persona) { Persona.create!(nombre: "Melina", apellido: "Gomez") }

  describe "GET /index" do
    it "retorna http success" do
      get "/personas"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "retorna http success" do
      get "/personas/#{persona.id}"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "retorna http success" do
      get "/personas/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    it "crea una nueva persona" do
      post "/personas", params: { persona: { nombre: "Franco", apellido: "Guevara" } }
      expect(response).to redirect_to(personas_path)
    end
  end

  describe "GET /edit" do
    it "retorna http success" do
      get "/personas/#{persona.id}/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH /update" do
    it "actualiza la persona" do
      patch "/personas/#{persona.id}", params: { persona: { nombre: "Mel" } }
      expect(response).to redirect_to(personas_path)
    end
  end

  describe "DELETE /destroy" do
    it "elimina la persona" do
      delete "/personas/#{persona.id}"
      expect(response).to redirect_to(personas_path)
    end
  end
end
