class MassController < ApplicationController
  def index
    @body_index = Story.new
    if session[:result_id] == nil
      @result = nil
    else
      @result = Story.find(session[:result_id])
    end
  end

  def create
    @body_index = Story.new(story_params)
    respond_to do |format|
      if @body_index.save
        session[:result_id] = @body_index.id
        format.html { redirect_to :controller => 'mass', :action => 'index'}
        format.json { render action: 'index' }
      end
      
    end
  end

  def show
    @stories = Story.where(user_id: session[:user][:id])
  end
  
  def story_params
    params[:story][:result] = params[:story][:mass].to_f / params[:story][:height].to_f**2
    params.require(:story).permit(:mass, :height, :result, :user_id)
  end

  def logout

    session[:user] =  nil
    redirect_to "/"
  end
end
