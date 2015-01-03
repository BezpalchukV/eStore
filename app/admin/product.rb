ActiveAdmin.register Product do

  form multipart: true do |f|
    f.inputs 'Product' do
      f.input :name
      f.input :description
      f.input :quantity
      f.input :price
      f.input :categories, as: :check_boxes
      # f.input :photo, required: false
    end
    f.actions
  end

  index do
    column :name
    column :description
    column :quantity
    column :price do |product|
      number_to_currency product.price
    end
    actions
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(permitted_params[:product])
    if @product.save
      redirect_to @product
    else
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(permitted_params[:product])
      redirect_to @product
    else
      render :new
    end
  end

  def destroy
  end

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end

  permit_params :name, :description, :price, :quantity, category_ids: []

end
