require 'spec_helper'
require 'rails_helper'

describe MoviesController do 
  describe 'Search movies by the same director' do
    it 'should be able to call Movie same_director' do
      expect(Movie).to receive(:similar_movies).with('Aladdin')
      get :same_director, { title: 'Aladdin' }
    end
  end
end