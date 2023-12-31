# frozen_string_literal: true

class CreateShortLinks < ActiveRecord::Migration[7.1]
  def change
    create_table :short_links do |t|
      t.string :original_url, null: false
      t.string :short_url
      t.string :password
      t.integer :link_opened, default: 0
      t.datetime :link_opened_last_time_at

      t.timestamps
    end
  end
end
