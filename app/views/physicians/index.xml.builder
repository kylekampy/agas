xml.instruct!
xml.physicians do
  @physicians.each do |physician|
    xml.physician do
      xml.id physician.id
      xml.firstname physician.firstname
      xml.middlename physician.middlename
      xml.lastname physician.lastname
      xml.specialty physician.specialty
      xml.office_num physician.office_num
    end
  end
end
