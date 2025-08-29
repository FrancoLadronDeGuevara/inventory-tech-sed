class ArticulosController < ApplicationController
  layout "dashboard"

  before_action :require_authentication
  before_action :set_articulo, only: [ :show, :edit, :update, :destroy ]
  def index
     @articulos = Articulo.order(:id).page(params[:page]).per(5)

     respond_to do |format|
      format.html
      format.csv do
        headers["Content-Disposition"] = "attachment; filename=articulos-#{Date.today}.csv"
        headers["Content-Type"] = "text/csv"
        render plain: Articulo.to_csv
      end
    end
  end

  def import
    if params[:file].present?
      Articulo.import(params[:file])
      redirect_to articulos_path, notice: "Artículos importados con éxito"
    else
      redirect_to articulos_path, alert: "Selecciona un archivo CSV"
    end
  end

  def show
    @articulo = Articulo.includes(transferencias: [ :portador_anterior, :portador_nuevo ]).find(params[:id])
    @historial = @articulo.historial_portadores
  end

  def new
    @articulo = Articulo.new
  end

  def create
  @articulo = Articulo.new(articulo_params)
  if @articulo.save
    if @articulo.portador_actual.present?
      Transferencia.create!(
        articulo: @articulo,
        portador_anterior: nil,
        portador_nuevo: @articulo.portador_actual,
        fecha_transferencia: Date.today
      )
    end
    redirect_to articulo_path(@articulo), notice: "Artículo creado correctamente."
  else
    render :new, status: :unprocessable_entity
  end
  end

  def edit
  end

  def update
    if @articulo.update(articulo_params)
      redirect_to articulo_path(@articulo), notice: "Artículo actualizado."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @articulo.destroy
    redirect_to articulos_path, notice: "Articulo eliminado."
  end

  private

  def set_articulo
    @articulo = Articulo.find(params[:id])
  end

  def articulo_params
    params.require(:articulo).permit(:modelo, :marca, :fecha_ingreso, :portador_actual_id)
  end
end
