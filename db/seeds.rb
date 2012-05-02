# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)

require 'time'

#For creating logins
def l(un, pass, type)
  return Login.create([{ :username => un, :password => pass, :password_confirmation => pass, :owner_type => type }])[0]
end

def admin(name, login)
  return Administrator.create([{ :name => name, :login => login }])
end

#For creating physicians
def phy(id, f_nm, l_nm, office_num, phones, emails, specialty, login)
  p = Physician.new
  p.firstname = f_nm
  p.lastname = l_nm
  p.specialty = specialty
  p.office_num = office_num
  p.phones = phones
  p.emails = emails
  p.login = login
  p.id = id
  p.save!
  return p
end

def pat(id, f_nm, l_nm, gender, dob, address, phone, email, emergency_contact, primary_phy_id)
  p = Patient.new
  p.id = id
  p.firstname = f_nm
  p.lastname = l_nm
  p.gender = gender
  p.date_of_birth = dob
  p.addresses = [address]
  p.phones = [phone]
  p.emails = [email]
  p.emergency_contact = emergency_contact
  p.primary_phy_id = primary_phy_id
  p.pharmacy_id = 1
  p.insurance_id = 1
  p.second_physician_id = nil
  p.save!
  return p
end

def apt(pat_id, phy_id, start_time, end_time)
  return Appointment.create([{ :start_time => start_time, :end_time => end_time, :phy_id => phy_id, :pat_id => pat_id }])[0]
end

def sch(phy_id, start_hour, end_hour, days)
  mon, tue, wed, thu, fri = false, false, false, false, false
  if(days == "Mon - Fri")
    mon, tue, wed, thu, fri = true, true, true, true, true
  elsif(days == "Mon - Thurs")
    mon, tue, wed, thu = true, true, true, true
  elsif(days == "Mon, Wed & Fri")
    mon, wed, fri = true, true, true
  elsif(days == "Tue - Fri")
    tue, wed, thu, fri = true, true, true, true
  elsif(days == "Mon & Wed")
    mon, wed = true, true
  end
  schedules = []
  date_counter = Date.parse("1/1/2012")
  end_date = Date.parse("1/1/2013")
  while(date_counter < end_date)
    #Cycle through day by day
    start_time = Time.parse("#{date_counter.to_s(:db)} #{start_hour}:00:00")
    end_time = Time.parse("#{date_counter.to_s(:db)} #{12+end_hour}:00:00")
    if(date_counter.wday == 1 && mon)
      schedules << Schedule.create([{ :phy_id => phy_id, :start_time => start_time, :end_time => end_time }])[0]
    elsif(date_counter.wday == 2 && tue)
      schedules << Schedule.create([{ :phy_id => phy_id, :start_time => start_time, :end_time => end_time }])[0]
    elsif(date_counter.wday == 3 && wed)
      schedules << Schedule.create([{ :phy_id => phy_id, :start_time => start_time, :end_time => end_time }])[0]
    elsif(date_counter.wday == 4 && thu)
      schedules << Schedule.create([{ :phy_id => phy_id, :start_time => start_time, :end_time => end_time }])[0]
    elsif(date_counter.wday == 5 && fri)
      schedules << Schedule.create([{ :phy_id => phy_id, :start_time => start_time, :end_time => end_time }])[0]
    end
    date_counter += 1
  end
  schedules
end

def staff(id, fn, ln, phones, emails, specialty, physician, login)
  m = MedicalStaff.new
  m.id = id
  m.firstname = fn
  m.lastname = ln
  m.phones = phones
  m.emails = emails
  m.doc_id = Physician.find_by_lastname(physician.split(" ")[1]).id
  m.login = login
  m.save!
  return m
end

def p(number, owner_type)
  return Phone.create([{ :phone_type => "Work", :phone => number, :owner_type => owner_type }])[0]
end

def add(street, city, state, zip, owner_type)
  return Address.create([{ :zip => zip, :street => street, :country => "US", :city => city, :state => state, :owner_type => owner_type }])[0]
end

#Email
def em(email, owner_type)
  return Email.create([{ :email_type => "Primary", :email => email, :owner_type => owner_type }])[0]
end

#Emergency Contact
def emc(name, address, phone)
  return EmergencyContact.create([{ :name => name, :address => address, :phone => phone }])[0]
end

#---------------- Seed data ----------------#

#Create an admin account
puts "Creating admins..."
admin("Superuser", l("admin", "password123", "Administrator"))

