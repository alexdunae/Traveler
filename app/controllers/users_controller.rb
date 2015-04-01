class UsersController < Clearance::UsersController
  before_action :require_login, only: [:index, :edit, :update, :destroy]

  def index
    if current_user.is_admin?
      @users = User.order('name ASC')
    else
      redirect to root_path, notice: "Nope...you're not allowed there"
    end
  end

  def show
  end

  def edit
    redirect_to root_path, notice: "Nope...you're not allowed there" unless current_user.id == @user.id
  end
  
  def update
    if @user.update_attributes(user_params)
      redirect_to edit_user_path(@user), notice: "Profile updated!"
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :about, :city, :country, :birthday, :avatar, :email, :password)
  end

  def user_from_params
    email = user_params.delete(:email)
    password = user_params.delete(:password)

    Clearance.configuration.user_model.new(user_params).tap do |user|
      user.email = email
      user.password = password
    end
  end
end