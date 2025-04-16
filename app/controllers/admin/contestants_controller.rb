class Admin::ContestantsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin
  before_action :set_contestant, only: [ :show, :edit, :update, :destroy ]

  def index
    @contestants = Contestant.all.order(:name)
  end

  def new
    @contestant = Contestant.new
  end

  def create
    @contestant = Contestant.new(contestant_params)
    if @contestant.save
      redirect_to admin_contestants_path, notice: "Contestant was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @contestant.update(contestant_params)
      redirect_to admin_contestants_path, notice: "Contestant was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @contestant.destroy
    redirect_to admin_contestants_path, notice: "Contestant was successfully destroyed."
  end

  private

  def set_contestant
    @contestant = Contestant.find(params[:id])
  end

  def contestant_params
    params.require(:contestant).permit(:name, :status)
  end

  def require_admin
    unless current_user.admin?
      redirect_to root_path, alert: "You are not authorized to access this page."
    end
  end
end
