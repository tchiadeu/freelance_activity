class ClientsController < ApplicationController
  def index
    @clients = Client.where(user: current_user)
  end
end
