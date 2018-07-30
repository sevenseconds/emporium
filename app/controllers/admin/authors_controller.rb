class Admin::AuthorsController < ApplicationController

  def index
    @authors = Author.all
  end

  def new
    @author = Author.new
  end

  def create
    @author = Author.new(author_params)
    if @author.save
      flash[:success] = "Author #{@author.name} was successfully created."
      redirect_to admin_authors_path
    else
      render 'new'
    end
  end

  def edit
    @author = Author.find(params[:id])
  end

  def update
    @author = Author.find(params[:id])
    if @author.update(author_params)
      flash[:success] = 'Author was successfully updated.'
      redirect_to admin_author_path(@author)
    else
      render 'edit'
    end
  end

  def show
    @author = Author.find(params[:id])
    @page_title = @author.name
  end

  def destroy
    @author = Author.find(params[:id])
    @author.destroy
    flash[:success] = "Successfully deleted author #{@author.name}"
    redirect_to admin_authors_path
  end

  private

  def author_params
    params.require(:author).permit(:first_name, :last_name)
  end
end
