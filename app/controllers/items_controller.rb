class ItemsController < ApplicationController
  # ログインしてなければ、ログイン画面へ
  before_action :authenticate_user!, only: [:new, :create, :edit]
  
  before_action :set_item, only: [:edit, :update, :show]
  before_action :move_to_index, only: [:edit]

  def index
    @items = Item.includes(:user).order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit
    end
  end

  private
  def set_item
    @item = Item.find(params[:id])
  end

  # 投稿者以外がeditアクションにアクセスしたらトップページにリダイレクト
  # user_signed_in?の記述はauthenticate_user!が行ってくれるためここでは不要
  def move_to_index
    unless current_user.id == @item.user_id
      redirect_to action: :index
    end
  end

  private
  def item_params
    params.require(:item).permit(
      :name, :image, :item_description, :category_id, :status_id, :ship_cost_id, :ship_days_id, :prefecture_id, :price
    ).merge(user_id: current_user.id)
  end
end
