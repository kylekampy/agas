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
def phy(f_nm, m_nm, l_nm, specialty, office_num, phones, login)
  return Physician.create([{ :firstname => f_nm, :middlename => m_nm, :lastname => l_nm, :specialty => specialty, :office_num => office_num, :phones => phones, :login => login}])[0]
end

def pat(f_nm, m_nm, l_nm, dob)
  return Patient.create([{ :firstname => f_nm, :middlename => m_nm, :lastname => l_nm, :primary_phy_id => Physician.all[rand(Physician.all.length)].id, :date_of_birth => dob, :pharmacy_id => 1, :insurance_id => 1 }])[0]
end

def apt(start_time, end_time)
  return Appointment.create([{ :start_time => start_time, :end_time => end_time, :phy_id => Physician.all[rand(Physician.all.length)].id, :pat_id => Patient.all[rand(Patient.all.length)].id }])[0]
end

def sch(start_time, end_time)
  return Schedule.create([{ :start_time => start_time, :end_time => end_time, :phy_id => Physician.all[rand(Physician.all.length)].id }])[0]
end

def staff(fn, mn, ln, phones, login)
  return MedicalStaff.create([{ :firstname => fn, :middlename => mn, :lastname => ln, :phones => phones, :doc_id =>  Physician.all[rand(Physician.all.length)].id, :login=> login }])[0]
end

def p(type, number, owner_type)
  return Phone.create([{ :phone_type => type, :phone => number, :owner_type => owner_type }])[0]
end

#---------------- Seed data ----------------#

#Create an admin account
admin("Superuser", l("admin", "password123", "Administrator"))
admin("Root", l("root", "password123", "Administrator"))

#Create some physician accounts
phy("Kyle", "A", "Kamperschroer", "Nose", 62, [p("Work", "111-111-1111", "Physician"), p("Cell", "132-627-5951", "Physician")], l("kyle", "password", "Physician"))
phy("Ben", "A", "Metzger", "Eyes", 23, [p("Work", "222-222-2222", "Physician")], l("ben", "password", "Physician"))
phy("Peter", "A", "Bougie", "Ears", 24, [p("Work", "444-444-4444", "Physician")], l("peter", "password", "Physician"))
phy("Zhicheng", "A", "Fu", "Mouth", 61, [p("Work", "555-555-5555", "Physician")], l("fu", "password", "Physician"))

#Add some medical staff accounts
staff("Dante", "D", "Amaral", [p("Work", "123-123-1231", "Medical Staff")], l("dante", "password", "Medical Staff"))
staff("Leonel", "D", "Marshall", [p("Work", "432-432-4322", "Medical Staff")], l("leonel", "password", "Medical Staff"))
staff("Medical", "D", "Staffer", [p("Work", "999-912-4651", "Medical Staff"), p("Home", "529-322-1111", "Medical Staff")], l("medical", "password", "Medical Staff"))

#Create some patients
pat("John", "B", "Doe", "23-3-1987")
pat("Steve", "B", "Miller", "12-04-1967")
pat("Phil", "B", "Fons", "30-5-1994")

#Create some appointments
apt(Time.parse("2012/3/12 13:00:00"), Time.parse("2012/3/12 14:45:00"))
apt(Time.parse("2012/3/13 13:00:00"), Time.parse("2012/3/12 14:45:00"))
apt(Time.parse("2012/3/14 13:00:00"), Time.parse("2012/3/12 14:45:00"))
apt(Time.parse("2012/3/15 13:00:00"), Time.parse("2012/3/12 14:45:00"))
apt(Time.parse("2012/3/16 13:00:00"), Time.parse("2012/3/12 14:45:00"))
apt(Time.parse("2012/3/17 13:00:00"), Time.parse("2012/3/12 14:45:00"))
apt(Time.parse("2012/3/18 13:00:00"), Time.parse("2012/3/12 14:45:00"))
apt(Time.parse("2012/3/19 13:00:00"), Time.parse("2012/3/12 14:45:00"))

#Create some schedules
sch(Time.parse("2012/3/12 08:00:00"), Time.parse("2012/3/12 18:00:00"))
sch(Time.parse("2012/3/13 08:00:00"), Time.parse("2012/3/12 18:00:00"))
sch(Time.parse("2012/3/14 08:00:00"), Time.parse("2012/3/12 18:00:00"))
sch(Time.parse("2012/3/15 08:00:00"), Time.parse("2012/3/12 18:00:00"))
sch(Time.parse("2012/3/16 08:00:00"), Time.parse("2012/3/12 18:00:00"))
sch(Time.parse("2012/3/17 08:00:00"), Time.parse("2012/3/12 18:00:00"))
sch(Time.parse("2012/3/18 08:00:00"), Time.parse("2012/3/12 18:00:00"))
