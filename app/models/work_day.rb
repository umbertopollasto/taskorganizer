class WorkDay < ApplicationRecord
  make_exportable

  belongs_to :user
  belongs_to :project
end
