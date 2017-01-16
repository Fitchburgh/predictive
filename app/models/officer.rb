class Officer < ActiveRecord::Base
  validates_uniqueness_of :officer_id
  validates_presence_of :name, :companies_id, :officer_id, :position, :start_date

  belongs_to :company
end
