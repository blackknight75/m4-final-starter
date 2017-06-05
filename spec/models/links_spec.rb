require 'rails_helper'

RSpec.describe Link, type: :model do
  describe "relationships" do
    it { should respond_to(:user) }
  end
end
