ActiveAdmin.register PatientEntry do
  actions :index, :show

  includes :patient, :patient_location

  csv do
    column :id
    column :patient_id
    column :department
    column :weight
    column :height
    column :chief_complaint
    column :patient_transferred
    column :primary_diagnosis
    column :primary_diagnosis_icd_code
    column :antibiotics_prescribed
    column :patient_was_on_an_indwelling_medical_device
    column :medical_device
    column :infection_acquisition
    column :discharge_diagnostic
    column :discharge_diagnostic_icd_code
    column :patient_outcome_at_discharge
    column :stay_timespan
    column :patient_location_id
    column :pregnancy_status
    column :premature_birth
    column :comorbidities
    column :antibiotic_when
    column :prescribed_antibiotics_list
    column :patient_location_id
    column :created_at
    column :updated_at
  end

  filter :patient_id, label: 'Patient Id', filters: [:equals]
  filter :patient_location
  filter :department
  filter :admission_date
  filter :discharge_date
  filter :weight
  filter :height
  filter :chief_complaint
  filter :patient_transferred
  filter :primary_diagnosis
  filter :primary_diagnosis_icd_code
  filter :antibiotics_prescribed
  filter :patient_was_on_an_indwelling_medical_device, label: 'On indwelling medical device'
  filter :medical_device
  filter :infection_acquisition
  filter :discharge_diagnostic
  filter :discharge_diagnostic_icd_code
  filter :patient_outcome_at_discharge
  filter :stay_timespan
  filter :pregnancy_status
  filter :premature_birth
  filter :comorbidities
  filter :antibiotic_when
  filter :prescribed_antibiotics_list
  filter :age_value
  filter :age_unit
  filter :created_at
  filter :updated_at
end
