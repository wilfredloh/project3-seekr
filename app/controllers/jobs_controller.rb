class JobsController < ApplicationController
before_action :authenticate_user!, :except => [ :home ]

    def home
      # for all jobs and messages under this user
      @jobs = Job.all.where(user_id: current_user)
      messages = Message.all.where(user_id: current_user)
      @messages = messages.reverse

      # for the 4 different statuses
      @added = @jobs.where(status:"Started").length
      @applied = @jobs.where(status:"Submitted").length
      @offer = @jobs.where(status:"Offer Received").length
      @rejected = @jobs.where(status:"Rejected").length

      # count number of jobs this user has created today
      count = 0
      @jobs.each do |job|
        if job.created_at.to_date == Time.now.to_date
          count += 1
        end
      end
      @count = count

      # getting all deadlines/interviews of this user
      deadline = []
      interview = []
      @jobs.each do |job|
        if job.deadline != nil #&& job.deadline >= today
          deadline.push(job)
        end
        if job.interview != nil #&& job.deadline >= today
          interview.push(job)
        end
      end
      @deadline = deadline
      @interview = interview
    end





    def index
      @jobs = Job.all.where(user_id: current_user)
      @sorted
      if params[:sortby] == "comp-asc"
        @sorted = @jobs.sort_by{|job| job.comp_name}
      elsif params[:sortby] == "comp-des"
        sorted = @jobs.sort_by{|job| job.comp_name}
        @sorted = sorted.reverse
      elsif params[:sortby] == "title-asc"
        @sorted = @jobs.sort_by{|job| job.title}
      elsif params[:sortby] == "title-des"
        sorted = @jobs.sort_by{|job| job.title}
        @sorted = sorted.reverse
      elsif params[:sortby] == "salary-asc"
        @sorted = @jobs.sort_by{|job| job.salary}
      elsif params[:sortby] == "salary-des"
        sorted = @jobs.sort_by{|job| job.salary}
        @sorted = sorted.reverse
      elsif params[:sortby] == "status-asc"
        sorted = @jobs.sort_by{|job| job.status}
        @sorted = sorted
      elsif params[:sortby] == "status-des"
        @sorted = @jobs.sort_by{|job| job.status}
      elsif params[:sortby] == "deadline-asc"
        # sorted = @jobs.sort_by{|job| job.deadline}
      #   @sorted = sorted.reverse
      elsif params[:sortby] == "deadline-des"
        # @sorted = @jobs.sort_by{|job| job.deadline}
      else
        @sorted = @jobs.sort_by{|job| job.id}
      end
      # @interview = @jobs.sort_by{|job| job.interview}
      # @deadline = @jobs.sort_by{|job| job.deadline}
    end






    def status
      @job_saved = Job.where(status: "saved")
      @job_applied = Job.where(status: "submitted application")
      @job_interview = Job.where("status like ?", "%interview%")
      @job_accepted = Job.where(status: "Accepted")
    end

    def show
      @job = Job.find(params[:id])
    end

    def new
      @job = Job.new
    end

    def create
      @job = Job.new(job_params)
      @job.user = current_user
      @job.save

      @message = Message.new(description:"Created job: #{@job.title}", job: @job, user: current_user)
      @message.save
      redirect_to root_path
    end

    def edit
      @job = Job.find(params[:id])
    end

    def update
      @job = Job.find(params[:id])
      @job.update(job_params)

      @message = Message.new(description:"Updated job: #{@job.title}", job: @job, user: current_user)
      @message.save
      redirect_to root_path
    end

    def destroy
      @job = Job.find(params[:id])
      @job.destroy
      redirect_to @job
    end

private

    def job_params
      params.require(:job).permit(:comp_name, :title, :location, :salary, :url, :deadline, :interview, :status)
    end
end