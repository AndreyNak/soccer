# frozen_string_literal: true

class Player < ApplicationRecord
  has_many :performances

  belongs_to :team

  has_many :matches, through: :team

  def mark_performance_in_match(type_performance, match_id)
    raise TypeError unless type_performance.is_a?(String)

    type = TypePerformance.find_or_create_by(description: type_performance)
    match = Match.find(match_id)

    Performance.create(player: self, match:, type_performance: type)
  end

  def check_performance_in_last_5_matches(type_performance)
    team_matches = matches.last(5)
    performances.exists?(player: self, match: team_matches, type_performance:)
  end

  def self.top_players_by_performance_type(type_performance, team_id = nil)
    players = joins(:performances).where(performances: { type_performance: })

    players = players.where(team_id:) if team_id
    players.group(:id).order('COUNT(performances.id) DESC').limit(5)
  end
end
