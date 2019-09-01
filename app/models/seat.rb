class Seat < ApplicationRecord
	has_many :positions, dependent: :destroy

	# self.ignored_columns = %w(ceated_at updated_at)
end
