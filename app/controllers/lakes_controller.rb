class LakesController < ApplicationController
  before_action :authenticate_user!,  only: %i[ create edit update destroy ]
  before_action :set_lake, only: %i[ show edit update destroy ]

  # GET /lakes or /lakes.json
  def index
    @lakes = Lake.all.paginate(page: params[:page], per_page: 6)
  end

  # GET /lakes/1 or /lakes/1.json
  def show
    @lake = Lake.find(params[:id])
  end

  # GET /lakes/new
  def new
    @lake = Lake.new
  end

  # GET /lakes/1/edit
  def edit
  end

  # POST /lakes or /lakes.json
  def create
    @lake = Lake.new(lake_params)

    respond_to do |format|
      if @lake.save
        format.html { redirect_to @lake, notice: "Lake was successfully created." }
        format.json { render :show, status: :created, location: @lake }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @lake.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lakes/1 or /lakes/1.json
  def update
    respond_to do |format|
      if @lake.update(lake_params)
        format.html { redirect_to @lake, notice: "Lake was successfully updated." }
        format.json { render :show, status: :ok, location: @lake }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @lake.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lakes/1 or /lakes/1.json
  def destroy
    @lake.destroy!

    respond_to do |format|
      format.html { redirect_to lakes_path, status: :see_other, notice: "Lake was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def check_existence
    @lake = Lake.find_by(name: params[:name])
    if @lake
      render json: { exists: true, id: @lake.id }
    else
      render json: { exists: false }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lake
      @lake = Lake.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def lake_params
      params.require(:lake).permit(:name, :description)
    end
end
