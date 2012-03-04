require "test_helper"
require "nokogiri"

class XMLXSDTests < ActiveSupport::TestCase
  #paths are relative to root dir of project (agas)
  xmls = Dir.glob("test/unit/xsd_tests/test_xmls/*.xml")
  xsds = Dir.glob("public/xsd/*.xsd")
  xmls.sort!
  xsds.sort!

  #First, assert there is an xsd for each xml.
  test "xml_for_each_xsd" do
    xml_basenames = []
    xmls.each do |cur_xml|
      xml_basenames << File.basename(cur_xml, ".xml")
    end
    
    xsd_basenames = []
    xsds.each do |cur_xsd|
      xsd_basenames << File.basename(cur_xsd, ".xsd")
    end
    
    #Assert that our arrays contain the exact same contents.
    arrays_equal? = xml_basenames <=> xsd_basenames == 0
    assert arrays_equal?
    
    if(arrays_equal?) #Then lets run some more tests!
      (0..xml.length).each do |i|
        test "#{xml_basenames[i]} xsd validation" do
          doc = Nokogiri::XML(File.read(xmls[i]))
          xsd = Nokogiri::XML::Schema(File.read(xsds[i]))          

          xsd.validate(doc).each do |error|
            puts error.message
            assert false #since we have errors, we obviously didn't pass.
          end
        end
      end
    end
  end
end
