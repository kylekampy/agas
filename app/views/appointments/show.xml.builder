xml.instruct!
  xml.appointment do
    xml.id @appointment.id, {"xs:type" => "integer"}
    xml.start_time @appointment.start_time, {:type => "dateTime"}
    xml.end_time @appointment.end_time, {:type => "dateTime"}
    xml.physician_id @appointment.phy_id, {:type => "integer"}
    xml.patient_id @appointment.pat_id, {:type => "integer"}
  end


