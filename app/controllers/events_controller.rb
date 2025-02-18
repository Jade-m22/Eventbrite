class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.new(event_params)
    
    if @event.save
      redirect_to root_path, notice: 'Événement créé avec succès.'
    else
      flash.now[:alert] = "Il y a eu une erreur lors de la création de l'événement."
      render :new
    end
  end
  

  def show
    @event = Event.find(params[:id])
  end

  private

  def event_params
    params.require(:event).permit(:start_date, :duration, :title, :description, :price, :location)
  end
end
