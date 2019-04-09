class ProductsController < ApplicationController
  before_action :find_id_product, only: [:update, :edit, :destroy]
  def index
    @products = Product.all
    @categories = Category.all
  end

  def new
    @product = Product.new
    @categories = Category.all
  end

#   def create
#     @product = Product.new(product_params)
#     if @product.save
#       redirect_to products_path
#     else
#       render :new
#     end
#   end
# ​
# private
#   def product_params
#     params.require(:product).permit(:name, :price)
#   end
def create
  categories = params[:product][:category_id].map(&:to_i)
  @product = Product.new(product_params)
  categories.each do |category|
    category = Category.find(category)
    @product.categories << category
  end

  if @product.save
    redirect_to products_path
  else
    render :new
  end
end

def update
  #@product = Product.find(params[:id])
  params[:product][:category_id] ||= []
  @product.category_ids=params[:product][:category_id]
   if @product.update_attributes(product_params)
     redirect_to products_path
   else
     render :edit
   end
end

def edit
    #@product = Product.find(params[:id])
    @categories = Category.all
end

def destroy
    #@product = Product.find(params[:id])
    @product.destroy
    redirect_to products_path
end
private

def category_id_integer
    params[:product][:category_id] = params[:product][:category_id].map(&:to_i)
end

def product_params
    params.require(:product).permit(:name, :price)
end

def find_id_product
    @product = Product.find(params[:id])
end

end
