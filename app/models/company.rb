require 'pry'

class Company < ActiveRecord::Base
  validates_uniqueness_of :company_number
  validates_presence_of :name, :company_number, :company_type, :incorporation_date, :registered_address, :current_status

  has_many :officer

  attr_reader :companies, :name, :company_number, :company_type, :incorporation_date, :registered_address_in_full, :current_status, :jurisdiction_code

  def initialize(searched_company)
    @search = searched_company
    load
  end

  def load
    binding.pry
    @clean_company = @search.downcase.gsub(/\s+/, "+")
    search_company
  end

  def search_company
    if @clean_company.length >= 2
      @data = get_json("https://api.opencorporates.com/companies/search?q=#{@clean_company}")
      unless @data['results']['companies'].empty?
        parse_search_results
        @companies = Company.all
      end
    end
  end

  def parse_search_results
    @data['results']['companies'].each do |l|
      @name = [l][0]['company']['name']
      @company_number = [l][0]['company']['company_number']
      @company_type = [l][0]['company']['company_type']
      @incorporation_date = [l][0]['company']['incorporation_date']
      @registered_address_in_full = [l][0]['company']['registered_address_in_full']
      @current_status = [l][0]['company']['current_status']
      @jurisdiction_code = [l][0]['company']['jurisdiction_code']

      Company.create!(
        name: @name,
        company_number: @company_number,
        company_type: @company_type,
        incorporation_date: @incorporation_date,
        registered_address_in_full: @registered_address_in_full,
        current_status: @current_status,
        jurisdiction_code: @jurisdiction_code
      )
    end
  end

  def get_json(url)
    HTTParty.get(url).parsed_response
  end
end
