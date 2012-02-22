require "test_helper"
require "nokogiri"

class AppointmentXSDTest < ActiveSupport::TestCase
  #paths are relative to root dir of project (agas)
  apt1_xml = File.expand_path("test/unit/xsd_tests/test_xmls/appointment_1.xml")
  apt_xsd = File.expand_path("public/xsd/appointment.xsd")

  test "apt_files_exist" do
    assert File.exists?(apt1_xml)
    assert File.exists?(apt_xsd)
  end

  test "valid_apt_xml_for_schema" do
    doc = Nokogiri::XML(File.read(apt1_xml))
    xsd = Nokogiri::XML::Schema(File.read(apt_xsd))

    xsd.validate(doc).each do |error|
      puts error.message
      assert false #since we have errors, we obviously didn't pass.
    end

  end
end
