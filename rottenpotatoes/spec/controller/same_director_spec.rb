require 'rails_helper'

describe MoviesController do 
  describe 'find movies with same director' do
    before :each do
      @the_shawshank_redemption = FactoryGirl.create(:movie)
      @ready_player_one = FactoryGirl.create(:movie, title: 'Ready Player One', director: 'Steven Spielberg')
      @the_terminal = FactoryGirl.create(:movie, title: 'The Terminal', director: 'Steven Spielberg')
    end

    context 'when the specified movie has a director' , :type => :controller do
      it 'makes similar movies available to the template' do
        get :same_director, id: @ready_player_one
        expect(assigns(:movies)).to contain_exactly @ready_player_one, @the_terminal
      end

      it 'renders the :similar view' do
        get :same_director, id: @ready_player_one
        expect(response).to render_template :same_director
      end
    end

    context 'when the specified movie has no director' , :type => :controller do
      it 'leaves a notice' do
        movie = FactoryGirl.create(:movie, director: '')
        get :same_director, id: movie
        expect(flash[:notice]).to eq "'#{movie.title}' has no director information listed!"
      end

      it 'redirects to the home page' do
        movie = FactoryGirl.create(:movie, director: '')
        get :same_director, id: movie
        expect(response).to redirect_to movies_path
      end
    end
  end
end