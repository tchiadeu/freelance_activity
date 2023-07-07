class PagesController < ApplicationController
  before_action :authenticate_user!

  def dashboard
    @bills = Bill.where(user: current_user)
    @clients = Client.where(user: current_user)
  end
end
