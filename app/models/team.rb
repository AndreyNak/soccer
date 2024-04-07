# frozen_string_literal: true

class Team < ApplicationRecord
  has_many :players
  has_and_belongs_to_many :matches
end
