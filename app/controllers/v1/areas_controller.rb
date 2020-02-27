module V1
  class AreasController < ApplicationController
    def index
      areas = Area.all.order_asc
      render json: areas
    end
  end
end
