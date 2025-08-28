class TransferenciasController < ApplicationController
  layout "dashboard"
  before_action :require_authentication
  def index
    @transferencias = Transferencia.includes(:articulo, :portador_anterior, :portador_nuevo).order(fecha_transferencia: :desc).page(params[:page]).per(5)
  end

  def show
  end

  def new
    @articulo = Articulo.find(params[:articulo_id]) if params[:articulo_id].present?
    @personas = Persona.order(:apellido, :nombre)
  end

  def create
    articulo = Articulo.find(params[:articulo_id])
    portador_nuevo = Persona.find(params[:portador_nuevo_id])
    transferencia = Transferencia.create!(
      articulo: articulo,
      portador_anterior: articulo.portador_actual,
      portador_nuevo: portador_nuevo
    )
    redirect_to articulo_path(articulo), notice: "Transferencia registrada."
  rescue ActiveRecord::RecordInvalid => e
    redirect_back fallback_location: articulo_path(articulo), alert: e.record.errors.full_messages.to_sentence
  rescue ActiveRecord::RecordNotFound => e
    redirect_back fallback_location: articulo_path(articulo), alert: "Artículo o portador no encontrado."
  end
end
