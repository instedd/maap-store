class PatientEntry < ApplicationRecord
  belongs_to :patient
  belongs_to :patient_location, optional: true
end
