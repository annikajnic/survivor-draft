class Admin::EpisodesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin
  before_action :set_episode, only: [ :show, :edit, :update, :destroy ]

  def index
    @episodes = Episode.order(season_number: :desc, number: :desc)
    @seasons = Episode.distinct.pluck(:season_number).sort.reverse
  end

  def show
  end

  def new
    @episode = Episode.new
    @seasons = Contestant.distinct.pluck(:season_number).sort
  end

  def create
    @episode = Episode.new(episode_params)

    if @episode.save
      redirect_to admin_episode_path(@episode), notice: "Episode was successfully created."
    else
      @seasons = Contestant.distinct.pluck(:season_number).sort
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @seasons = Contestant.distinct.pluck(:season_number).sort
  end

  def update
    if @episode.update(episode_params)
      redirect_to admin_episode_path(@episode), notice: "Episode was successfully updated."
    else
      @seasons = Contestant.distinct.pluck(:season_number).sort
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @episode.destroy
    redirect_to admin_episodes_path, notice: "Episode was successfully deleted."
  end

  private

  def set_episode
    @episode = Episode.find(params[:id])
  end

  def episode_params
    params.require(:episode).permit(:number, :air_datetime, :voting_deadline, :season_number)
  end
end
