class ProjectsController < ApplicationController
  before_action :set_project, only: %i[ show edit update destroy ]
  skip_before_action :authenticate_user!, only: :index
  # GET /projects or /projects.json
  def index
    if user_signed_in?
      @projects = current_user.projects.all
    end
  end

  # GET /projects/1 or /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = current_user.projects.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects or /projects.json
  def create
    @user = current_user
    @project = @user.projects.new(project_params)
    respond_to do |format|
      if @project.save
        format.html { redirect_to project_categories_path(@project.id), notice: "Project was successfully created." }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity } 
      end
    end
    
  end

  # PATCH/PUT /projects/1 or /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to projects_path, notice: "Project was successfully updated."}
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1 or /projects/1.json
  def destroy
    @project.destroy
    redirect_to projects_url, notice: "Project was successfully destroyed." 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = current_user.projects.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def project_params
      params.require(:project).permit(:name, :complete, :timelimit, :deadline, :user_id)
    end
end
