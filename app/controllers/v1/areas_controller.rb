module V1
  class AreasController < ApplicationController
    def index
      areas = Area.all.order_asc
      render_collection_serializer(areas, AreaSerializer)
    end
  end
end
