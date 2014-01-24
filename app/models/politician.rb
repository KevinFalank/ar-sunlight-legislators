require_relative '../../db/config'
require 'date'

class Politician < ActiveRecord::Base

  validates :phone, :format => { :with => /\A\d{10}/, :message => "Invalid phone number format"}, allow_blank: true
  #validates :fax, :format => { :with => /\A\d{10}/, :message => "Invalid fax number format"}, allow_blank: true
  validates :party, length: { is: 1 }
  validates :state, length: { is: 2 }

  

  def name
    "#{title}. #{name}"
  end

  def age
    now = Date.today
    now.year - birthdate.year - (birthdate.to_date.change(:year => now.year) > now ? 1 : 0)
  end

end

