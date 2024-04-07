# frozen_string_literal: true

class Performance < ApplicationRecord
  belongs_to :player
  belongs_to :type_performance
  belongs_to :match
end
