# frozen_string_literal: true

require 'csv'

class Deck
  Statement = Struct.new(:text) do
    def to_s
      text
    end
  end

  def questions
    @questions ||= CSV.read('questions.tsv', col_sep: '\t').map { |q| Statement.new(q.first) }
  end
end
