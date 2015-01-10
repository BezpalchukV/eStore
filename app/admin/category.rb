ActiveAdmin.register Category do

  config.sort_order = 'position_asc'

  index do
    column :name
    column :position
    column 'Change position' do |category|
      link_to('Up', change_category_position_path(category_id: category.id, move: 'up'), method: :post) +
          ' ' + link_to('Down',  change_category_position_path(category_id: category.id, move: 'down'), method: :post)
    end
    actions
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(permitted_params[:category])
    if @category.save
      redirect_to @category
    else
      render :new
    end
  end

  def edit
    @category = Product.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(permitted_params[:category])
      redirect_to @category
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

  permit_params :name, :position

end
