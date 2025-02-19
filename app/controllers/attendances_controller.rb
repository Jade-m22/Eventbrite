class AttendancesController < ApplicationController
  before_action :authenticate_user

  def show
    @attendance = Attendance.find_by(id: params[:id])

    if @attendance.nil?
      redirect_to events_path, alert: "Cette participation n'existe pas."
    else
      @event = @attendance.event
      puts "DEBUG - Attendance ID: #{@attendance.id}, Event ID: #{@event.id}, Event Title: #{@event.title}, Event Price: #{@event.price}"
    end
  end

  def create
    @event = Event.find(params[:event_id])

    if @event.is_free?
      attendance = Attendance.new(user: current_user, event: @event)

      if attendance.save
        redirect_to @event, notice: "Tu participes maintenant à cet événement gratuitement !"
      else
        redirect_to @event, alert: "Erreur : Impossible de s'inscrire."
      end

      return
    end

    # Si l'événement est payant, on redirige vers Stripe
    redirect_to checkout_create_path(event_id: @event.id)
  end

  private

  def authenticate_user
    unless current_user
      flash[:alert] = "Tu dois être connecté pour participer à un événement."
      redirect_to login_path
    end
  end
end
