class HotReadsService < ActiveRecord::Base

  def self.get_hot_links
    response = Faraday.get("https://boiling-woodland-88175.herokuapp.com/api/v1/links")
    JSON.parse(response.body, symbolize_names: true)
  end
end
