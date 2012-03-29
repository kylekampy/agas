# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)

#For creating logins
def l(un, pass)
  return Login.create([{ :username => un, :password => pass, :password_confirmation => pass, :owner_type => "physician" }])[0]
end

def admin(un, pass)
  #todo
  nil
end

#For creating physicians
def phy(f_nm, m_nm, l_nm, specialty, office_num, login)
  Physician.create([{ :firstname => f_nm, :middlename => m_nm, :lastname => l_nm, :specialty => specialty, :office_num => office_num, :login => login}])
end

def pat(f_nm, m_nm, l_nm, phy_id, dob, pharm_id, ins_id)
  #todo
  nil
end

phy("Kyle", "A", "Kamperschroer", "Nose", 62, l("kyle", "password"))
phy("Ben", "A", "Metzger", "Eyes", 23, l("ben", "password"))
phy("Peter", "A", "Bougie", "Ears", 24, l("peter", "password"))
phy("Zhicheng", "A", "Fu", "Mouth", 61, l("fu", "password"))
