class Drafts::ContestantsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_contestant, only: [ :show, :edit, :update, :destroy ]

  def index
    @contestants = Contestant.all

    # Apply filters if present
    if params[:season].present?
      @contestants = @contestants.where(season_number: params[:season])
    end

    if params[:tribe].present?
      @contestants = @contestants.where(tribe: params[:tribe])
    end

    # Get unique values for filter dropdowns
    @seasons = Contestant.distinct.pluck(:season_number).sort
    @tribes = Contestant.distinct.pluck(:tribe).sort

    # Apply pagination
    @contestants = @contestants.order(:season_number, :name).page(params[:page]).per(20)
  end

  def show
  end

  def new
    @contestant = Contestant.new
  end

  def create
    @contestant = Contestant.new(contestant_params)

    if @contestant.save
      redirect_to admin_contestants_path, notice: "Contestant was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @contestant.update(contestant_params)
      redirect_to admin_contestants_path, notice: "Contestant was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @contestant.destroy
    redirect_to admin_contestants_path, notice: "Contestant was successfully deleted."
  end

  private

  def set_contestant
    @contestant = Contestant.find(params[:id])
  end

  def contestant_params
    params.require(:contestant).permit(:name, :tribe, :status, :season_number)
  end

  def require_admin
    unless current_user.admin?
      redirect_to root_path, alert: "You must be an admin to access this page."
    end
  end
end
