class Document < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :jobs


  # validates :doc_type, presence: true
  # validates_presence_of   :doc_type, :message => 'Please fill in a type.'

end