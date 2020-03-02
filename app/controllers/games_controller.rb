# frozen_string_literal: true

require 'net/http'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
    @word = params[:word]
  end

  # def parsing
  #   @word = params[:word]
  #   # binding.pry
  #   url = "https://wagon-dictionary.herokuapp.com/#{@word}"
  #   uri = URI(url)
  #   response = Net::HTTP.get(uri)
  #   result = JSON.parse(response)
  #   @exist = result['found']
  #   @length = result['length']
  # end


  def score
    @word = params[:word]
    @letters = params[:letters]
    # binding.pry
    url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    result = JSON.parse(response)
    @exist = result['found']
    @length = result['length']
    @same = @word.chars.all? { |letter| @word.count(letter) <= @letters.count(letter) }

    if !@same
      if @exist
        @result = "Nice Word. Your score is #{@length}"
      else
        @result = "It's not an english word"
      end
    else
      @result = 'You didnt take the rigth letters !'
    end
  end
end

# if @exist
#   @result = "Nice Word. Your score is #{@length}"
#   @result
# elsif !included?(@word, @letters)
#   @result = 'You didnt take the rigth letters !'
#   @result
# else
#   @result = 'Your word is not an english-word!'
#   @result
# end
