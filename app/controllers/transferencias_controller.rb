class TransferenciasController < ApplicationController
  layout "dashboard"
  before_action :require_authentication
  def index
    @transferencias = Transferencia.includes(:articulo, :portador_anterior, :portador_nuevo).order(fecha_transferencia: :desc).page(params[:page]).per(5)

    respond_to do |format|
      format.html
      format.csv do
        headers["Content-Disposition"] = "attachment; filename=transferencias-#{Date.today}.csv"
        headers["Content-Type"] = "text/csv"
        render plain: Transferencia.to_csv
      end
    end
  end

  def import
    if params[:file].present?
      Transferencia.import(params[:file])
      redirect_to transferencias_path, notice: "Transferencias importadas con éxito"
    else
      redirect_to transferencias_path, alert: "Selecciona un archivo CSV"
    end
  end

  def show
    @transferencia = Transferencia.includes(:articulo, :portador_anterior, :portador_nuevo).find(params[:id])
  end

  def new
    @articulo = Articulo.find(params[:articulo_id]) if params[:articulo_id].present?
    @personas = Persona.order(:apellido, :nombre)
    @transferencia = Transferencia.new(articulo: @articulo)
  end

  def create
    @transferencia = Transferencia.new(transferencia_params)

    if @transferencia.articulo.present?
      @transferencia.portador_anterior = @transferencia.articulo.portador_actual
    end

    if @transferencia.save
      redirect_to transferencia_path(@transferencia), notice: "Transferencia creada correctamente."
    else
      @articulo = @transferencia.articulo
      @personas = Persona.order(:apellido, :nombre)
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @transferencia = Transferencia.find(params[:id])
    if @transferencia.destroy
      redirect_to transferencias_path, notice: "Transferencia eliminada correctamente."
    else
      redirect_to transferencias_path, alert: "No se pudo eliminar la transferencia."
    end
  end

  private
  def transferencia_params
    params.require(:transferencia).permit(:articulo_id, :portador_nuevo_id, :fecha_transferencia)
  end
end
