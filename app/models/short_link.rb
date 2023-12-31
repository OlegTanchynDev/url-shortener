# frozen_string_literal: true

class ShortLink < ApplicationRecord
  validates :original_url, uniqueness: true
  validates :short_url, uniqueness: true
  validates :password, presence: true

  default_scope -> { order(id: :asc) }
end
