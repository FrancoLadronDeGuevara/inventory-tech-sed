class TransferenciasController < ApplicationController
  layout "dashboard"
  def index
    @transferencias = Transferencia.all
  end

  def show
  end

  def new
  end

  def create
  end
end
