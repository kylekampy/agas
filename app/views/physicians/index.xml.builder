xml.instruct!
xml.physicians do
  @physicians.each do |physician|
    xml.physician do
      xml.id physician.id, {:type => "integer"}
      xml.firstname physician.firstname, {:type => "string"}
      xml.middlename physician.middlename, {:type => "string"}
      xml.lastname physician.lastname, {:type => "string"}
      xml.specialty physician.specialty, {:type => "string"}
    end
  end
end
