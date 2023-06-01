class GenresController < ApplicationController
  validates :name, presence: true, uniqueness: true
end
