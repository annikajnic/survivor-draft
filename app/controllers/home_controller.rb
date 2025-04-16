class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :players, :rules ]

  def index
    @current_episode = Episode.current_episode
    if @current_episode
      @player_votes = Vote.includes(:user, :contestant)
                         .where(episode: @current_episode)
                         .order("users.first_name, users.last_name")
    end
  end

  def players
    @users = User.active.order(:first_name, :last_name)
  end

  def rules
  end
end
