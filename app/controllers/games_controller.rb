class GamesController < ApplicationController
  def new
    alphabet = ('A'..'Z').to_a
    @letters = []

    10.times do
      @letters << alphabet.sample
    end
  end

  def score
    @word = params[:word].upcase
    word_letters = @word.split('')
    @letters = params[:letters].split(' ')
    @check_letters = true

    word_letters.each do |letter|
      @check_letters = false unless @letters.include?(letter)
    end

    require 'json'
    require 'open-uri'

    url = "https://wagon-dictionary.herokuapp.com/#{@word.downcase}"
    results_serialized = URI.open(url).read
    results = JSON.parse(results_serialized)
    @found = results['found']
  end
end
