class JobsController < ApplicationController
before_action :authenticate_user!, :except => [ :home ]

    def home
      @jobs = Job.all
      @messages = Message.all
      @added = @jobs.where(status:"saved").length
      @applied = @jobs.where(status:"submitted application").length
      @offer = @jobs.where(status:"Offer").length
      @rejected = @jobs.where(status:"Rejected").length

      count = 0
      @jobs.each do |job|
        if job.created_at.to_date == Time.now.to_date
          count += 1
        end
      end
      @count = count
      @deadline = @jobs.sort_by{|job| job.deadline}
      # @upcoming = @jobs.sort_by{|job| job.interview}
      @recent = @jobs.sort_by{|job| job.updated_at}

    end

    def index
      @jobs = Job.all
    end

    def new
      @job = Job.new
    end

    def create
      @job = Job.new(job_params)
      @message = Message.new(description:"Created a new job #{@job.title}", job: @job)
      @job.user = current_user
      @job.save
      @message.save
      redirect_to root_path
    end

    def edit
      @job = Job.find(params[:id])
    end

    def update
      @job = Job.find(params[:id])
      @message = Message.new(description:"Updated job #{@job.title}", job: @job)

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