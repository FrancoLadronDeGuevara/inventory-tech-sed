class PersonasController < ApplicationController
  layout "dashboard"
  before_action :require_authentication
  def index
    @personas = Persona.all
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
