
class UsersController < ApplicationController

  def show   #this is a user GET request
    user = User.find_by(id: params[:id])
    render json: user, include: :items
  end
end

 #whats items? (show/GET items)
#whats an idividual user



#   -since item is a child object of user it is considered
#   a nested resourse of user for routing purposes