#Create some physician accounts
puts "Creating physicians..."
phy(2002,"Layla","Souter","A 423",[p("202-717-5022", "Physician")],[em("laylasouter@charthealth.org", "Physician")], "Family Practice", l("souter", "password", "Physician"))
phy(3055,"Sofia","Reymond", "A 450", [p("202-717-2047", "Physician")], [em("raymondso@charthealth.org", "Physician")], "Nephrology", l("reymond", "password", "Physician"))
phy(4451,"Yi Jie", "Wei", "A 353", [p("202-717-8643", "Physician")], [em("yijei@charthealth.org", "Physician")], "Cardiology", l("wei", "password", "Physician"))
phy(1204,"Jalilah", "Touma", "H 165", [p("202-717-6025", "Physician")], [em("hudunt@charthealth.org", "Physician")], "Family Practice", l("touma", "password", "Physician"))
phy(6734,"Matilde", "Costa", "H 260", [p("202-717-9690", "Physician")], [em("melocosta@charthealth.org", "Physician")], "Cardiology", l("costa", "password", "Physician"))
phy(1954,"Inas", "Wieldraaijer", "B 225", [p("202-717-6130", "Physician")], [em("inaswield@charthealth", "Physician")], "Gastroenterology", l("wieldraaijer", "password", "Physician"))
phy(9005,"Kristian", "Jokinen", "B 510", [p("202-717-4109", "Physician")], [em("kristianjokin@charthealth.org", "Physician")] , "Physical Therapy", l("jokinen", "password", "Physician"))
phy(1257,"Erno", "Varis", "H 185", [p("202-717-8780", "Physician")], [em("varise@charthealth.org", "Physician")], "Internal Medicine", l("varis", "password", "Physician"))
phy(7009,"Malcolm", "Garcia", "B 275" , [p("202-717-1174", "Physician")], [em("malcolmg@charthealth.org", "Physician")], "Internal Medicine", l("garcia", "password", "Physician"))
phy(5252,"Kultsar", "Panna", "B 302", [p("202-717-5973", "Physician")], [em("pannak@charthealth.org", "Physician")], "Family Practice", l("panna", "password", "Physician"))

#Add some medical staff accounts
puts "Creating medical staffers..."
staff(2124, "Dennis", "Maclean", [p("202-717-5022", "Medical Staff")], [em("macleand@charthealth.org", "Medical Staff")], "Family Practice", "Kultsar Panna", l("maclean", "password", "Medical Staff"))
staff(3255, "Frediano", "Panicucci", [p("202-717-2047", "Medical Staff")], [em("panicuccif@charthealth.org", "Medical Staff")], "Nephrology", "Sofia Reymond", l("panicucci", "password", "Medical Staff"))
staff(4549, "Evangeline", "Alanis", [p("202-717-8643", "Medical Staff")], [em("alanise@charthealth.org", "Medical Staff")], "Cardiology", "YiJie Wei", l("alanis", "password", "Medical Staff"))
staff(5678, "Corette", "Caron", [p("202-717-6025", "Medical Staff")], [em("corettec@charthealth.org", "Medical Staff")], "Family Practice", "Jalilah Touma", l("caron", "password", "Medical Staff"))
staff(2214, "Armina", "Franchet", [p("202-717-9690", "Medical Staff")], [em("arminaf@charthealth.org", "Medical Staff")], "Cardiology", "Matilde Costa", l("franchet", "password", "Medical Staff"))
staff(3698, "Chyou", "Fu", [p("202-717-6130", "Medical Staff")], [em("fuchyou@charthealth.org", "Medical Staff")], "Gastroenterology", "Inas Wieldraaijer", l("fu", "password", "Medical Staff"))
staff(7415, "Robyn", "Davis", [p("202-717-4109", "Medical Staff")], [em("davisro@charthealth.org", "Medical Staff")], "Physical Therapy", "Kristian Jokinen", l("davis", "password", "Medical Staff"))
staff(9115, "Cathy", "Banda", [p("202-717-8780", "Medical Staff")], [em("bandac@charthealth.org", "Medical Staff")], "Internal medicine", "Erno Varis", l("banda", "password", "Medical Staff"))
staff(9875, "Stephanie", "Necaise", [p("202-717-1174", "Medical Staff")], [em("necaises@charthealth.org", "Medical Staff")], "Nephrology", "Sofia Reymond", l("necaise", "password", "Medical Staff"))
staff(1003, "Terry","Hyde", [p("202-717-5973", "Medical Staff")], [em("hydet@charthealth.org", "Medical Staff")], "Family Practice", "Jalilah Touma", l("hyde", "password", "Medical Staff"))
staff(5997, "Maude", "Tharp", [p("202-717-3929", "Medical Staff")], [em("tharpm@charthealth.org", "Medical Staff")], "Internal medicine", "Malcom Garcia", l("tharp", "password", "Medical Staff"))
staff(5532, "Cassandra", "Peabody", [p("202-717-3155", "Medical Staff")], [em("peabodyc@charthealth.org", "Medical Staff")], "Cardiology", "Matilde Costa", l("peabody", "password", "Medical Staff"))
staff(1136, "Santos", "Piercy", [p("202-717-3520", "Medical Staff")], [em("santosp@charthealth.org", "Medical Staff")], "Cardiology", "YiJie Wei", l("piercy", "password", "Medical Staff"))
staff(8123,"Lee", "Ho", [p("202-717-4288", "Medical Staff")], [em("holee@charthealth.org", "Medical Staff")], "Gastroenterology", "Inas Wieldraaijer", l("ho", "password", "Medical Staff"))
staff(7245,"Dai", "Peng", [p("202-717-4025", "Medical Staff")], [em("pengdai@charthealth.org", "Medical Staff")], "Family Practice", "Layla Souter", l("peng", "password", "Medical Staff"))

