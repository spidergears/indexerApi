class IndexedUrl < ApplicationRecord

  validates :url, :status, presence: true
  validates :url, format: { 
    with: URI::regexp, 
    message: "does not match standard url regex" 
  }

  before_validation :set_default_status

  def set_default_status
    self.status = status || 'Processing'
  end
end
