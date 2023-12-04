class BudgetsController < ApplicationController
  before_action :set_budget, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /budgets or /budgets.json
  def index
    @budgets = current_user.budgets
    if params[:search]
      @budgets = Budget.joins(lineitems: :product).where('lower(budgets.name) LIKE ? OR lower(products.name) LIKE ?',
      "%#{params[:search].downcase}%", "%#{params[:search].downcase}%").distinct
    else
      @budgets = Budget.all
    end
  end

  # GET /budgets/1 or /budgets/1.json
  def show
  end

  # GET /budgets/new
  def new
    @budget = Budget.new
  end

  # GET /budgets/1/edit
  def edit
    @budget = Budget.find(params[:id])
    @total_price = total(@budget)
  end

  # POST /budgets or /budgets.json
  def create
    @budget = Budget.new(budget_params)
    @budget.user = current_user
    
    respond_to do |format|
      if @budget.save
        format.html { redirect_to budgets_url, notice: "Budget was successfully created." }
        format.json { render :index, status: :created, location: @budget }
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
        format.html { redirect_to budgets_url, notice: "Budget was successfully updated." }
        format.json { render :show, status: :ok, location: @budget }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @budget.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /budgets/1 or /budgets/1.json
  def destroy
    if @budget.lineitems.empty?
      @budget.destroy
      message = "Presupuesto eliminado exitosamente."
    else
      @budget.lineitems.destroy_all
      @budget.destroy
      message = "Presupuesto y sus elementos eliminados exitosamente."
    end
  
    respond_to do |format|
      format.html { redirect_to budgets_url, notice: message }
      format.json { head :no_content }
    end
  end

  def total(budget)
    total = 0
    budget.lineitems.each do |lineitem|
      total += (lineitem.quantity * lineitem.product.price)
    end
    total
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
end
