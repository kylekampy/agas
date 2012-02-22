require "test_helper"
require "nokogiri"

class PatientXSDTest < ActiveSupport::TestCase
  #paths are relative to root dir of project (agas)
  pat1_xml = File.expand_path("test/unit/xsd_tests/test_xmls/patient_1.xml")
  pat_xsd = File.expand_path("public/xsd/patient.xsd")

  test "patient_files_exist" do
    assert File.exists?(pat1_xml)
    assert File.exists?(pat_xsd)
  end

  test "valid_pat_xml_for_schema" do
    doc = Nokogiri::XML(File.read(pat1_xml))
    xsd = Nokogiri::XML::Schema(File.read(pat_xsd))

    xsd.validate(doc).each do |error|
      puts error.message
      assert false #since we have errors, we obviously didn't pass.
    end

  end
end
