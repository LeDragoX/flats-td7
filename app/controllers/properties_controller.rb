class PropertiesController < ApplicationController
    before_action :authenticate_property_owner!, only: [:new, :create, :edit, :update, :destroy]

    def show
        @property = Property.find(params[:id])
        @property_reservation = PropertyReservation.new()
    end
    
    def new
        @property = Property.new()
    end

    def create
        @property = Property.new(property_params)
        @property.property_owner = current_property_owner

        if @property.save
            redirect_to @property
        else
            render :new
        end
    end

    def my_properties
        @properties = current_property_owner.properties
    end

    def edit
        @property = Property.find(params[:id])
    end

    def update
        @property = Property.find(params[:id])

        if @property.update(property_params)
            redirect_to @property
        else
            render :edit
        end
    end
    
    def destroy
        @property = Property.find(params[:id])

        if @property.destroy
            redirect_to my_properties_properties_path
        else

        end
    end
    
    private

    def property_params
        params.require(:property).permit(:title, :description, :rooms,
                                         :parking_slot, :bathrooms, :pets,
                                         :daily_rate, :property_type_id)
    end

end