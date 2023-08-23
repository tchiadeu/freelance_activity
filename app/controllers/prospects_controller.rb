class ProspectsController < ApplicationController
  def index
    @prospects = Prospect.where(user: current_user)
  end

  def new
    @prospect = Prospect.new
    @prospect.user = current_user
  end

  def create
    @prospect = Prospect.new(prospect_params)
    @prospect.user = current_user
    if @prospect.save
      redirect_to prospects_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def prospect_params
    params.require(:prospect).permit(
      :name, :place_of_knowledge, :relation_type, :proximity_level, :power, :network_power,
      :activity_area, :city, :contacted, :called, :signed
    )
  end
end
