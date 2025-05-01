class DraftsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_draft, only: [ :show, :edit, :update, :destroy, :send_invites ]

  def index
    @drafts = Draft.all()
  end

  def show
    @episodes = @draft.episodes.order(number: :asc)
    @players = @draft.players()
    @season_contestants = Contestant.where(season_number: @draft.season_number).order(:name)
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

  def send_invites
    if request.post?
      emails = params[:emails].split(/[\s,]+/).map(&:strip).reject(&:empty?)

      if emails.any?
        emails.each do |email|
          DraftMailer.invite_email(@draft, email).deliver_later
        end

        redirect_to @draft, notice: "Invites have been sent successfully."
      else
        redirect_to send_invites_draft_path(@draft), alert: "Please enter at least one email address."
      end
    end
  end

  private

  def set_draft
    @draft = Draft.find(params[:id])
  end

  def draft_params
    params.require(:draft).permit(:name, :season_number, :episodes_count, :airing_datetime,  :votes_first_episode)
  end
end
