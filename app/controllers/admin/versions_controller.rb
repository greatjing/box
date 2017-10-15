class Admin::VersionsController < AdminController
  # 只有管理员才可以操作
  before_action :require_admin!

  def index
    @versions = PaperTrail::Version.order("id DESC").page(params[:page])
  end

  def undo
    @version = PaperTrail::Version.find(params[:version_id])
    @version.reify.save!

    redirect_to admin_versions_path
  end
end
