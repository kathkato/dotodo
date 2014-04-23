module Api
  module V1
    class TasksController < ApplicationController
      
      respond_to :json
    
      def index
        
        duplicate_tasks = task_params[:ids]
        cat_tasks = task_params[:catid]
        category_tasks = Task.where("category_id = ?", cat_tasks)

        respond_with category_tasks.where.not(id: duplicate_tasks)
        
      end
      
      def complete
        
        @task = Task.find(params[:id])
        @task.completion_date = Time.zone.now
        
        if @task.save
          respond_with @task
        else
          respond_with @task.errors, status: :unprocessable_entity
        end
      end
      
      rescue_from ActiveRecord::RecordNotFound do |e|
        render json: {error: e.message}.to_json, status: :not_acceptable
      end
      
      rescue_from ActionController::UnknownFormat do |e|
        render json: {error: e.message}.to_json, status: :not_acceptable
      end
      
      private

        def task_params
          params.permit(:catid, :format, {ids: []})
        end
      
    end
  end
end