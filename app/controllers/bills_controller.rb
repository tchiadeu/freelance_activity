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
    @bill.total_amount = @bill.items.map { |item| ttc_price(item) }.sum
    if @bill.save
      redirect_to root_path(@bill)
    else
      render :new
    end
  end

  def show
    @bill = Bill.find(params[:id])
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "F-#{@bill.year}-#{bill_number}",
               template: 'bills/show',
               formats: [:html],
               encoding: 'utf8'
      end
    end
  end

  def edit
    @bill = Bill.find(params[:id])
  end

  def update
    @bill = Bill.find(params[:id])
    @bill.update(bill_params)
  end

  def destroy
    @bill = Bill.find(params[:id])
    @bill.destroy
  end

  def bill_number
    if bills_of_year.count + 1 < 10
      @bill.number = "0#{bills_of_year.count + 1}"
    else
      @bill.number = "#{bills_of_year.count}"
    end
  end

  def ht_price(item)
    (item.quantity.to_f * item.unit_price.to_f).truncate(2)
  end

  def tva_application?
    current_year_amount > 36_800
  end

  def item_tva_amount(item)
    ht_price(item) * 0.2
  end

  def bill_tva_amount(bill)
    bill.items.map { |item| item_tva_amount(item) }.sum
  end

  def ttc_price(item)
    ht_price(item) + tva_amount(item)
  end

  helper_method :bill_number, :ht_price, :tva_application?, :item_tva_amount, :bill_tva_amount, :ttc_price

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
    @bill.number = bills_of_year.count + 1
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
      @bill.items << item if item.name.present?
    end
  end
end
