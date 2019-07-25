class ProductsController < ApplicationController
  load_and_authorize_resource
  before_action :set_product, only: %i[show edit update destroy remove_attachment]
  before_action :authenticate_user!, except: %i[index show search]

  # GET /products
  # GET /products.json

  def search
    @products = if params[:search].present?
                  Product.search(params[:search])
                else
                  Product.all
                end
  end

  def index
    session[:some_key] = 'some_value'
    @products = Product.all
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @reviews = @product.reviews.order(created_at: :desc)
  end

  # GET /products/new
  def new
    @product = current_user.products.build
  end

  # POST /products
  # POST /products.json
  def create
    @product = current_user.products.build(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product created.' }
        format.js
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product destroyed.' }
      format.json { head :no_content }
    end
  end

  def remove_attachment
    @img = @product.images.find(params[:img])
    @img.purge
    redirect_to @product
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:title, :description,
                                    :price, :quantity, images: [])
  end
end
