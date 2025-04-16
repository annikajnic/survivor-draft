class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :players, :rules ]

  def index
  end

  def players
    # @users = User.all
  end

  def rules
  end
end
