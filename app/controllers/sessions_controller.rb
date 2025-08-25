class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create show ]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_url, alert: "Intenta de nuevo más tarde" }

  def new
    redirect_to dashboard_path if authenticated?
  end

  def show
    redirect_to dashboard_path if authenticated?
  end

  def create
    if user = User.authenticate_by(params.permit(:email_address, :password))
      start_new_session_for user
      redirect_to dashboard_path, notice: "¡Bienvenido!"
    else
      redirect_to new_session_path, alert: "Email o contraseña incorrectos."
    end
  end

  def destroy
    terminate_session
    redirect_to new_session_path, notice: "Sesión cerrada."
  end
end
