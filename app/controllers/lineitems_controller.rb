class LineitemsController < ApplicationController
  before_action :set_lineitem, only: %i[ show edit update destroy ]

  # GET /lineitems or /lineitems.json
  def index
    @lineitems = Lineitem.all
  end

  # GET /lineitems/1 or /lineitems/1.json
  def show
  end

  # GET /lineitems/new
  def new
    @budget = Budget.find(params[:budget_id])
    @lineitem = @budget.lineitems.new
  end

  # GET /lineitems/1/edit
  def edit
  end

  # POST /lineitems or /lineitems.json
  def create
    @lineitem = Lineitem.find_by(budget_id: lineitem_params[:budget_id], product_id: lineitem_params[:product_id])

    if @lineitem.nil?
      @lineitem = Lineitem.build(lineitem_params)
    else
      new_quantity = @lineitem.quantity + lineitem_params[:quantity].to_i
      @lineitem.quantity = new_quantity
    end

    respond_to do |format|
      if @lineitem.save
        format.html { redirect_to edit_budget_path(@lineitem.budget), notice: t('lineitem.success') }
        format.json { render :show, status: :created, location: @lineitem }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @lineitem.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lineitems/1 or /lineitems/1.json
  def update
    respond_to do |format|
      if @lineitem.update(lineitem_params)
        format.html { redirect_to lineitem_url(@lineitem), notice: "Lineitem was successfully updated." }
        format.json { render :show, status: :ok, location: @lineitem }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @lineitem.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lineitems/1 or /lineitems/1.json
  def destroy
    @lineitem.destroy!

    respond_to do |format|
      format.html { redirect_to edit_budget_path(@lineitem.budget), notice: "Product was successfully unassigned." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lineitem
      @lineitem = Lineitem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def lineitem_params
      params.require(:lineitem).permit(:quantity, :product_id, :budget_id)
    end
end
