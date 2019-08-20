class JobsController < ApplicationController
before_action :authenticate_user!, :except => [ :show, :index, :create, :destroy ]
    def new
      @job = Job.new
    end

    def index
      @jobs = Job.all
    end

  def create
    @job = Job.new(job_params)
    @job.user = current_user
    @job.save
    redirect_to root_path
  end

  def edit
    @job = Job.find(params[:id])
  end

  def update
    @job = Job.find(params[:id])
    @job.update(job_params)
    redirect_to root_path
  end

  def show
    @job = Job.find(params[:id])
  end

    def destroy
    @job = Job.find(params[:id])
    @job.destroy
    redirect_to @job
  end

private

  def job_params
    params.require(:job).permit(:comp_name, :title, :location, :salary, :url, :deadline)
  end
end