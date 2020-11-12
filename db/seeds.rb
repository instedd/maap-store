user = User.find_or_create_by(email: 'example@maap.tld') do |u|
  u.password = 'password'
end
AdminUser.create(email: 'admin@maap.tld', password: 'password', password_confirmation: 'password')
AdminUser.create(email: 'viewer@maap.tld', password: 'password', password_confirmation: 'password', role: :viewer)

if Rails.env.development?
  FactoryBot::create_list(:site, [0, 10 - Site.count].max)
  FactoryBot::create_list(:antibiotic_consumption_stat, [0, 10 - AntibioticConsumptionStat.count].max)
end

# Patch for devise token auth model.
# It's only needed if you are in the context of the initial migration for uses
User.find(user.id).update(tokens: nil)

path = Rails.root.join('lib', 'seeds', "Documents.csv")

CSV.foreach(
  Rails.root.join('db', 'seeds', "specimen_source.csv"),
  headers: true
) do |row|
  SpecimenSource.find_or_create_by(
    name: row['name']
  )
end

CSV.foreach(
  Rails.root.join('db', 'seeds', "culture_type.csv"),
  headers: true
) do |row|
  CultureType.find_or_create_by(
    name: row['name']
  )
end

CSV.foreach(
  Rails.root.join('db', 'seeds', "antibiotics.csv"),
  headers: true
) do |row|
  Antibiotic.find_or_create_by(
    name: row['name'].split.map(&:capitalize).join(' '),
    strength_value: row['strength_value'],
    strength_unit: row['strength_unit'],
    form: (row['form']||"").split.map(&:capitalize).join(' '),
    pack_size: (row['pack_size']||"").split.map(&:capitalize).join(' '),
    brand: (row['brand']||"").split.map(&:capitalize).join(' ')
  )
end

[
  "Medical",
  "Surgical",
  "Pediatric",
  "Maternity and Gynaecological",
  "Intensive Care",
  "Emergency Services",
  "Not mentioned"
].each do |service|
  ClinicalService.find_or_create_by(name: service)
end

[
  "Inpatient/Ward",
  "ICU",
  "Outpatient",
  "Emergency",
  "Not mentioned",
].each do |location|
  PatientLocation.find_or_create_by(name: location)
end
