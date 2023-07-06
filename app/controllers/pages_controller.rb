class PagesController < ApplicationController
  def dashboard
    @bills = Bill.where(user: current_user)
    @clients = Client.where(user: current_user)
  end
end
