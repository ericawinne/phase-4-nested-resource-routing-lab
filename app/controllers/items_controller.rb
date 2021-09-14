
class ItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  # def index    #this is items GET request
  #   items = Item.all
  #   render json: items, include: :user #this returns an array of all items belonging to a user
  # end

  def index #needs the if/else here bc renders different sets of reviews depending on the path
    if params[:user_id]
      user = find_user
      items = user.items
    else
      items = Item.all
    end
    render json: items, include: :user
  end

  #what is an item #match/param according to id in URL
  def show
    item = find_item
    render json: item
  end

  def create
    user = find_user
    item = user.items.create(item_params)
    render json: item, status: :created
  end
  
  private

  def find_item
    Item.find(params[:id])
  end

  def find_user
    User.find(params[:user_id])
  end

  def item_params
    params.permit(:name, :description, :price)
  end

  def render_not_found_response(exception)
    render json: { error: "#{exception.model} not found" }, status: :not_found
  end

end



















# class ItemsController < ApplicationController
#   rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response



  



  

# here we added a condition to the items#index action
# to account for whether the client/fronend-user is trying 
# to access the index of all items (Items.all) 
# or just the index of all items for a certain user (user.items).



