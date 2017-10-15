class RegistrationsController < ApplicationController
  before_action :find_event

  def new
  end

  def create
    @registration = @event.registrations.new(registration_params)
    # 下面的一句不懂，为什么不直接使用前端传递的tickets——id————是为了确认这个票中是属于这个活动event
    @registration.ticket = @event.tickets.find(params[:registration][:ticket_id])
    @registration.user_id = current_user
    # @registration.status = "confirmed"
    @registration.status = "pending"
    @registration.current_step = 1

    if @registration.save
      # redirect_to event_registration_path(@event, @registration)
      redirect_to step2_event_registration_path(@event, @registration)
    else
      flash.now[:alert] = @registration.errors[:base].join("、")
      render "new"
    end
  end

  def step1
    @registration = @event.registrations.find_by_uuid(params[:id])
  end

  def step1_update
    @registration = @event.registrations.find_by_uuid(params[:id])
    @registration.current_step = 1

    if @registration.update(registration_params)
      redirect_to step2_event_registration_path(@event, @registration)
    else
      render "step1"
    end
  end

  def step2
    @registration = @event.registrations.find_by_uuid(params[:id])
  end

  def step2_update
    @registration = @event.registrations.find_by_uuid(params[:id])
    @registration.current_step = 2

    if @registration.update(registration_params)
      redirect_to step3_event_registration_path(@event, @registration)
    else
      render "step2"
    end
  end

  def step3
    @registration = @event.registrations.find_by_uuid(params[:id])
  end

  def step3_update
    @registration = @event.registrations.find_by_uuid(params[:id])
    @registration.status = "confirmed"
    @registration.current_step = 3

    if @registration.update(registration_params)
      flash[:notice] = "报名成功"

      # 发送邮件
      NotificationMailer.confirmed_registration(@registration).deliver_later

      redirect_to event_registration_path(@event, @registration)
    else
      render "step3"
    end
  end


  def show
    @registration = @event.registrations.find_by_uuid(params[:id])
  end


  protected

  def find_event
    @event = Event.find_by_friendly_id(params[:event_id])
  end

  def registration_params
    params.require(:registration).permit(:ticket_id, :name, :email, :cellphone, :website, :bio)
  end
end
