xml.instruct!
  xml.physician({"xmlns:xsi" => "http://www.w3.org/2001/XMLSchema-instance"}) do
    xml.id @physician.id
    xml.firstname @physician.firstname
    xml.middlename @physician.middlename
    xml.lastname @physician.lastname
    xml.specialty @physician.specialty
    xml.office_num @physician.office_num
    xml.phone_num @physician.phone
  end
