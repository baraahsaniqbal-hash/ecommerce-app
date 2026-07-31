class Admin::ProductsController < Admin::BaseController

  before_action :set_product, only: %i[edit update destroy]
  before_action :set_products , only: %i[ index create update destroy]
  before_action :set_pagy, only: %i[ create update destroy]
  def index
    
    @pagy, @products = pagy(@products, limit: 5)

    respond_to do |format|
      format.html
      format.js
    end

  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        flash.now[:notice] = "Product created successfully."
        format.js
      else
        format.js
      end
    end
  end

  def edit
  end

  def update

    respond_to do |format|
      if @product.update(product_params)
        flash.now[:notice] = "Product updated successfully."
        format.js
      else
        format.js
      end
    end
  end

  def destroy
    
    @product.destroy
    respond_to do |format|
      flash.now[:notice] = "Product deleted successfully."
      format.js
    end

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

  def set_products
    @products =     @products =  Product
                .includes(:category)
                .search(params[:search])
                .filter_by_status(params[:status])
                .filter_by_category(params[:category_id])
                .sorted(params[:sort])
  end

  def set_pagy
    @pagy, @products = pagy(@products, limit: 5)
  end

end