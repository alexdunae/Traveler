class UsersController < Clearance::UsersController
  before_action :lookup_user, only: [:show, :edit, :update, :destroy]
  before_action :require_login, only: [:index, :edit, :update, :destroy]

  # since this is an admin-only action, it would be good to ensure that the current user
  # is an admin here (probably with a new `before_action`).
  def index
    @users = User.order('name ASC')
  end

  def show
  end

  def edit
    redirect_to root_path, notice: "Nope...you're not allowed there" unless current_user.id == @user.id
  end

  def update
    if @user.update_attributes(user_params)
      redirect_to root_path, notice: "Awesome, we updated your profile!"
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :about, :city, :country, :birth_date, :avatar, :email, :password)
  end

  def user_from_params
    email = user_params.delete(:email)
    password = user_params.delete(:password)

    Clearance.configuration.user_model.new(user_params).tap do |user|
      user.email = email
      user.password = password
    end
  end

  def lookup_user
    @user = User.find(params[:id])
  end
end
