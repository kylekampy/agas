xml.instruct!
  xml.appointment({"xmlns:xsi" => "http://www.w3.org/2001/XMLSchema-instance"}) do
    xml.id @appointment.id
    xml.start_time @appointment.start_time
    xml.end_time @appointment.end_time
    xml.physician_id @appointment.phy_id
    xml.patient_id @appointment.pat_id
  end
