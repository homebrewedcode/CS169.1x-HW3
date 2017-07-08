class MoviesController < ApplicationController
    def index
        sort_order = params[:sort_by]
        @all_ratings = ['G','PG','PG-13','R']
        if params[:ratings]
           @checked_ratings = params[:ratings].keys
        else
            @checked_ratings = 'none'
        end
        
        if sort_order == 'title'
            @movies = Movie.order(title: :asc)
            @sorted_by = :title
        elsif sort_order == 'release_date'
            @movies = Movie.order(release_date: :asc)
            @sorted_by = :release_date
        else
            @movies = Movie.where("rating IN (?)", @checked_ratings)
            @sorted_by = :none
        end
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
    
    def sort_title
        @movies = Movie.order(:title)
        
    end
end