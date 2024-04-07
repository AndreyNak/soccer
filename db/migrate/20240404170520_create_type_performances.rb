# frozen_string_literal: true

class CreateTypePerformances < ActiveRecord::Migration[7.1]
  def change
    create_table :type_performances do |t|
      t.text :description
      t.timestamps
    end

    add_index :type_performances, :description, unique: true
  end
end
