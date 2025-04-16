class Admin::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin

  def index
    @contestants = Contestant.count
    @active_contestants = Contestant.active.count
    @episodes = Episode.count
    @current_episode = Episode.current_episode
    @users = User.count
    @active_users = User.where(status: "active").count
  end

  private

  def require_admin
    unless current_user.admin?
      redirect_to root_path, alert: "You must be an admin to access this page."
    end
  end
end
