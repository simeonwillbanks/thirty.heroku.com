class Tweet < ActiveRecord::Base
  validates_presence_of :text, :message => "must be entered"
  validates_length_of :text, :within => 1..140, :message => "must be between 1 and 140 characters"
  belongs_to :user
end
