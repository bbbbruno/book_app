# frozen_string_literal: true

require "test_helper"

class ProfileTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    @profile = @user.create_profile
  end

  test "#resized_avatar should resize avatar image" do
    assert_instance_of ActiveStorage::Variant, @profile.resized_avatar([150, 150])
  end
end
