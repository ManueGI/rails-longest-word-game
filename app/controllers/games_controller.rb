require "json"
require "open-uri"

class GamesController < ApplicationController


  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score

    url = "https://wagon-dictionary.herokuapp.com/#{params[:scrabble]}"
    @words = URI.open(url).read
    @guess = JSON.parse(@words)

    @result = @guess['word']
    @letters = params[:list].split(" ")
    @scrabbles = params[:scrabble].split("")

    if @guess['found'] == false
      @answer = "Sorry but #{params[:scrabble]} does not seem to be a valid word in english ..."
      @score = 0
    else
      @scrabbles.each do |scrabble| 
        if @letters.include?(scrabble.upcase) == false
          @answer = "Sorry but #{params[:scrabble]} can't be built out of #{@letters.join(",")}"
          @score = 0
        else
          @answer = "Congratulation #{params[:scrabble]} is a valid English word !"
          @score = @scrabbles.length
        end
      end
    end
  end
end
