class BudgetsController < ApplicationController
  before_action :set_budget, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /budgets or /budgets.json
  def index
    @budgets = current_user.budgets
  end

  # GET /budgets/1 or /budgets/1.json
  def show
  end

  # GET /budgets/new
  def new
    @budget = Budget.new
    @budget.lineitems.build unless @budget.lineitems.present?
  end

  # GET /budgets/1/edit
  def edit
    @budget = Budget.find(params[:id])
    @budget.lineitems.build unless @budget.lineitems.present?
  end

  # POST /budgets or /budgets.json
  def create
    @budget = Budget.new(budget_params)
    @budget.user = current_user
  
    respond_to do |format|
      if @budget.save
        format.html { redirect_to budget_url(@budget), notice: "Budget was successfully created." }
        format.json { render :show, status: :created, location: @budget }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @budget.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /budgets/1 or /budgets/1.json
  def update
    respond_to do |format|
      if @budget.update(budget_params)
        format.html { redirect_to budget_url(@budget), notice: "Budget was successfully updated." }
        format.json { render :show, status: :ok, location: @budget }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @budget.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /budgets/1 or /budgets/1.json
  def destroy
    @budget.destroy!

    respond_to do |format|
      format.html { redirect_to budgets_url, notice: "Budget was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_budget
      @budget = Budget.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def budget_params
      params.require(:budget).permit(:description, :name, :user_id, lineitems_attributes: [:id, :quantity, :product_id, :_destroy])
    end
  
    def budget_params
      params.require(:budget).permit(:name, :description, lineitems_attributes: [:id, :product_id, :quantity, :_destroy])
    end
end
