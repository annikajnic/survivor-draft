class Drafts::VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_episode, only: [ :new, :create ]
  before_action :check_user_status, only: [ :new, :create ]
  before_action :check_voting_open, only: [ :new, :create ]
  before_action :check_previous_vote, only: [ :new, :create ]

  def index
    @player_votes = Vote.where(episode_id: @episode.id, user_id: current_user.id)
  end

  def new
    @vote = Vote.new
    @available_contestants = Contestant.active
                                     .where.not(id: current_user.votes.pluck(:contestant_id))
  end

  def create
    @vote = current_user.votes.build(vote_params)
    @vote.episode = @episode
    @player_votes = Vote.where(episode_id: @episode.id, user_id: current_user.id)

    if @vote.save
      redirect_to root_path, notice: "Your vote has been submitted successfully!"
    else
      @available_contestants = Contestant.active
                                       .where.not(id: current_user.votes.pluck(:contestant_id))
      render :new, status: :unprocessable_entity
    end
  end


  private

  def set_episode
    @episode = Episode.find(params[:episode_id])
  end

  def vote_params
    params.require(:vote).permit(:contestant_id)
  end

  def check_user_status
    unless current_user.active?
      redirect_to root_path, alert: "You cannot vote as you have been eliminated."
    end
  end

  def check_voting_open
    unless @episode.voting_open?
      redirect_to root_path, alert: "Voting is currently closed for this episode."
    end
  end

  def check_previous_vote
    if current_user.votes.where(episode: @episode).exists?
      redirect_to root_path, alert: "You have already submitted your vote for this episode."
    end
  end
end
