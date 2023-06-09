class ListsController < ApplicationController
  def index
    @lists = List.all
  end

  def show
    @list = List.find(params[:id])
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(params_list)
    if @list.save
      redirect_to lists_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @list = List.find(params[:id])
    @list.photo.purge
    @list.destroy
    redirect_to lists_path, status: :see_other
  end

  private

  def params_list
    params.require(:list).permit(:name, :photo)
  end
end
