class Admin::EpisodeController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin

  def index
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end
end
