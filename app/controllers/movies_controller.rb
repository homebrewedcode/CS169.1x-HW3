class MoviesController < ApplicationController
    def index
        unless params[:sort_by].nil?
            session[:sort_by] = params[:sort_by]
        end
        @all_ratings = ['G','PG','PG-13','R']
        
        if params[:ratings]
           @checked_ratings = params[:ratings].keys
        else
            if session[:checked_ratings].nil?
                @checked_ratings = @all_ratings
            else
                @checked_ratings = session[:checked_ratings]
            end
        end
        session[:checked_ratings] = @checked_ratings
        
        if session[:sort_by] == 'title'
            @movies = Movie.where("rating IN (?)", @checked_ratings).order(title: :asc)
            @sorted_by = :title
            
        elsif session[:sort_by] == 'release_date'
            @movies = Movie.where("rating IN (?)", @checked_ratings).order(release_date: :asc)
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