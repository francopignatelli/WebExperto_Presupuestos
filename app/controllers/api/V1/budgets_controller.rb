module Api
    module V1
      class BudgetsController < ApplicationController
        before_action :set_budget, only: %i[show update destroy]
        before_action :authenticate_request!

      # GET /api/v1/budgets
      def index
        budgets = current_user.budgets
        render json: { budgets: budgets }
      end

      # GET /api/v1/budgets/1
      def show
        render json: { budget: @budget }
      end

      # POST /api/v1/budgets
      def create
        @budget = Budget.new(budget_params)
        @budget.user = current_user

        if @budget.save
          render json: { budget: @budget }, status: :created
        else
          render json: { errors: @budget.errors }, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/budgets/1
      def update
        if @budget.update(budget_params)
          render json: { budget: @budget }, status: :ok
        else
          render json: { errors: @budget.errors }, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/budgets/1
      def destroy
        if @budget.lineitems.empty?
          @budget.destroy
          head :no_content
        else
          @budget.lineitems.each(&:destroy)
          @budget.destroy
          head :no_content
        end
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
            debugger
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