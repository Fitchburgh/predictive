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
    a = 0
    
    until @data['results']['companies'][a].nil?
      binding.pry
      @name = @data['results']['companies'][a]['company']['name']
      @company_number = @data['results']['companies'][a]['company']['company_number']
      @company_type = @data['results']['companies'][a]['company']['company_type']
      @incorporation_date = @data['results']['companies'][a]['company']['incorporation_date']
      @registered_address_in_full = @data['results']['companies'][a]['company']['registered_address_in_full']
      @current_status = @data['results']['companies'][a]['company']['current_status']
      @jurisdiction_code = @data['results']['companies'][a]['company']['jurisdiction_code']
      register_company
      a += 1
    end

  end

  def register_company
    @company = Company.create!(
      name: @name,
      company_number: @company_number,
      company_type: @company_type,
      incorporation_date: @incorporation_date,
      registered_address_in_full: @registered_address_in_full,
      current_status: @current_status,
      jurisdiction_code: @jurisdiction_code
    )
  end

  def get_json(url)
    HTTParty.get(url).parsed_response
  end
end
