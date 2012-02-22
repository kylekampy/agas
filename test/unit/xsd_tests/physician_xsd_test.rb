require "test_helper"
require "nokogiri"

class PhysicianXSDTest < ActiveSupport::TestCase
  #paths are relative to root dir of project (agas)
  phys1_xml = File.expand_path("test/unit/xsd_tests/test_xmls/physician_1.xml")
  phys_xsd = File.expand_path("public/xsd/physician.xsd")

  test "phys_files_exist" do
    assert File.exists?(phys1_xml)
    assert File.exists?(phys_xsd)
  end

  test "valid_phys_xml_for_schema" do
    doc = Nokogiri::XML(File.read(phys1_xml))
    xsd = Nokogiri::XML::Schema(File.read(phys_xsd))

    xsd.validate(doc).each do |error|
      puts error.message
      assert false #since we have errors, we obviously didn't pass.
    end

  end
end
