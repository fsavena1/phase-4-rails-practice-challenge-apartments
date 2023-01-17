class TenantsController < ApplicationController

    def index
        render json: Tenant.all, status: :ok
    end 


    def show 
        tenant = tenant_find
        if tenant.present? 
            render json: tenant, include: :leases, status: :ok
        else 
            render_not_found_response
        end
    end 



    def update 
        tenant = tenant_find
            tenant.update!(tenant_params)
            render json: tenant , status: :accepted
    rescue ActiveRecord::RecordInvalid => e 
        render json: {errors: e.record.errors.full_messages}, status: :unprocessable_entity
    end 



    def create 
        tenant = Tenant.create!(tenant_params)
        render json: tenant, status: :created
    rescue ActiveRecord::RecordInvalid => e 
        render json: {errors: e.record.errors.full_messages}, status: :unprocessable_entity
    end 



    def destroy 
        tenant = tenant_find
        if tenant.present?
            tenant.destroy
             head :no_content
        else 
            render_not_found_response
        end
    end 


    private 

    def tenant_params 
        params.permit(:name, :age)
    end 

    def tenant_find
        Tenant.find_by(id: params[:id])
    end 

    def render_not_found_response
        render json: { error: "Tenant not found" }, status: :not_found
    end


end
