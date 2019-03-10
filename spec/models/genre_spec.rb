require 'rails_helper'

RSpec.describe Genre, type: :model do
  context 'create new genre' do

    let(:newGenre) { Genre.new }

    it 'should exists books_genre_id' do
      expect(newGenre).to be_invalid
    end

    it 'should exists books_genre_name' do
      expect(newGenre).to be_invalid
    end
  end
end
