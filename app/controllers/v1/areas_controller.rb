module V1
  class AreasController < ApplicationController
    def index
      areas = Area.where('"order" > ?', 0).order_asc
      render json: areas
    end
  end
end
