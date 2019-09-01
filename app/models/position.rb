class Position < ApplicationRecord
  belongs_to :seat

  # self.ignored_columns = %w(ceated_at updated_at)
end
