#!/usr/bin/env ruby
# frozen_string_literal: true

require 'colorize'
require './deck.rb'
require "espeak"
require 'marky_markov'

class Game
  attr_reader :markov

  def initialize
    @markov = MarkyMarkov::TemporaryDictionary.new
  end

  def deck
    @deck ||= Deck.new
  end

  def questions
    deck.questions
  end

  def answers
    deck.answers
  end

  def markov_answer
    markov.generate_n_words(8)
  end

  def display
    question = questions.sample.to_s
    puts "\e[H\e[2J"
    puts %(
    Problem: #{question.green}
    Solution #1: #{markov_answer.red}
    Solution #2: #{markov_answer.blue}



    )
    ESpeak::Speech.new(question, voice: "en", pitch: 80).speak
  end
end

game = Game.new
game.markov.parse_file('answers.tsv')

while 2016 > 1984 do
  game.display
  sleep 2
end
