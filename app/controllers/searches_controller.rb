class SearchesController < ApplicationController
  
  def new
    @resources =  Search::RESOURCES.keys
  end

  def result
    @result = Search.search(search_params)
  end

  def search_params
    params.permit(:resources, :search, :commit, :controller, :action)
  end
end
