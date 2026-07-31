class Admin::CategoriesController < Admin::BaseController

  before_action :set_category, only: %i[ edit update destroy]
  before_action :set_categories, only: %i[ index create update destroy]
  before_action :set_pagy, only: %i[ create update destroy]
  def index

    if params[:search].present?
      @categories = @categories.where(
      "LOWER(name) LIKE ?",
      "%#{params[:search].downcase}%"
      )
    end

    if params[:status].present?
      @categories = @categories.where(status: params[:status])
    end

    case params[:sort]
      when "oldest"
        @categories = @categories.reorder(created_at: :asc)

      when "name_asc"
        @categories = @categories.reorder(name: :asc)

      when "name_desc"
        @categories = @categories.reorder(name: :desc)

      else
        @categories = @categories.reorder(created_at: :desc) # Newest First
    end

    @pagy, @categories = pagy(@categories, limit: 5)

    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @category = Category.new
  end

  def create

    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        flash.now[:notice] = "Category created successfully."
        format.js
        format.html {redirect_to admin_categories_path, notice: "Category created successfully."}
      else
        format.js
        format.html{render :new}
      end
    end
  end

  def edit 
  end

  def update

    respond_to do |format|
      if @category.update(category_params)
        flash.now[:notice] = "#{@category.name} updated successfully."
        format.js
      else
        format.js
      end
    end

  end

  def destroy
    @category.destroy
    flash.now[:notice] = "#{@category.name} deleted successfully."
    respond_to do |format|
      format.js
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :status)
  end

  def set_category
    @category = Category.find(params[:id])
  end

  def set_categories
    @categories = Category.order(created_at: :desc)
  end

  def set_pagy
    @pagy, @categories = pagy(@categories, limit: 5)
  end
  
end
