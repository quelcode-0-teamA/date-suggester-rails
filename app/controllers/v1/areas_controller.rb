module V1
  class AreasController < ApplicationController
    def index
      render json: Area.with_active
    end
  end
end
