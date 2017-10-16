require 'csv'
class Admin::EventRegistrationsController < AdminController
  before_action :find_event
  # 增加权限校验
  before_action :require_editor!

  def index
    # 分页显示，每页10个，按照id的倒序显示，registration要包括tickets
    # @registrations = @event.registrations.includes(:ticket).order("id DESC").page(params[:page]).per(10)

    #使用搜索功能
    @q = @event.registrations.ransack(params[:q])
    @registrations = @q.result.includes(:ticket).order("id DESC").page(params[:page]).per(10)

    # 按照报名标号进行查找,可用逗号进行多个查找
    if params[:registration_id].present?
      @registrations = @registrations.where( :id => params[:registration_id].split(",") )
    end

# 单选status和ticket
    if params[:status].present? && Registration::STATUS.include?(params[:status])
        @registrations = @registrations.by_status(params[:status])
    end

    if params[:ticket_id].present?
      @registrations = @registrations.by_ticket(params[:ticket_id])
    end

#多选status和ticket
    if Array(params[:statuses]).any?
      @registrations = @registrations.by_status(params[:statuses])
    end

    if Array(params[:ticket_ids]).any?
      @registrations = @registrations.by_ticket(params[:ticket_ids])
    end

    # 按时间筛选
    if params[:start_on].present?
      @registrations = @registrations.where( " created_at >= ? ", Date.parse(params[:start_on]).beginning_of_day )
    end

    if params[:end_on].present?
      @registrations = @registrations.where( " created_at <= ? ", Date.parse(params[:end_on]).end_of_day )
      #@registrations = @registrations.where( "created_at <= ?", Date.parse(params[:end_on]).end_of_day )
    end

    # 使用csv导出内容
    respond_to do |format|
      format.html
      format.csv {
        @registrations = @registrations.reorder("id ASC")
        csv_string = CSV.generate do |csv|
          csv << ["报名ID", "票种", "姓名","状态","Email","报名时间"]
          @registrations.each do |r|
            csv << [r.id, r.ticket.name, r.name, t(r.status, :scope => "registration.status"), r.email, r.created_at ]
          end
        end
        send_data csv_string, :filename => "#{@event.friendly_id}-registrations-#{Time.now.to_s(:number)}.csv"
      }
      format.xlsx
    end

  end


  def destroy
    @registration = @event.registrations.find_by_uuid(params[:id])
    @registration.destroy

    redirect_to admin_event_registrations_path(@event)
  end

# 从前端导入csv文件数据
  def import
    csv_string = params[:csv_file].read.force_encoding('utf-8')

    tickets = @event.tickets

    success =0
    failed_records = []

    CSV.parse(csv_string) do |row|
      registration = @event.registrations.new( :status => "confirmed",
                                               :ticket => tickets.find { |t| t.name == row[0] },
                                               :name => row[1],
                                               :email => row[2],
                                               :cellphone => row[3],
                                               :website => row[4],
                                               :bio => row[5],
                                               :created_at => Time.parse(row[6])  )

      if registration.save
        success += 1
      else
        failed_records << [row, registration]
        Rails.logger.info("#{row}---->#{registration.errors.full_messages}")
      end
    end

    flash[:notice] = "总汇入数据#{success}笔，失败#{failed_records.size}笔"
    redirect_to admin_event_registrations_path(@event)
  end

  protected

  def find_event
    @event = Event.find_by_friendly_id!(params[:event_id])
  end


end
