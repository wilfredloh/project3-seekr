class DocumentsController < ApplicationController
  def index
    @documents = Document.all
  end

  def show
    @document = Document.find(params[:id])
  end

  def new
  end

  def create
    @document = Document.new(document_params)

    # render plain: params[:document].inspect
    uploaded_file = params[:document][:file].path
    cloudinary_file = Cloudinary::Uploader.upload(uploaded_file)

    @document.url = cloudinary_file['url']
    @document.file = cloudinary_file['public_id']
    @document.user = current_user

    @document.save
    redirect_to documents_path
  end

  def edit
    @document = Document.find(params[:id])
  end

  def update
    @document = Document.find(params[:id])
    # render plain: params[:document][:check].inspect

    if params[:document][:check] == 'true'
      uploaded_file = params[:document][:file].path
      cloudinary_file = Cloudinary::Uploader.upload(uploaded_file)
      @document.file = cloudinary_file['public_id']
      @document.url = cloudinary_file['url']
    end
    @document.update(document_params)
    redirect_to documents_path
  end

  def destroy
  end

  private

    def document_params
      params.require(:document).permit(:title, :doc_type, :file)
    end
end