#Create some patients
puts "Creating patients..."
pat(10198,"Sabine", "Zweig", "Female", Date.new(1976,7,5), add("4590 New York Ave.", "Fort Worth","WA","47895", "Patient"), p("202-985-6384", "Patient"), em("sabinez@telcost.com", "Patient"), emc("Bill Zweig", add("4590 New York Ave." , "Fortworth","WA", "47895", "Emergency Contact"), p("202-985-2546", "Emergency Contact")), 5252)
pat(10200,"Ralph", "Himmel", "Male", Date.new(1938,6,13), add("4099 Leroy Lane", "Watertown", "WA", "48675", "Patient"), p("202-882-8297", "Patient"), em("ralphh@fakemail.usa", "Patient"), emc("Amelia Himmel", add("4099 Leroy Lane", "Watertown", "WA", "48675", "Emergency Contact"), p("202-882-2146", "Emergency Contact")), 1204)
pat(50377,"Ralf","Abend","Male", Date.new(1945,8,5), add("4001 Drainer Ave.", "Bothell", "WA", "48858", "Patient"), p("202-629-0936", "Patient"), em("abendr@fakemail.usa", "Patient"), emc("Ramon Abend", add("4001 Drainer Avenue", "Bothell", "WA", "48858", "Emergency Contact"), p("202-387-4456", "Emergency Contact")), 1204)
pat(10404,"Torsten", "Kaufmann", "Male", Date.new(1966,9,20), add("503 Florence Street", "Mineola", "WA", "42571", "Patient"), p("202-497-1203", "Patient"), em("kaufmannt@telcost.com", "Patient"), emc("Mary Kaufmann", add("503 Florence Street", "Mineola", "WA", "42571", "Emergency Contact"), p("202-651-6654", "Emergency Contact")), 2002)
pat(20148, "Kevin", "Schmidt", "Male", Date.new(1988,1,3), add("3411 Victoria Street", "Bothell", "WA", "48858", "Patient"), p("202-236-5037", "Patient"), em("kevins@telcost.com", "Patient"), emc("Ashley Schmidt", add("3411 Victoria Street", "Bothell", "WA", "48858", "Emergency Contact"), p("202-236-7894", "Emergency Contact")), 5252)
pat(10600, "Edgardo", "Castiglione", "Male", Date.new(1967,10,6), add("609 Feathers Hooves Dr", "Garden City", "WA", "48536", "Patient"), p("202-704-3003", "Patient"), em("castiglionee@fakemail.usa", "Patient"), emc("Christie Castiglione", add("609 Feathers Hooves Dr.", "Garden City", "WA", "48536", "Emergency Contact"), p("202-704-3098", "Emergency Contact")), 2002)
pat(33879,"Clemente", "Buccho", "Female", Date.new(1970,6,18), add("981 Neuport Lane", "Norcross", "WA", "44931", "Patient"), p("202-337-3556", "Patient"), em("bucchoc@comtel.net", "Patient"), emc("Daniel Buccho", add("981 Neuport Lane", "Norcross", "WA", "44931", "Emergency Contact"), p("202-337-1177", "Emergency Contact")), 1204)
pat(10800, "Hugues", "Lagrange", "Female", Date.new(1955,2,20), add("4021 Holt Street", "Bothell", "WA", "48858", "Patient"), p("202-361-6490", "Patient"), em("hugueslag@fakemail.usa", "Patient"), emc("Larry Lagrange", add("4021 Holt Street", "Bothell", "WA", "48858", "Emergency Contact"), p("202-361-3341", "Emergency Contact")), 2002)
pat(87543, "Charlot", "Bondy", "Female", Date.new(1977,4,9), add("2293 Lee Avenue", "Camden", "WA", "42179", "Patient"), p("202-333-1781", "Patient"), em("bondy246@comtel.net", "Patient"), emc("Amber Bondy", add("2293 Lee Avenue", "Camden", "WA", "42179", "Emergency Contact"), p("202-333-9961", "Emergency Contact")), 5252)
pat(30100,"Platt", "Guimond", "Male", Date.new(1981,5,25), add("4892 Desert Broom Court", "Closter", "WA", "48823", "Patient"), p("202-750-6133", "Patient"), em("guimondpp@fakemail.usa", "Patient"), emc("Thomas Guimond", add("4892 Desert Broom Court", "Closter", "WA", "48823", "Emergency Contact"), p("202-750-6333", "Emergency Contact")), 2002)
pat(40100, "Melodie", "Perillard", "Female", Date.new(1950,3,11), add("538 Hill Haven Drive", "Kileen", "WA", "47896", "Patient"), p("202-258-4374", "Patient"), em("melodiep@teleworm.usa", "Patient"), emc("Adam Perillard", add("538 Hill Haven Drive", "Kileen", "WA", "47896", "Emergency Contact"), p("202-251-8882", "Emergency Contact")), 1204)
pat(74521,"Charline", "Margand", "Female", Date.new(1968,1,15), add("1828 Raoul Wallenberg Place", "Norwalk", "WA", "41238", "Patient"), p("202-899-6757", "Patient"), em("margandchar@telcost.com", "Patient"), emc("Kevin Margand", add("1828 Raoul Wallenberg Place", "Norwalk", "WA", "41238", "Emergency Contact"), p("202-899-1246", "Emergency Contact")), 5252)
pat(60100,"Cammile", "LaCaille", "Female", Date.new(1949,11,6), add("3409 Twin Willow Lane", "Bothell", "WA", "48858", "Patient"), p("202-397-5022", "Patient"), em("lacillecamm@comtel.net", "Patient"), emc("James LaCaille", add("3409 Twin Willow Lane", "Wilmington", "WA", "48858", "Emergency Contact"), p("202-397-1014", "Emergency Contact")), 2002)

