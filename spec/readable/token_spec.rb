# frozen_string_literal: true

RSpec.describe Readable::Token do
  it "has a version number" do
    expect(Readable::Token::VERSION).not_to be nil
  end

  describe ".generate" do
    it "generates a token with the default length of 8" do
      token = Readable::Token.generate
      expect(token.length).to eq(8)
    end

    it "generates a token with a custom length" do
      token = Readable::Token.generate(length: 12)
      expect(token.length).to eq(12)
    end

    it "generates a token with only letters" do
      token = Readable::Token.generate(allow_letters: true, allow_numbers: false)
      expect(token).to match(/\A[A-Z]+\z/)
    end

    it "generates a token with only numbers" do
      token = Readable::Token.generate(allow_letters: false, allow_numbers: true)
      expect(token).to match(/\A[2-9]+\z/)
    end

    it "raises an error if neither letters nor numbers are allowed" do
      expect do
        Readable::Token.generate(allow_letters: false, allow_numbers: false)
      end.to raise_error(Readable::Token::Error)
    end
  end

  describe ".variations" do
    it "calculates the number of variations with default settings" do
      variations = Readable::Token.variations
      expect(variations).to eq((31**8))
    end

    it "calculates the number of variations for custom length" do
      variations = Readable::Token.variations(length: 10)
      expect(variations).to eq((31**10))
    end

    it "calculates the number of variations with only letters" do
      variations = Readable::Token.variations(allow_letters: true, allow_numbers: false)
      expect(variations).to eq((23**8)) # Letters excluding O, I, L
    end

    it "calculates the number of variations with only numbers" do
      variations = Readable::Token.variations(allow_letters: false, allow_numbers: true)
      expect(variations).to eq((8**8)) # Numbers excluding 0 and 1
    end

    it "raises an error if neither letters nor numbers are allowed" do
      expect do
        Readable::Token.variations(allow_letters: false, allow_numbers: false)
      end.to raise_error(Readable::Token::Error)
    end
  end
end
