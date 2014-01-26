class Event < ActiveRecord::Base
	belongs_to :user
	
	validates :where, presence: true
	validates :user_id, presence: true
	
	default_scope order: 'events.created_at DESC'
end
