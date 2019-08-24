class JobsController < ApplicationController
before_action :authenticate_user! #, :except => [ :home ]

    def home
      # for all jobs and messages under this user
      @jobs = Job.all.where(user_id: current_user)

      messages = Message.all.where(user_id: current_user)
      @messages = messages.reverse

      documents_user = Document.all.where(user_id: current_user)
      documents = []
      # p '@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'
      # p @documents
      # p '@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'
      documents_user.each do |doc|
        documents.push(doc.title)
      end
      @documents = ['-'] + documents
      # @resumes = resume_name #.sort_by{|doc| doc.resume}

      # for the 6 different statuses:
      # @created @applied @progress @result @offer @rejected
      @created = @jobs.length
      applied = @jobs.where(status:"Submitted")
      @applied = applied.length

      progress = 0
      count = 0
      @jobs.each do |job|
        if job.status.include?("1st") || job.status.include?("2nd")
          progress += 1
        end
        if job.created_at.to_date == Time.now.to_date
          count += 1
        end
      end
      @progress = progress
      @result = @jobs.where(status:"Awaiting Result").length
      @offer = @jobs.where(status:"Offer Received").length
      @rejected = @jobs.where(status:"Rejected").length

      # count number of jobs this user has created/applied today
      atoday = 0
      applied.each do |job|
        if job.created_at.to_date == Date.today
          atoday += 1
        end
      end
      @atoday = atoday
      @ctoday = count

      # getting all dates for deadlines/interviews of this user
      deadline = []
      interview = []
      @jobs.each do |job|
        if job.deadline.present?
          if job.deadline >= Date.today
            deadline.push(job)
          end
        end
        if job.interview.present?
          if job.interview >= Date.today
            interview.push(job)
          end
        end
      end
      @deadline = deadline.sort_by{|job| job.deadline}
      @interview = interview.sort_by{|job| job.interview}


      #################### SPECIAL SECTION ######################
      ## GUIDE ##
      # CURRENT USER MODE
      # DEFAULT                                         = 'off'
      # IF A SPECIAL IS ONGOING, MODES                  = 'easy', 'hard'
      # IF A SPECIAL HAS ENDED BUT USER SUCCEDED        = 'pass'
      # IF A SPECIAL HAS ENDED BUT USER FAILED          = 'fail'
      # IF A SPECIAL HAS ENDED AND 2 HOURS HAVE PASSED  = 'off'

      ##### SPECIAL (LATEST)
      # SPECIAL.MODE                      = 'easy', 'hard'
      # SPECIAL.RESULT                    = 'pass', 'fail', 'cancel'

      @specials = Special.all.where(user_id: current_user)
      special = @specials.last

      if current_user.mode == 'hard' # add more 'or' conditions if got more than one mode here
        start_time = special.created_at.localtime
        current_time = Time.now.localtime
        seconds_since_start = current_time - start_time
        remaining_seconds = 3600 - seconds_since_start
        min = (remaining_seconds / 60).floor
        sec = remaining_seconds.to_i % 60 # => 0
        @alert_m = "#{min}"
        @alert_s = "#{sec}"
        @alert_app = "#{10 - atoday}"
        # to check for time taken to complete special
        r_min = (seconds_since_start / 60).floor
        r_sec = seconds_since_start.to_i % 60 # => 0
        status = 'off'
        if atoday >= 10
          status = 'reset'
          special.result = 'pass'
          special.total_jobs_applied  = atoday - special.jobs_applied_on_start
          special.time_taken = "#{r_min} minutes #{r_sec} seconds"
          current_user.mode = 'pass'

        elsif remaining_seconds <= 0
          status = 'reset'
          special.result = 'fail'
          special.total_jobs_applied  = atoday - special.jobs_applied_on_start
          special.time_taken = "1 hour"
          current_user.mode = 'fail'

          if status == 'reset'
          special.save
          current_user.save
            if request.env['PATH_INFO'] != "/"
              redirect_to root_path
            end
          end
        end
      end
      @special = special
      if special.present?
        if Time.now > @special.updated_at.localtime + 7200
          current_user.mode = 'off'
        end
      end

      #################### END SECTION ######################
    end





    def index
      documents_user = Document.all.where(user_id: current_user)
      documents = []
      documents_user.each do |doc|
        documents.push(doc.title)
      end
      @documents = ['-'] + documents

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
        @sorted = @jobs.sort_by{|job| job.stat_index}
      elsif params[:sortby] == "status-des"
        sorted = @jobs.sort_by{|job| job.stat_index}
        @sorted = sorted.reverse
      elsif params[:sortby] == "deadline-asc"
        no_date = []
        have_date = []
        @jobs.each do |job|
          if job.deadline == nil
            no_date.push(job)
          else
            have_date.push(job)
          end
        end
        sorted_date = have_date.sort_by{|job| job.deadline}
        @sorted = sorted_date + no_date
      elsif params[:sortby] == "deadline-des"
        no_date = []
        have_date = []
        @jobs.each do |job|
          if job.deadline == nil
            no_date.push(job)
          else
            have_date.push(job)
          end
        end
        sorted_date = have_date.sort_by{|job| job.deadline}
        reverse = sorted_date.reverse
        @sorted = reverse + no_date
      elsif params[:sortby] == "interview-asc"
        no_date = []
        have_date = []
        @jobs.each do |job|
          if job.interview == nil
            no_date.push(job)
          else
            have_date.push(job)
          end
        end
        sorted_date = have_date.sort_by{|job| job.interview}
        @sorted = sorted_date + no_date
      elsif params[:sortby] == "interview-des"
        no_date = []
        have_date = []
        @jobs.each do |job|
          if job.interview == nil
            no_date.push(job)
          else
            have_date.push(job)
          end
        end
        sorted_date = have_date.sort_by{|job| job.interview}
        reverse = sorted_date.reverse
        @sorted = reverse + no_date
      else
        @sorted = @jobs.sort_by{|job| job.status}
      end
    end


    def status

      documents_user = Document.all.where(user_id: current_user)
      documents = []
      # p '@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'
      # p @documents
      # p '@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@'
      documents_user.each do |doc|
        documents.push(doc.title)
      end
      @documents = ['-'] + documents


      @jobs = Job.all.where(user_id: current_user)
      @job_started = @jobs.where(status: "Started").sort_by{|job| job.updated_at}
      @job_submitted = @jobs.where(status: "Submitted").sort_by{|job| job.updated_at}
      @job_interview = @jobs.where("status like ?", "%Interview%").sort_by{|job| job.interview}
      @job_awaiting = @jobs.where("status like ?", "%Awaiting%").sort_by{|job| job.updated_at}
      @job_offered = @jobs.where("status like ?", "%Offer%").sort_by{|job| job.updated_at}
      @job_rejected = @jobs.where(status: "Rejected").sort_by{|job| job.updated_at}
    end

    def show
      @job = Job.find(params[:id])
    end

    def create
      @job = Job.new(job_params)
      status = ['Started', 'Submitted', '1st Interview', '2nd Interview', 'Awaiting Results', 'Offer Received', 'Rejected']
      status.each_with_index do |stat, index|
        if @job.status == stat
          @job.stat_index = index+1
        end
      end

      @documents = Document.all.where(user_id: current_user)

      if params[:job][:doc] == '-'

      else
        new_doc = Document.find_by(:title => params[:job][:doc])
        @job.documents << new_doc
      end

      @job.user = current_user
      @job.save

      @message = Message.new(description:"Created:", job: @job, user: current_user)
      @message.save
      redirect_to root_path
    end

    def edit
      @job = Job.find(params[:id])
    end







    def update
      @job = Job.find(params[:id])
      status = ['Started', 'Submitted', '1st Interview', '2nd Interview', 'Awaiting Results', 'Offer Received', 'Rejected']
      status.each_with_index do |stat, index|
        if job_params[:status] == stat
          @job.stat_index = index+1
        end
      end

      @documents = Document.all.where(user_id: current_user)

      if @job.documents.length > 0
        if params[:job][:doc] == '-'
          old_doc = @job.documents[0]
          @job.documents.delete(old_doc)
        elsif params[:job][:doc] != @job.documents[0].title
          old_doc = @job.documents[0]
          @job.documents.delete(old_doc)
          new_doc = Document.find_by(:title => params[:job][:doc])
          @job.documents << new_doc
        end
      else
        if params[:job][:doc] == '-'

        else
          new_doc = Document.find_by(:title => params[:job][:doc])
          @job.documents << new_doc
        end
      end
      @job.update(job_params)

      @message = Message.new(description:"Updated:", job: @job, user: current_user)
      @message.save

      openFromURL = request.referrer

      if openFromURL.include?('status')
        redirect_to status_job_path
      elsif (URI(openFromURL).path  == "/jobs")
        redirect_to jobs_path
      else
        redirect_to root_path
      end
    end

    def destroy
      @job = Job.find(params[:id])
      @job.destroy

      openFromURL = request.referrer
      if openFromURL.include?('status')
          redirect_to status_job_path
        elsif (URI(openFromURL).path  == "/jobs")
          redirect_to jobs_path
        else
          redirect_to root_path
      end
    end

    def activate_serious_mode
      #modes ( 1 = focus, 2 = hard)
      @jobs = Job.all.where(user_id: current_user)
      applied = @jobs.where(status:"Submitted")
      atoday = 0
      applied.each do |job|
        if job.created_at.to_date == Date.today
          atoday += 1
        end
      end

      @special = Special.new(mode: 'hard', user: current_user, jobs_applied_on_start: atoday)
      @special.save
      current_user.mode = 'hard'
      current_user.start_special = @special.created_at
      current_user.save
      redirect_to root_path
    end

    def deactivate_serious_mode

      @jobs = Job.all.where(user_id: current_user)
      applied = @jobs.where(status:"Submitted")
      atoday = 0
      applied.each do |job|
        if job.created_at.to_date == Date.today
          atoday += 1
        end
      end

      @specials = Special.all.where(user_id: current_user)
      special = @specials.last
      if current_user.mode == 'hard' # add more 'or' conditions if got more than one mode here
        start_time = special.created_at.localtime
        current_time = Time.now.localtime
        seconds_since_start = current_time - start_time
        r_min = (seconds_since_start / 60).floor
        r_sec = seconds_since_start.to_i % 60 # => 0

        special.result = 'cancel'
        special.total_jobs_applied  = atoday - special.jobs_applied_on_start
        special.time_taken = "#{r_min} minutes #{r_sec} seconds"
        current_user.mode = 'off'

        special.save
        current_user.save
      end

      redirect_to root_path
    end

private

    def job_params
      params.require(:job).permit(:comp_name, :title, :location, :salary, :url, :deadline, :interview, :status, :ind, :notes, :document_ids => [])
    end

    def doc_params
      params.require(:document).permit(:title, :job_ids => [])
    end
end