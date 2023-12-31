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
    if @bill.save!
      redirect_to root_path(@bill)
    else
      render :new, status: :unprocessable_entity
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
               encoding: 'utf8',
               layout: 'pdf'
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
    redirect_to administrative_path, status: :see_other
  end

  def bill_number
    @bill.number = if bills_of_year.count + 1 < 10
                     "0#{bills_of_year.count}"
                   else
                     bills_of_year.count.to_s
                   end
  end

  def ht_price(item)
    (item.quantity.to_f * item.unit_price.to_f).truncate(2)
  end

  def item_tva_amount(item)
    ht_price(item) * 0.2
  end

  def bill_tva_amount(bill)
    bill.items.map { |item| item_tva_amount(item) }.sum
  end

  def ttc_price(item)
    ht_price(item) + item_tva_amount(item)
  end

  def clients_proposition(clients)
    propositions = ['']
    clients.each do |client|
      propositions << [
        client.name,
        data: {
          address: client.address,
          post_code: client.post_code,
          city: client.city,
          siret_number: client.siret_number,
          tva_number: client.tva_number,
          email: client.email,
          phone_number: client.phone_number,
          bill_form_target: 'clientsAttributes'
        }
      ]
    end
    propositions
  end

  helper_method :bill_number, :ht_price, :item_tva_amount, :bill_tva_amount, :ttc_price, :clients_proposition

  private

  def bills_of_year
    Bill.where(year: @bill.year, user: current_user)
  end

  def current_year_amount
    bills_of_year.sum(:total_amount)
  end

  def build_client
    if params[:bill][:client_attributes][:name].present?
      client = Client.find_or_initialize_by(name: params[:bill][:client_attributes][:name])
      client.address = params[:bill][:client_attributes][:address]
      client.post_code = params[:bill][:client_attributes][:post_code]
      client.city = params[:bill][:client_attributes][:city]
      client.siret_number = params[:bill][:client_attributes][:siret_number]
      client.tva_number = params[:bill][:client_attributes][:tva_number]
      client.email = params[:bill][:client_attributes][:email]
      client.phone_number = params[:bill][:client_attributes][:phone_number]
      client.user = current_user
      client.save!
      @bill.client = client
    end
  end

  def build_bill
    @bill = Bill.new(bill_params)
    @bill.user = current_user
    @bill.month = Date.today.month
    @bill.year = Date.today.year
    @bill.emission_date = Date.today
    @bill.due_date = Date.today + 30
    @bill.number = bills_of_year.count + 1
    @bill.taxes = true if current_year_amount >= 36_800
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

  def bill_params
    params.require(:bill).permit(
      :number, :total_amount, :payed, :year, :month, :emission_date, :due_date,
      client_attributes: %i[name address post_code city siret_number tva_number email phone_number],
      items_attributes: %i[name description unity quantity unit_price total_price]
    )
  end
end
