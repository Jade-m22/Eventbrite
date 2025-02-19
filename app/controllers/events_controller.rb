class EventsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update destroy my_events]
  before_action :set_event, only: %i[show edit update destroy]
  before_action :authorize_user!, only: %i[edit update destroy]

  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.new(event_params)

    if @event.save
      redirect_to root_path, notice: "Événement créé avec succès."
    else
      flash.now[:alert] = "Il y a eu une erreur lors de la création de l'événement."
      render :new
    end
  end

  def show
    @event = Event.find(params[:id])
    @participant_count = @event.attendances.count
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: "Événement mis à jour avec succès."
    else
      flash.now[:alert] = "Erreur lors de la mise à jour de l'événement."
      render :edit
    end
  end

  def destroy
    @event.destroy
    redirect_to root_path, notice: "Événement supprimé avec succès."
  end

  def my_events
    @events = current_user.events.includes(:participants)
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def authorize_user!
    redirect_to root_path, alert: "Tu n'es pas autorisé à modifier cet événement." unless @event.user == current_user
  end

  def event_params
    params.require(:event).permit(:start_date, :duration, :title, :description, :price, :location)
  end
end
