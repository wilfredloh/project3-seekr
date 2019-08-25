class StatsController < ApplicationController
  def index

      @jobs = Job.all.where(user_id: current_user)

      if @jobs.present?

        @to_submit = @jobs.where(status:"Started").length
        applied = @jobs.where(status:"Submitted")
        @applied = applied.length
        @progress = @jobs.where("status like ?", "%Interview").length
        @active = applied.length + @progress
        @result = @jobs.where(status:"Awaiting Result").length
        @offer = @jobs.where(status:"Offer Received").length
        @rejected = @jobs.where(status:"Rejected").length

        # @this_month = 0
        #  applied.each do |job|
        #   if job.created_at.localtime.strftime("%B") == Date.today.strftime("%B")
        #     @this_month += 1
        #   end
        # end

        @total_applied = @applied + @progress + @result + @offer + @rejected
        @total_interview = @progress + @result + @offer + @rejected
        @total_completed = @result + @offer + @rejected
        @success_rate = (@offer / @total_applied) * 100




        @documents = Document.all.where(user_id: current_user)
        @specials = Special.all.where(user_id: current_user)

        @special = @specials.last
        # @specials_today = specials.where(created_at: Date.today)

        @specials_today = []
        @specials.each do |s|
          if s.created_at.localtime.to_date == Date.today
            @specials_today.push(s)
          end
        end
      end

      documents_user = Document.all.where(user_id: current_user)
      sorted_doc = documents_user.sort_by{|doc| doc.title}
      documents = []
      sorted_doc.each do |doc|
        documents.push(doc.title)
      end
      @documents = ['-'] + documents

  end




end