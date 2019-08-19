require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    # The new action will be used to display a new random grid and a form.
    # The form will be submitted (with POST) to the score action.
    @letters = create_grid(9)
  end

  def create_grid(grid_size)
    Array.new(grid_size) { ('a'..'z').to_a[rand(26)] }
  end
end

  def score
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    data = JSON.parse(open(url).read)
    @letters = params[:letters]
    word = params[:word]

    if word.split.all? { |letter| @letters.count(letter) >= word.count(letter) }
      if data['found'] == true
        @result = 'congratz'
        # @score += 1
      else
        @result = 'The word does not exist'
      end
    else
      @result = 'The word can\'t be processed'
     end
end
