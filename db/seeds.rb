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

def pat(f_nm, m_nm, l_nm, dob)
  return Patient.create([{ :firstname => f_nm, :middlename => m_nm, :lastname => l_nm, :primary_phy_id => Physician.all[rand(Physician.all.length-1)].id, :date_of_birth => dob, :pharmacy_id => 1, :insurance_id => 1, :second_physician_id => nil }])[0]
end

def apt(start_time, end_time)
  return Appointment.create([{ :start_time => start_time, :end_time => end_time, :phy_id => Physician.all[rand(Physician.all.length-1)].id, :pat_id => Patient.all[rand(Patient.all.length-1)].id }])[0]
end

def sch(start_time, end_time)
  schedules = []
  Physician.all.each do |phy|
    schedules << Schedule.create([{ :start_time => start_time, :end_time => end_time, :phy_id => phy.id }])[0]
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

def add(zip, street, state, owner_type)
  return Address.create([{ :zip => zip, :street => street, :country => "US", :owner_type => owner_type }])[0]
end

def em(email, owner_type)
  return Email.create([{ :email_type => "Primary", :email => email, :owner_type => owner_type }])[0]
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
pat("John", "B", "Doe", "23-3-1987")
pat("Steve", "B", "Miller", "12-04-1967")
pat("Phil", "B", "Fons", "30-5-1994")
pat("John2", "C", "Doe2", "23-3-1988")
pat("Steve2", "C", "Miller2", "12-04-1968")
pat("Phil2", "C", "Fons2", "30-5-1995")
pat("John3", "D", "Doe3", "23-3-1986")
pat("Steve3", "D", "Miller3", "12-04-1966")
pat("Phil3", "D", "Fons3", "30-5-1993")

#Create some schedules
puts "Creating schedules..."
sch(Time.parse("2012/5/12 08:00:00"), Time.parse("2012/5/12 16:00:00"))
sch(Time.parse("2012/5/13 08:00:00"), Time.parse("2012/5/13 16:00:00"))
sch(Time.parse("2012/5/14 08:00:00"), Time.parse("2012/5/14 16:00:00"))
sch(Time.parse("2012/5/15 08:00:00"), Time.parse("2012/5/15 16:00:00"))
sch(Time.parse("2012/5/16 08:00:00"), Time.parse("2012/5/16 16:00:00"))
sch(Time.parse("2012/5/17 08:00:00"), Time.parse("2012/5/17 16:00:00"))
sch(Time.parse("2012/5/18 08:00:00"), Time.parse("2012/5/18 16:00:00"))

#Create some appointments
puts "Creating appointments..."
apt(Time.parse("2012/5/12 13:00:00"), Time.parse("2012/5/12 14:45:00"))
apt(Time.parse("2012/5/13 13:00:00"), Time.parse("2012/5/13 14:45:00"))
apt(Time.parse("2012/5/14 13:00:00"), Time.parse("2012/5/14 14:45:00"))
apt(Time.parse("2012/5/15 13:00:00"), Time.parse("2012/5/15 14:45:00"))
apt(Time.parse("2012/5/16 13:00:00"), Time.parse("2012/5/16 14:45:00"))
apt(Time.parse("2012/5/17 13:00:00"), Time.parse("2012/5/17 14:45:00"))
apt(Time.parse("2012/5/18 13:00:00"), Time.parse("2012/5/18 14:45:00"))
apt(Time.parse("2012/5/19 13:00:00"), Time.parse("2012/5/19 14:45:00"))
