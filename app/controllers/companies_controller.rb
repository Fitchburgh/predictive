class CompaniesController < ApplicationController
  before_action :require_user, only: [:index, :show]

  def index
    @user = User.find(session[:user_id])
  end

  def guess
  end

  def return
    @searched_company = Company.new(params['company']['company'])

    if !@data.nil?
      @company = Company.create!(
        name: @name,
        company_number: @company_number,
        company_type: @company_type,
        incorporation_date: @incorporation_date,
        registered_address_in_full: @registered_address_in_full,
        current_status: @current_status,
        jurisdiction_code: @jurisdiction_code
      )
      @companies = Company.all
      return @companies
    end
  end
end
