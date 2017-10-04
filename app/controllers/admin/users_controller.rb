class Admin::UsersController < AdminController

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:notice] = "更新成功"
      redirect_to admin_user_path
    else
      render "edit"
    end
  end

  protected

  def user_params
    params.require[:user].permit(:email)
  end


end
