class ApartmentsController < ApplicationController

    def index 
        render json: Apartment.all, status: :ok 
    end 

    def show 
        apartment = Apartment.find_by(id: params[:id])
        if apartment.present?
            render json: apartment, status: :ok 
        else 
            render json: {error: "apartment not found"}, status: :not_found
        end 
    end 

    def update
        apartment = Apartment.find_by(id: params[:id])
        if apartment.present?
            apartment.update(apt_params)
            render json: apartment, status: :accepted 
        else 
            render json: {error: "update not accepted "}, status: :bad_request
        end
    end 


    def create 
        apartment = Apartment.create!(apt_params)
        render json: apartment, status: :created
    rescue ActiveRecord::RecordInvalid => e
        render json: {errors: e.record.errors.full_messages}, status: :unprocessable_entity
    end 


    def destroy 
        apartment = Apartment.find_by(id: params[:id])
        if apartment.present? 
            apartment.destroy
            head :no_content
        else 
            render json: {error: "apartment not found"}, status: :not_found
        end

    end 

    private 

    def apt_params 
        params.permit(:number)
    end 


end
