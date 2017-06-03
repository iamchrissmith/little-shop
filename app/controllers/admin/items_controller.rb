class Admin::ItemsController < Admin::BaseController
  before_action :set_user, only: [:show, :edit, :update]

  def index
    @items = Item.all
  end

  def show; end

  def edit; end

  def update
    if @item.update(item_params)
      flash[:success] = "Item #{@item.id} Updated"
      redirect_to admin_items_path
    else
      render :edit
    end
  end

  private

  def set_user
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :price, :status)
  end

end