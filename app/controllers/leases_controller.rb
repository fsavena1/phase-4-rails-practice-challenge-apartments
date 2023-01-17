class LeasesController < ApplicationController


    def create 
       lease =  Lease.create!(lease_params)
       byebug
        render json: lease, status: :created
    rescue ActiveRecord::RecordInvalid => e 
        render json: {errors: e.record.errors.full_messages}, status: :unprocessable_entity
    end 

    def destroy
        lease = Lease.find_by(id: params[:id])
        if lease.present?
            lease.destroy
            head :no_content
        else 
            render_not_found_response
        end
    end 

    private 

    def lease_params
        params.permit(:rent, :apartment_id, :tenant_id)
    end 

    def render_not_found_response
        render json: { error: "Tenant not found" }, status: :not_found
    end




end
