require 'spec_helper'
require 'rspec'
require 'kele'

RSpec.describe Kele do
  describe "initialize" do
    it 'authorizes', :vcr do
      kele = Kele.new("blairlunceford@gmail.com", "Cardinals09")
      response = kele.authorize
      expect(response[:status]).to eq(200)
    end

    it 'detects invalid email', :vcr do
      kele = Kele.new("example@example.com", "example")
      response = kele.authorize
      expect(response[:status]).to eq(404)
    end
  end

  describe "get_me" do
    it 'gets user info', :vcr do
      kele = Kele.new("blairlunceford@gmail.com", "Cardinals09")
      response = kele.get_me
      expect(response[:status]).to eq(200)
    end
  end

  describe "get_mentor_availability" do
    it 'gets mentor availability', :vcr do
      kele = Kele.new("blairlunceford@gmail.com", "Cardinals09")
      response = kele.get_mentor_availability(38)
      expect(response[:status]).to eq(200)
    end
  end

  describe "roadmap" do
    it 'gets roadmap', :vcr do
      kele = Kele.new("blairlunceford@gmail.com", "Cardinals09")
      response = kele.get_roadmap(31)
      expect(response[:status]).to eq(200)
    end

    it 'gets checkpoint', :vcr do
      kele = Kele.new("blairlunceford@gmail.com", "Cardinals09")
      response = kele.get_checkpoint(99)
      expect(response[:status]).to eq(200)
    end
  end

  describe "messages" do
    it 'gets messages', :vcr do
      kele = Kele.new("blairlunceford@gmail.com", "Cardinals09")
      response = kele.get_messages(2)
      expect(response[:status]).to eq(200)
    end
  end
end
