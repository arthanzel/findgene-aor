require 'test_helper'

class AccessTest < ActiveSupport::TestCase
  test "should create random tokens on new Access objects" do
    Access.delete_all
    a = Access.create
    assert_equal a.token, Access.first.token
  end

  test "should delete old accesses" do
    # Create some old Accesses
    Access.create(updated_at: 60.days.ago)
    Access.create(updated_at: 31.minutes.ago)
    Access.create(updated_at: 5.minutes.ago)
    Access.destroy_old
    assert_equal 1, Access.count
  end
end
