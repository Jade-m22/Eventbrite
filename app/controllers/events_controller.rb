class EventsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update destroy my_events validate]
  before_action :set_event, only: %i[show edit update destroy validate]
  before_action :authorize_user!, only: %i[edit update destroy]
  before_action :check_if_admin, only: %i[validate]

  def index
    @events = Event.where(validated: true)
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.new(event_params)
    @event.validated = false

    if @event.save
      redirect_to root_path, notice: "Événement créé avec succès. En attente de validation."
    else
      flash.now[:alert] = @event.errors.full_messages.join(", ")
      render :new
    end
  end

  def show
    @participant_count = @event.attendances.count
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: "Événement mis à jour avec succès."
    else
      flash.now[:alert] = @event.errors.full_messages.join(", ")
      render :edit
    end
  end

  def destroy
    if @event.destroy
      redirect_to root_path, notice: "Événement supprimé avec succès."
    else
      redirect_to @event, alert: "Erreur lors de la suppression de l'événement."
    end
  end


  def my_events
    @events = current_user.events.includes(:participants)
  end

  def pending
    check_if_admin
    @events = Event.where(validated: false)
  end

  def validate
    if @event.update(validated: true)
      redirect_to events_path, notice: "Événement validé avec succès."
    else
      redirect_to events_path, alert: "Erreur lors de la validation de l'événement."
    end
  end

  private

  def set_event
    @event = Event.find_by(id: params[:id])
    redirect_to events_path, alert: "Événement introuvable." if @event.nil?
  end

  def authorize_user!
    unless @event.user == current_user || current_user.is_admin?
      redirect_to root_path, alert: "Tu n'es pas autorisé à modifier cet événement."
    end
  end

  def check_if_admin
    redirect_to root_path, alert: "Accès refusé." unless current_user&.is_admin?
  end

  def event_params
    params.require(:event).permit(:start_date, :duration, :title, :description, :price, :location)
  end
end
