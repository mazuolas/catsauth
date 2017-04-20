class CatsController < ApplicationController
  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find(params[:id])
    render :show
  end

  def new
    unless current_user
      flash[:errors] = ["log in fool"]
      redirect_to new_sessions_url
    else
      @cat = Cat.new
      render :new
    end
  end

  def create

    @cat = Cat.new(cat_params)
    @cat.user_id = current_user.id

    if @cat.save
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :new
    end
  end

  def edit
    @cat = Cat.find(params[:id])
    if @cat.owner == current_user
      render :edit
    else
      flash[:errors] = ["you can't edit cats that dont love you"]
      redirect_to cat_url(@cat)
    end
  end

  def update
    @cat = Cat.find(params[:id])
    unless @cat.owner == current_user
      redirect_to cat_url(@cat)
      flash[:errors] = ["you can't update cats that dont love you"]
      return
    end
    
    if @cat.update_attributes(cat_params)
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :edit
    end
  end

  private

  def cat_params
    params.require(:cat)
      .permit(:age, :birth_date, :color, :description, :name, :sex)
  end
end
