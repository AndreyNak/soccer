# frozen_string_literal: true

ActiveRecord::Base.transaction do
  team1 = Team.create(name: 'Team A')
  team2 = Team.create(name: 'Team B')

  team1.players.create(name: 'Andre', age: 25)
  team1.players.create(name: 'Dima', age: 27)
  team1.players.create(name: 'Alex', age: 23)

  team2.players.create(name: 'Maria', age: 29)
  team2.players.create(name: 'Dasha', age: 26)
  team2.players.create(name: 'Lena', age: 22)

  Match.create(date: Time.zone.today, result: 'Team A vs Team B, 2-1', teams: [team1, team2])
  Match.create(date: Date.yesterday, result: 'Team A vs Team B, 3-3', teams: [team1, team2])
  Match.create(date: Date.tomorrow, result: 'Team A vs Team B, 1-0', teams: [team1, team2])

  TypePerformance.create(description: 'Run 10+ km')
  TypePerformance.create(description: 'Made 70+ % accurate passes')

  best_player = Player.first
  player2 = Player.find(2)
  player3 = Player.find(3)
  player6 = Player.find(6)
  best_player.mark_performance_in_match('Run 10+ km', Match.find(1).id)
  best_player.mark_performance_in_match('Run 10+ km', Match.find(2).id)
  best_player.mark_performance_in_match('Run 10+ km', Match.find(3).id)

  player2.mark_performance_in_match('Made 70+ % accurate passes', Match.find(1).id)
  player3.mark_performance_in_match('Made 70+ % accurate passes', Match.find(2).id)
  player6.mark_performance_in_match('Made 70+ % accurate passes', Match.find(3).id)

  Rails.logger.debug 'Seed data created successfully!'
end
