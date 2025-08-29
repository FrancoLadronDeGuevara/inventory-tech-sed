class PersonasController < ApplicationController
  layout "dashboard"
  before_action :require_authentication, unless: -> { Rails.env.test? }
  before_action :set_persona, only: [ :show, :edit, :update, :destroy ]

  def index
    @personas = Persona.includes(:articulos).order(:apellido).page(params[:page]).per(5)

    respond_to do |format|
      format.html
      format.csv do
        headers["Content-Disposition"] = "attachment; filename=personas-#{Date.today}.csv"
        headers["Content-Type"] = "text/csv"
        render plain: Persona.to_csv
      end
    end
  end

  def import
  if params[:file].present?
    Persona.import(params[:file])
    redirect_to personas_path, notice: "Personas importadas correctamente"
  else
    redirect_to personas_path, alert: "Debes seleccionar un archivo CSV"
  end
  end

  def show
    @persona = Persona.includes(articulos: :transferencias).find(params[:id])
    @historial = @persona.historial_transferencias
  end

  def new
    @persona = Persona.new
  end

  def create
    @persona = Persona.new(persona_params)
    if @persona.save
      redirect_to personas_path, notice: "Persona creada correctamente."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @persona.update(persona_params)
      redirect_to personas_path, notice: "Persona actualizada correctamente."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @persona.destroy
      redirect_to personas_path, notice: "Persona eliminada correctamente."
    else
      redirect_to personas_path, alert: @persona.errors.full_messages.to_sentence
    end
  end

  private

  def set_persona
    @persona = Persona.find(params[:id])
  end

  def persona_params
    params.require(:persona).permit(:nombre, :apellido)
  end
end
