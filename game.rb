#!/usr/bin/env ruby
# frozen_string_literal: true

require 'colorize'
require_relative 'deck'

class Game
  def deck
    @deck ||= Deck.new
  end

  def questions
    deck.questions
  end

  def answers
    deck.answers
  end

  def cards_in_round
    first_answer = answers.sample
    second_answer = (answers - [first_answer]).sample
    [questions.sample, first_answer, second_answer]
  end

  def display
    puts "\e[H\e[2J"
    puts %(
    Question is: #{cards_in_round.first.to_s.green}
    1st Solution: #{cards_in_round[1].to_s.red}
    2nd Solution: #{cards_in_round[2].to_s.blue}



    )
  end
end

game = Game.new

game.display
while (user_input = gets.chomp)
  case user_input
  when 'end'
    break
  else
    game.display
  end
end
