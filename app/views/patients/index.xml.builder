xml.instruct!
xml.patients({"xmlns:xsi" => "http://www.w3.org/2001/XMLSchema-instance"}) do
  @patients.each do |patient|
    xml.patient do
      xml.id patient.id
      xml.firstname patient.firstname
      xml.middlename patient.middlename
      xml.lastname patient.lastname
      xml.date_of_birth patient.date_of_birth
      xml.primary_phy_id patient.primary_phy_id
      xml.pharmacy_id patient.pharmacy_id
      xml.insurance_id patient.insurance_id
    end
  end
end
