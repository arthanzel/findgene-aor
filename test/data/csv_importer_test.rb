require 'test_helper'

require "data/csv_importer"

class CSVImporterTest < ActionController::TestCase
  test "should read a CSV file and import primers" do
    assert_equal 101, Primer.count
    CSVImporter::import("./test/data/primers_test.csv")
    assert_equal 103, Primer.count

    assert_not Primer.find_by_code("Code")
    assert_equal "X First", Primer.find_by_code("X01").name
  end
end
