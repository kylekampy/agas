xml.instruct!
  xml.medical_staff({"xmlns:xsi" => "http://www.w3.org/2001/XMLSchema-instance"}) do
    xml.id @medical_staff.id
    xml.firstname @medical_staff.firstname
    xml.middlename @medical_staff.middlename
    xml.lastname @medical_staff.lastname
    xml.doc_id @medical_staff.doc_id
    xml.phone @medical_staff.phone
  end
