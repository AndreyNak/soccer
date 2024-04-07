# frozen_string_literal: true

class CreatePlayers < ActiveRecord::Migration[7.1]
  def change
    create_table :players do |t|
      t.string :name
      t.integer :age
      t.belongs_to :team, null: false, foreign_key: true

      t.timestamps
    end
  end
end
