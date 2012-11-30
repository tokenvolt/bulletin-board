require 'spec_helper'

describe User do
  describe "#admin?" do

    it "returns true if user is an admin" do
      admin_user = User.create(email: "user@example.com", password: '123456', role: 'admin')
      admin_user.should be_admin
    end

    it "returns false if user is not an admin" do
      common_user = User.create(email: "user@example.com", password: '123456')
      common_user.should_not be_admin
    end
  end
end