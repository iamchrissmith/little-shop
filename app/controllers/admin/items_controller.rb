class Admin::ItemsController < Admin::BaseController
  before_action :set_item, only: [:show, :edit, :update]

  def index
    @items = Item.all
  end

  def show; end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)

    if @item.save
      flash[:success] = "Item #{@item.id} Created"
      redirect_to admin_items_path
    else
      render :new
    end
  end

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

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :price, :status, :category_ids => [])
  end

end