#Create some schedules
puts "Creating schedules..."
sch(5252, 8,4, "Mon - Fri")
sch(1257, 8,4, "Mon - Fri")
sch(1204, 9,5, "Mon - Thurs")
sch(6734, 8,4, "Mon, Wed & Fri")
sch(9005, 9,5, "Tue - Fri")
sch(7009, 8,1, "Mon & Wed")
sch(4451, 9,2, "Mon - Fri")
sch(2002, 9,5, "Tue - Fri")
sch(3055, 8,4, "Mon - Fri")
sch(7009, 9,5, "Mon & Wed")

#Create some appointments
puts "Creating appointments..."
apt(10198,5252,Time.parse("2012-7-12 8:30am"), Time.parse("2012-7-12 9:00am"))
apt(10200,1257,Time.parse("2012-4-30 1:00pm"), Time.parse("2012-4-30 1:30pm"))
apt(50377,1204,Time.parse("2012-5-3 9:00am"), Time.parse("2012-5-3 9:30am"))
apt(10404,6734,Time.parse("2012-4-27 10:00am"), Time.parse("2012-4-27 10:30am"))
apt(20148,9005,Time.parse("2012-5-15 4:30pm"), Time.parse("2012-5-15 5:00pm"))
apt(10600,7009,Time.parse("2012-8-29 12:00pm"), Time.parse("2012-8-29 12:30pm"))
apt(33879,1204,Time.parse("2012-6-4 11:30am"), Time.parse("2012-6-4 12:00pm"))
apt(10800,4451,Time.parse("2012-5-11 9:30am"), Time.parse("2012-5-11 10:00pm"))
apt(87543,5252,Time.parse("2012-6-22 3:30pm"), Time.parse("2012-6-22 4:00pm"))
apt(30100,2002,Time.parse("2012-5-4 2:00pm"), Time.parse("2012-5-4 2:30pm"))
apt(40100,3055,Time.parse("2012-8-8 8:00am"), Time.parse("2012-8-8 8:30am"))
apt(74521,7009,Time.parse("2012-6-18 10:30am"), Time.parse("2012-6-18 11:00am"))
apt(60100,2002,Time.parse("2012-5-31 11:00am"), Time.parse("2012-5-31 11:30pm"))
