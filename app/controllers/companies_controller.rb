class CompaniesController < ApplicationController
  before_action :require_user, only: [:index, :show]

  def index
    @user = User.find(session[:user_id])
  end

  def guess
  end

  def return
    @searched_company = Company.new(params['company']['company'])
  end
end
