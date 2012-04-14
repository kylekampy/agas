xml.instruct!
xml.medical_staffs({"xmlns:xsi" => "http://www.w3.org/2001/XMLSchema-instance"}) do
  @medical_staffs.each do |staff|
    xml.medical_staff do
      xml.id staff.id
      xml.firstname staff.firstname
      xml.middlename staff.middlename
      xml.lastname staff.lastname
      xml.doc_id staff.doc_id
      xml.phones do
        staff.phones.each do |phone|
          xml.phone phone.phone, :type => phone.phone_type
        end
      end
    end
  end
end
