class Admin::UsersController < AdminController
  # 只有管理员才可以操作
  before_action :require_admin!

  def index
    # @users = User.all
    @users = User.includes(:groups).all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:notice] = "更新成功"
      redirect_to admin_users_path
    else
      render "edit"
    end
  end

  protected

  def user_params
    params.require(:user).permit(:email, :role, :group_ids => [])
  end


end
