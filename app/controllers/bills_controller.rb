class BillsController < ApplicationController
  before_action :authenticate_user!

  def new
    @bill = Bill.new
    @bill.build_client
    @bill.items.build
  end

  def create
    build_bill
    build_client
    build_items
    @bill.total_amount = @bill.items.sum(:total_price)
    if @bill.save
      redirect_to bill_path(@bill)
    else
      render :new
    end
  end

  private

  def bill_params
    params.require(:bill).permit(
      :number, :total_amount, :payed, :year, :month, :emission_date, :due_date,
      client_attributes: %i[name address post_code city siret_number tva_number email phone_number],
      items_attributes: %i[name description unity quantity unit_price total_price]
    )
  end

  def bills_of_year
    Bill.where(year: @bill.year, user: current_user)
  end

  def current_year_amount
    bills_of_year.sum(:total_amount)
  end

  def build_client
    client = Client.new(
      name: params[:bill][:client_attributes][:name],
      address: params[:bill][:client_attributes][:address],
      post_code: params[:bill][:client_attributes][:post_code],
      city: params[:bill][:client_attributes][:city],
      siret_number: params[:bill][:client_attributes][:siret_number],
      tva_number: params[:bill][:client_attributes][:tva_number],
      email: params[:bill][:client_attributes][:email],
      phone_number: params[:bill][:client_attributes][:phone_number]
    )
    client.user = current_user
    client.save
    @bill.client = client
  end

  def build_bill
    @bill = Bill.new(bill_params)
    @bill.user = current_user
    @bill.month = Date.today.month
    @bill.year = Date.today.year
    @bill.emission_date = Date.today
    @bill.due_date = Date.today + 30
    if bills_of_year.count + 1 < 10
      @bill.number = "0#{bills_of_year.count + 1}"
    else
      @bill.number = "#{bills_of_year.count}"
    end
  end

  def build_items
    10.times do |i|
      item_params = params[:bill][:item][i.to_s]
      item = Item.new(
        name: item_params[:name],
        description: item_params[:description],
        unity: item_params[:unity],
        quantity: item_params[:quantity],
        unit_price: item_params[:unit_price]
      )
      if current_year_amount > 36_800
        item.total_price = item.quantity.to_f * item.unit_price.to_f * 1.2
      else
        item.total_price = item.quantity.to_f * item.unit_price.to_f
      end
      @bill.items << item if item.name.present?
    end
  end
end
