# frozen_string_literal: true

require "securerandom"
require_relative "token/version"

module Readable
  # This module provides functionality for generating readable random tokens
  # and calculating the number of possible token variations based on rules.
  module Token
    class Error < StandardError; end

    DEFAULT_CHARSET = ("A".."Z").to_a + ("2".."9").to_a - %w[O I L]

    def self.generate(length: 8, allow_letters: true, allow_numbers: true)
      raise Error, "At least one of allow_letters or allow_numbers must be true" unless allow_letters || allow_numbers

      charset = build_charset(allow_letters, allow_numbers)
      Array.new(length) { charset[SecureRandom.random_number(charset.size)] }.join
    end

    def self.variations(length: 8, allow_letters: true, allow_numbers: true)
      raise Error, "At least one of allow_letters or allow_numbers must be true" unless allow_letters || allow_numbers

      charset = build_charset(allow_letters, allow_numbers)
      charset.size**length
    end

    def self.build_charset(allow_letters, allow_numbers)
      charset = []
      charset += ("A".."Z").to_a if allow_letters
      charset += ("2".."9").to_a if allow_numbers
      charset -= %w[O I L]
      charset
    end
  end
end
