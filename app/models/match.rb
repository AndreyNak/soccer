# frozen_string_literal: true

class Match < ApplicationRecord
  has_many :performances

  has_and_belongs_to_many :teams

  has_many :players, through: :teams
end
