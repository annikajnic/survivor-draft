class User::DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @current_episode = Episode.current_episode
    @user_vote = @current_episode ? Vote.find_by(user: current_user, episode: @current_episode) : nil
    @final_prediction = FinalPrediction.find_by(user: current_user)
    @past_votes = Vote.includes(:episode, :contestant)
                     .where(user: current_user)
                     .order("episodes.number DESC")
                     .limit(5)
  end
end
