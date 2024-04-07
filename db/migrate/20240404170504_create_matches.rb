# frozen_string_literal: true

class CreateMatches < ActiveRecord::Migration[7.1]
  def change
    create_table :matches do |t|
      t.date :date
      t.string :result

      t.timestamps
    end
  end
end
