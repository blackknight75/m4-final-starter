require 'rails_helper'

RSpec.describe User, type: :model do
  describe "relationships" do
    it { should respond_to(:links) }
  end
end
