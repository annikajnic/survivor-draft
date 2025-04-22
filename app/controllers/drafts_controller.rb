class DraftsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_draft, only: [ :show, :edit, :update, :destroy ]

  def index
    @drafts = Draft.all.order(airing_date: :desc)
  end

  def show
    @episodes = @draft.episodes.order(number: :asc)
    @contestants = @draft.contestants.order(name: :asc)
    @players = @draft.players
  end

  def new
    @draft = current_user.drafts_as_owner.build
  end

  def create
    @draft = current_user.drafts_as_owner.build(draft_params)

    if @draft.save
      redirect_to @draft, notice: "Draft was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @draft.update(draft_params)
      redirect_to @draft, notice: "Draft was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @draft.destroy
    redirect_to drafts_url, notice: "Draft was successfully destroyed."
  end

  private

  def set_draft
    @draft = Draft.find(params[:id])
  end

  def draft_params
    params.require(:draft).permit(:season_number, :episodes_count, :airing_date)
  end
end
