require_relative 'models/politician'
require_relative '../db/config'

class Main < ActiveRecord::Base

  #p Politician.find(10)

  p "Senators:"
  Politician.where("state = ? and title = ? and in_office = ?", "NC", "Sen", 1).each { |politician|
    p "  #{politician.first_name} #{politician.last_name} (#{politician.party})"
  }
  p "Representatives:"
  Politician.where("state = ? and title = ? and in_office = ?", "NC", "Rep", 1).each { |politician|
    p "  #{politician.first_name} #{politician.last_name} (#{politician.party})"
  }

end