class EventsController < ApplicationController

  def index
    # @events = Event.rank(:row_order).all
    # 前台只显示public状态内容
    @events = Event.only_public.rank(:row_order).all
  end

  def show
    # @event = Event.find(params[:id])
    # 使用find friendly——id
    # @event = Event.find_by_friendly_id!(params[:id])
    # 不显示draft内容
    @event = Event.only_available.find_by_friendly_id!(params[:id])
  end

end
