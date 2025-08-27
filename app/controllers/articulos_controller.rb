class ArticulosController < ApplicationController
  layout "dashboard"
  def index
    @articulos = Articulo.all
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
