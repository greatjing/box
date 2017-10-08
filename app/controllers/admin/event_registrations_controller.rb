class Admin::EventRegistrationsController < AdminController
  before_action :find_event

  def index
    # 分页显示，每页10个，按照id的倒序显示，registration要包括tickets
    @registrations = @event.registrations.includes(:ticket).order("id DESC").page(params[:page]).per(10)
  end

  def destroy
    @registration = @event.registrations.find_by_uuid(params[:id])
    @registration.destroy

    redirect_to admin_event_registrations_path(@event)
  end

  protected

  def find_event
    @event = Event.find_by_friendly_id!(params[:event_id])
  end


end
