class PersonasController < ApplicationController
  layout "dashboard"
  before_action :require_authentication
  before_action :set_persona, only: [ :show, :edit, :update, :destroy ]

  def index
    @personas = Persona.order(:apellido).page(params[:page]).per(5)
  end

  def show
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
    @persona.destroy
    redirect_to personas_path, notice: "Persona eliminada correctamente."
  end

  private

  def set_persona
    @persona = Persona.find(params[:id])
  end

  def persona_params
    params.require(:persona).permit(:nombre, :apellido)
  end
end
