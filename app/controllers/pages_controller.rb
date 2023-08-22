class PagesController < ApplicationController
  before_action :authenticate_user!

  def dashboard
  end

  def administrative
    @bills = Bill.where(user: current_user)
  end

  def profile
  end
end
