class StatsController < ApplicationController
  def index
      @documents = Document.all.where(user_id: current_user)

  end

end