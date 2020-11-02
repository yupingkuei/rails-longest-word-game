require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << ('a'..'z').to_a.sample }
  end

  def score
    @letters = params[:list]
    @word = params[:word]
    if @word.chars.all? { |letter| @word.count(letter) > @letters.count(letter)}
      @output = "Sorry but #{@word} cannot be built out of #{@letters}..."
    elsif !validate(@word)
      @output = "Sorry but #{@word} does not seem to be valid English word......"
    else
      @output = "Congrats! #{@word} is a valid English word!"
    end
  end

  def validate(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    json = open(url).read
    @word_hash = JSON.parse(json)
    @word_hash['found']
  end

  def include_or_not?
    @word.split.map do |word|
      @letters.include?(word)
    end.all?(true)
  end
end
