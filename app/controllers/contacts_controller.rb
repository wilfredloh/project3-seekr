class ContactsController < ApplicationController
  def index
    @contacts = Contact.all
    @documents = Document.all.where(user_id: current_user)

  end

  def show
    @contact = Contact.find(params[:id])
    @documents = Document.all.where(user_id: current_user)

  end

  def new
    @documents = Document.all.where(user_id: current_user)

  end

  def create
    @contact = Contact.new(contact_params)

    # render plain: params[:contact].inspect
    @contact.user = current_user

    @contact.save
    redirect_to contacts_path
  end

  def edit
    @documents = Document.all.where(user_id: current_user)

  end



  def update
    @documents = Document.all.where(user_id: current_user)

  end

  def destroy
  end

  private

    def contact_params
      params.require(:contact).permit(:name, :phone, :email)
    end
end