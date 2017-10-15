class AdminController < ApplicationController
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  # 后台增加admin权限校验
  # before_action :require_admin!

  layout "admin"

  protected

  def require_editor!
    # if current_user.role != "editor" && current_user.role != "admin"
    # 重构校验是否有editor权限
    unless current_user.is_editor?
      flash[:alert] = "您的权限不足2"
      redirect_to root_path
    end
  end

  def require_admin!
    # if current_user.role != "admin"
    # 重构是否有admin权限
    unless current_user.is_admin?
      flash[:alert] = "您的权限不足1"
      redirect_to root_path
    end
  end

end
