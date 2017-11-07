class PetsController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    pets = Pet.all

    render(
      json: pets,
      status: :ok
    )
  end

  def show
    pet = Pet.find_by(id: params[:id])

    if pet
      render(
        json: pet, status: :ok
      )
    else
      render(
        json: {nothing: true}, status: :not_found
      )
    end
  end

  def create
    pet = Pet.new(pet_params)

    if pet.save
      render(
        json: {id: pet.id}, status: :ok
      )
    else
      render(
        json: {errors: pet.errors.messages}, status: :bad_request
      )
    end
  end



 private

 def pet_params
   params.require(:pet).permit(:name, :age, :human)
 end



end
