class Admin::ProductsController < Admin::BaseController

  before_action :set_product, only: %i[edit update destroy]

  def index
    @pagy, @products = pagy(Product.includes(:category).order(created_at: :desc))
  end

  def new
    @product = Product.new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(
      :category_id,
      :name,
      :description,
      :price,
      :sku,
      :stock,
      :status,
      images: []
    )
  end

end