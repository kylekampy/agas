xml.instruct!
xml.physicians({"xmlns:xsi" => "http://www.w3.org/2001/XMLSchema-instance"}) do
  @physicians.each do |physician|
    xml.physician do
      xml.id physician.id
      xml.firstname physician.firstname
      xml.middlename physician.middlename
      xml.lastname physician.lastname
      xml.specialty physician.specialty
      xml.office_num physician.office_num
      xml.phones do
        physician.phones.each do |phone|
          xml.phone phone.phone, :type => phone.phone_type
        end
      end
    end
  end
end
