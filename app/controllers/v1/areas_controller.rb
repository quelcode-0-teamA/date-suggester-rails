module V1
  class AreasController < ApplicationController
    def index
      render json: Area.with_active.order(:order)
    end
  end
end
