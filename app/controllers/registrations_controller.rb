class RegistrationsController < ApplicationController
  before_action :set_channel
  before_action :set_user
  before_action :authenticate_user!

  # adds channel to user's subscribed list
  def add_channel
    if !@channel.users.include?(@user)
      @channel.users << @user
      redirect_to @user
    end
  end

  # drops channel from user's subscribed list
  def drop_channel
    if @channel.users.include?(@user)
      @channel.users.delete(@user)
      redirect_to @user
    end
  end

  private
  
  # initializes channel object from route params
  def set_channel
    @channel = Channel.find(params[:channel_id])
  end

  # initializes user object from route params
  def set_user
    @user = User.find(params[:user_id])
  end
end