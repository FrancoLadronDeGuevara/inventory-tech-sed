class DashboardController < ApplicationController
  layout "dashboard"
  def index
    redirect_to root_path unless authenticated?

     @total_articulos = Articulo.count
     @total_personas = Persona.count
     @total_transferencias = Transferencia.count
     @articulos_recientes = Articulo.order(fecha_ingreso: :desc).limit(5)
     @transferencias_recientes = Transferencia.includes(:articulo, :portador_anterior, :portador_nuevo).order(fecha_transferencia: :desc).limit(5) rescue []
  end
end
