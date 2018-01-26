class CategoryProgramsController < ApplicationController
  before_action :set_category_program, only: [:show, :edit, :update, :destroy]

  # GET /category_programs
  # GET /category_programs.json
  def index
    @category_programs = CategoryProgram.all
  end

  # GET /category_programs/1
  # GET /category_programs/1.json
  def show
  end

  # GET /category_programs/new
  def new
    @category_program = CategoryProgram.new
  end

  # GET /category_programs/1/edit
  def edit
  end

  # POST /category_programs
  # POST /category_programs.json
  def create
    @category_program = CategoryProgram.new(category_program_params)

    respond_to do |format|
      if @category_program.save
        format.html { redirect_to @category_program, notice: 'Category program was successfully created.' }
        format.json { render :show, status: :created, location: @category_program }
      else
        format.html { render :new }
        format.json { render json: @category_program.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /category_programs/1
  # PATCH/PUT /category_programs/1.json
  def update
    respond_to do |format|
      if @category_program.update(category_program_params)
        format.html { redirect_to @category_program, notice: 'Category program was successfully updated.' }
        format.json { render :show, status: :ok, location: @category_program }
      else
        format.html { render :edit }
        format.json { render json: @category_program.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /category_programs/1
  # DELETE /category_programs/1.json
  def destroy
    @category_program.destroy
    respond_to do |format|
      format.html { redirect_to category_programs_url, notice: 'Category program was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category_program
      @category_program = CategoryProgram.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_program_params
      params.require(:category_program).permit(:code, :descrip)
    end
end
