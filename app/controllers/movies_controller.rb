class MoviesController < ApplicationController
    def index
        @movies = Movie.all
    end
    
    def show
        id = params[:id]
        @movie = Movie.find(id)
    end
    
    def new
        @movie = Movie.new
    end
    
    def create 
        params.require(:movie)
        permitted = params[:movie].permit(:title, :rating, :release_date)
        @movie = Movie.create!(permitted)
        flash[:notice] = "#{@movie.title} was successfully created"
        redirect_to movies_path
    end
    
    def edit
        @movie = Movie.find params[:id]
    end
    
    def update
        @movie = Movie.find params[:id]
        permitted = params[:movie].permit(:title, :rating, :release_date)
        @movie.update_attributes!(permitted)
        flash[:notice] = "#{@movie.title} updated successfully"
        redirect_to movies_path
    end
    
    def destroy
        @movie = Movie.find(params[:id])
        @movie.destroy
        flash[:notice] = "Movie #{@movie.title} successfully deleted"
        redirect_to movies_path
    end
end