module V1
  class SpotsController < ApplicationController
    before_action :set_spot, only: %i[show]

    def show
      render_serializer(@spot, SpotSerializer)
    end

    private

      def set_spot
        @spot = Spot.find(params[:id])
      end
  end
end
