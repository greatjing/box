class EventsController < ApplicationController

  def index
    @events = Event.all
  end

  def show
    # @event = Event.find(params[:id])
    # 使用find friendly——id
    @event = Event.find_by_friendly_id!(params[:id])
  end

end