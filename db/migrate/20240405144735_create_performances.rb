# frozen_string_literal: true

class CreatePerformances < ActiveRecord::Migration[7.1]
  def change
    create_table :performances do |t|
      t.references :type_performance, null: false, foreign_key: true
      t.references :player, null: false, foreign_key: true
      t.references :match, null: false, foreign_key: true

      t.timestamps
    end

    add_index :performances, %i[type_performance_id player_id match_id], unique: true
  end
end
