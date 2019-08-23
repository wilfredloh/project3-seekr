class Job < ApplicationRecord
  belongs_to :user
  has_many :message
  has_and_belongs_to_many :documents
end