module Api
    module V1
      class BudgetsController < ApplicationController
        before_action :set_budget, only: %i[show]
        # before_action :authenticate_request!

      # GET /api/v1/budgets
      def index
        @budgets = Budget.all.includes(:lineitems)


        render json: { budgets: @budgets.as_json(include: :lineitems)  }
      end

      # GET /api/v1/budgets/*params
      def show
        debugger
        @budgets = Budget.all.includes(:lineitems)

        # Filtrar por nombre si el parámetro :name está presente
        @budgets = @budgets.where(name: params[:name]) if params[:name].present?

        # Filtrar por la descripcion si el parámetro :description está presente
        @budgets = @budgets.where(description: params[:description]) if params[:description].present?

        render json: { budgets: @budgets.as_json(include: :lineitems)  }
      end

      private

      def set_budget
        @budget = Budget.find(params[:id])
      end

      def budget_params
        params.require(:budget).permit(:description, :name, :user_id, lineitems_attributes: [:id, :quantity, :product_id, :_destroy])
      end

      def authenticate_request!
        if request.headers['Authorization'].present?
            token = request.headers['Authorization'].gsub('Bearer ', '')
            decoded_token = JsonWebToken.decode(token)

            unless decoded_token
                render json: { error: 'en if' }, status: :unauthorized
            end
        else
            # token = request.headers['Authorization']&.split(' ')&.last
            render json: { error: 'en else' }, status: :unauthorized
        end
      end
    end
  end
end