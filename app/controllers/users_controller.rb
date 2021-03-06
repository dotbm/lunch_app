# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, except: :index
  before_action :check_policy

  def index
    @users = User.all
  end

  def update
    respond_with update_user, location: user_path(@user)
  end

  private

  def check_policy
    authorize(@user || User)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params
      .require(:user)
      .permit(:username)
  end

  def update_user
    Users::Update.call(
      user:        @user,
      user_params: user_params
    )
  end
end
