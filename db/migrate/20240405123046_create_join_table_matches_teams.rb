# frozen_string_literal: true

class CreateJoinTableMatchesTeams < ActiveRecord::Migration[7.1]
  create_join_table :matches, :teams do |t|
    t.index :match_id
    t.index :team_id
  end
end
