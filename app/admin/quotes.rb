# frozen_string_literal: true

ActiveAdmin.register Quote do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :ticker, :sector, :industry, :market_cap, :employees, :description, :website, :phone, :address, :city, :state, :zip, :country, :fund_family, :expense_ratio, :beta, :dividend_yield, :price_to_earnings_ratio, :earnings_per_share, :price_to_book_ratio, :net_assets, :exchange_id, :sector_id, :type

  index do
    id_column
    column :ticker
    column :name
    column :exchange
    column :price
    actions
  end
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :ticker, :sector, :industry, :market_cap, :employees, :description, :website, :phone, :address, :city, :state, :zip, :country, :fund_family, :expense_ratio, :beta, :dividend_yield, :price_to_earnings_ratio, :earnings_per_share, :price_to_book_ratio, :net_assets, :exchange_id, :sector_id, :type]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
