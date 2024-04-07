# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Player do
  let(:team_a) { create(:team, name: 'Team A') }
  let(:team_b) { create(:team, name: 'Team B') }

  let(:player) { create(:player, team: team_a) }
  let(:player_b) { create(:player, team: team_a) }
  let(:match) { create(:match, teams: [team_a, team_b]) }

  describe '#mark_performance_in_match' do
    let(:type_performance) { 'Test Performance' }

    it 'creates a new performance' do
      expect { player.mark_performance_in_match(type_performance, match.id) }
        .to change(Performance, :count).by(1)
    end

    it 'assigns an existing TypePerformance' do
      player_b.mark_performance_in_match(type_performance, match.id)
      expect { player.mark_performance_in_match(type_performance, match.id) }
        .not_to change(TypePerformance, :count)
    end

    it 'checks player valid performances' do
      player.mark_performance_in_match(type_performance, match.id)
      expect(player.performances.first.type_performance.description).to eq('Test Performance')
    end
  end

  describe '#check_performance_in_last_5_matches' do
    let(:type_performance) { 'Test Performance' }

    context 'when performance exists last 5 in matches' do
      before do
        create_performances(player, [team_a, team_b], 5)
      end

      it 'returns true' do
        type = TypePerformance.find_or_create_by(description: type_performance)
        expect(player.check_performance_in_last_5_matches(type)).to be_truthy
      end
    end

    context 'when performance does not exist in last 5 matches' do
      before do
        create_performances(player, [team_a, team_b], 3, 'Another Performance')
      end

      it 'returns false' do
        type = TypePerformance.find_or_create_by(description: type_performance)
        expect(player.check_performance_in_last_5_matches(type)).to be_falsey
      end
    end
  end

  describe '.top_players_by_performance_type' do
    let(:type_performance) { 'Test Performance' }
    let(:team) { create(:team) }

    context 'when team_id is provided' do
      let(:player1) { create(:player, team:) }
      let(:player2) { create(:player, team:) }
      let(:player3) { create(:player) }

      before do
        create_performances(player1, [team], 3)
        create_performances(player2, [team], 2)
        create_performances(player3, [create(:team)], 1)
      end

      it 'returns top players from the specified team' do
        type = TypePerformance.find_or_create_by(description: type_performance)
        top_players = described_class.top_players_by_performance_type(type, team.id)
        expect(top_players.length).to eq(2)
        expect(top_players.first.id).to eq(player1.id)
        expect(top_players.last.id).to eq(player2.id)
      end
    end

    context 'when team_id is not provided' do
      let(:player1) { create(:player) }
      let(:player2) { create(:player) }
      let(:player3) { create(:player) }

      before do
        create_performances(player1, [create(:team)], 3)
        create_performances(player2, [create(:team)], 2)
        create_performances(player3, [create(:team)], 1)
      end

      it 'returns top players from all teams' do
        type = TypePerformance.find_or_create_by(description: type_performance)
        top_players = described_class.top_players_by_performance_type(type)
        expect(top_players.length).to eq(3)
        expect(top_players.first.id).to eq(player1.id)
        expect(top_players.last.id).to eq(player3.id)
      end
    end
  end
end

def create_performances(player, teams, count, type_performance = 'Test Performance')
  matches = create_list(:match, count, teams:)

  matches.each do |match|
    player.mark_performance_in_match(type_performance, match.id)
  end
end
