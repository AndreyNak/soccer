# frozen_string_literal: true

class TypePerformance < ApplicationRecord
  has_many :performances

  validates :description, uniqueness: true
end
