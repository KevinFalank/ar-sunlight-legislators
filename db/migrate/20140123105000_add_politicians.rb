require_relative '../config'

class AddPoliticians < ActiveRecord::Migration
    def change
      create_table :politicians do |t|
        t.string  :title
        t.string  :first_name
        t.string  :last_name
        t.string  :party
        t.string  :state
        t.string  :district
        t.integer :in_office
        t.string  :gender
        t.string  :phone
        t.string  :fax
        t.string  :website
        t.string  :webform
        t.string  :twitter_id
        t.date    :birthdate
        t.timestamps
      end
    end
end

