module Api
  module V1
    class CategoriesController < ApplicationController

      respond_to :json

      def index
        duplicate_categories = category_params[:ids]
        all_categories = Category.all

        respond_with all_categories.where.not(id: duplicate_categories)
      end

      rescue_from ActionController::UnknownFormat do |e|
        render json: {error: e.message}.to_json, status: :not_acceptable
      end

      private

      def category_params
        params.permit(:format, {ids: []})
      end

    end
  end
end