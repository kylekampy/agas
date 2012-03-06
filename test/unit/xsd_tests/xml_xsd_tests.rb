require "test_helper"
require "nokogiri"

class XMLXSDTests < ActiveSupport::TestCase
  test "empty test" do
    assert true
  end

  #paths are relative to root dir of project (agas)
  xmls = Dir.glob("test/unit/xsd_tests/test_xmls/*.xml")
  xsds = Dir.glob("public/xsd/*.xsd")
  xmls.sort!
  xsds.sort!
  arrays_equal = false
  DEBUG = true

  #First, assert there is an xsd for each xml.
  puts "about to do first test" if DEBUG
  test "xml_for_each_xsd" do
    xml_basenames = []
    xmls.each do |cur_xml|
      xml_basenames << File.basename(cur_xml, ".xml")
    end
    puts "xmls: #{xmls}" if DEBUG
    
    xsd_basenames = []
    xsds.each do |cur_xsd|
      xsd_basenames << File.basename(cur_xsd, ".xsd")
    end
    puts "xsds: #{xsds}" if DEBUG

    #Assert that our arrays contain the exact same contents.
    arrays_equal = ((xml_basenames <=> xsd_basenames) == 0)
    puts "arrays_equal: #{arrays_equal}" if DEBUG
    if(!arrays_equal)
      #Print out some more info so we know what is missing.
      combined = xml_basenames + xsd_basenames
      combined.uniq!
      (0..(combined.length-1)).each do |i|
        puts "#{combined[i]} doesn't have a matching xml and xsd."
      end
    end
    assert arrays_equal
  end

  puts "At the second section with arrays_equal = #{arrays_equal}" if DEBUG
  if(arrays_equal) #Then lets run some more tests!
    (0..xmls.length).each do |i|
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
