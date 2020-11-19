require 'date'

class UsersController < ApplicationController
  include UsersHelper

  def new
    if session[:current_user]
      redirect_to events_path
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      current_user(@user.id)
      redirect_to @user
    else
      render :new
    end
  end

  def show
    if session[:current_user]
      @user = User.find(params[:id])
      current_user(@user.id)
      @date = date_now
      @events = @user.attended_events
    else
      redirect_to sign_in_path
    end
  end

  def sign_in_new
    @user = User.find_by(username: params[:username])
    if @user && params[:password] == @user.password
      current_user(@user.id)
      redirect_to events_path
    else
      render :sign_in
    end
  end

  def sign_in
    redirect_to events_path if session[:current_user]
  end

  def sign_out
    reset_session
    redirect_to sign_in_path
  end
end
