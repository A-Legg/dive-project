class Api::V1::DivesController < ApplicationController
	respond_to :json 

	def show 
		respond_with Dive.find(params[:id])
	end

	def index 
		respond_with Dive.all
	end

	def create
    	dive = current_user.dives.build(dive_params)
    if dive.save
      render json: dive, status: 201, location: [:api, dive]
    else
      render json: { errors: dive.errors }, status: 422
    end
  end

  def update
    dive = current_user.dives.find(params[:id])
    if dive.update(dive_params)
      render json: dive, status: 200, location: [:api, dive]
    else
      render json: { errors: dive.errors }, status: 422
    end
  end

  def destroy
    dive = current_user.dives.find(params[:id])
    dive.destroy
    head 204
  end

  private

    def dive_params
      params.require(:dive).permit(:location, :date, :length)
    end
 end

