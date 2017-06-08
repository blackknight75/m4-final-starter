class Link < ActiveRecord::Base
  validates :url, :url => true
  validates :title, :presence => true
  belongs_to :user

  def self.get_hot
    HotReadsService.get_hot_links.map do |link|
      link[:url]
    end
  end
end
