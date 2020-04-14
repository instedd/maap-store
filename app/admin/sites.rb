ActiveAdmin.register Site do
                permit_params :name, :address, :ownership, :has_pharmacy, :level,
                  :has_hospital, :has_laboratory, :site_type, :available_beds,
                  :outpatient_by_month, :has_patient_uid, :system_change,
                  :has_infection_disease_department, :infectious_diseases_physicians,
                  :infectious_diseases_nurses, :has_amr_comitee, :meet_frequency,
                  :has_annual_antibiogram, :stew_team, :has_guideline_antibiotics,
                  :has_av_spec_processed, :av_spec_processed, :av_spec_bacterial_grow,
                  :last_visit, :registration_number, :registration_body,
                  :has_cms, :location_type, :contact_name, :contact_designation,
                  :contact_email, :contact_number, :record_keeping_system,
                  :other_services, :is_specialty_hospital,
                  :other_specialties, :served_population_size, :average_patients_per_year,
                  :average_icu_length_of_stay, :patient_uid_in_lab_records,
                  :system_change_details, :av_spec_fungal_processed,
                  :av_spec_fungal_grow, :frequented_community_pharmacies,
                  :community_pharmacies_details, :pharmacy_contact_name,
                  :pharmacy_contact_name, :pharmacy_contact_designation, :pharmacy_contact_email,
                  :pharmacy_contact_number, :pharmacy_records_keeping,
                  :cms_dispatch_destinations,
                  :cms_dispatch_frequency, :cms_collect_stock, :cms_facility_collector_details,
                  services_served_by_lab: [], specialties: [], pharmacy_data_extraction_records: []

  form do |f|
    location_types = ['Urban', 'Peri-urban', 'Rural', 'Unknown', 'Other']
    ownerships = ['Public', 'Private', 'Faith based', 'Military', 'Other']
    levels = ['Primary', 'Secondary', 'Tertiary', 'Unknown', 'Other']
    services = [
      'Medical',
      'Surgical',
      'Pediatric',
      'Maternity',
      'Gynaecological',
      'Neonatal',
      'Burns',
      'Orthopaedic',
      'Geriatric',
      'ENT (Ear, Nose, Throat)',
      'Eye',
      'Intensive care',
      'Emergency',
      'Not mentioned',
      'Other'
    ]

    inputs 'General' do
      input :name, label: 'Facility Name'
      input :last_visit, label: 'Date of visit'
      input :address, label: 'Location / Address'
      input :registration_number, label: 'Facility Registration/Licence No.'
      input :registration_body, label: 'Facility Registration body'

      input :has_hospital, input_html: { class: 'js-non-cms-selector' }
      input :has_laboratory, input_html: { class: 'js-non-cms-selector' }
      input :has_pharmacy, input_html: { class: 'js-non-cms-selector' }
      input :has_cms, label: 'Is CMS', wrapper_html: { class: 'has_cms' }

      input :location_type, as: :select, collection: location_types,
        label: 'What is the setting in which Site is located?',
        input_html: { class: 'js-location_type-selector', data: { not: 'Other', action: 'hide', target: '.location_type' } },
        selected: f.object.location_type.to_s.empty? || location_types.include?(f.object.location_type) ? f.object.location_type : 'Other'

      input :location_type, label: 'Setting other', wrapper_html: { class: 'location_type' }, input_html: { class: 'js-location_type-other' }

      input :ownership, as: :select, collection: ownerships,
                        input_html: { class: 'js-ownership-selector', data: { not: 'Other', action: 'hide', target: '.ownership' } },
                        selected: f.object.ownership.to_s.empty? || ownerships.include?(f.object.ownership) ? f.object.ownership : 'Other'

      input :ownership, label: 'Ownership other', wrapper_html: { class: 'ownership' }, input_html: { class: 'js-ownership-other' }
    end

    inputs 'Hospitals and laboratories', id: 'hospitalAndLaboratoriesPanel' do
      input :level, as: :select, collection: levels,
                        input_html: { class: 'js-level-selector', data: { not: 'Other', action: 'hide', target: '.level' } },
                        selected: f.object.level.to_s.empty? || levels.include?(f.object.level) ? f.object.level : 'Other'

      input :level, label: 'Level other', wrapper_html: { class: 'level' }, input_html: { class: 'js-level-other' }

      input :site_type, as: :select, collection: ['Teaching', 'Non-teaching', 'Unknown'], label: 'Type'

      input :contact_name, label: 'Contact name'
      input :contact_designation, label: 'Contact designation'
      input :contact_email, label: 'Contact email'
      input :contact_number, label: 'Contact number'

      input :record_keeping_system, label: 'What system is used for records keeping in Laboratory and Hospital?'

      input :is_specialty_hospital, label: 'Is this an speciality hospital?'

      input :specialties,
              label: 'Please select the specialities',
              collection: services,
              as: :select, input_html: { multiple: true }

      input :other_specialties, label: 'Other specialties'

      input :served_population_size, label: 'According to National guidelines, what population size should this Hospital serve?'

      input :available_beds, label: 'How many inpatient beds were available at the clinical setting in 2018?'

      input :outpatient_by_month, label: 'What is the average number of outpatients at the clinical setting per month in 2018?'

      input :average_patients_per_year, label: 'What is the average number of patients admitted at the clinical setting in 2018?'

      input :average_icu_length_of_stay, label: 'If the hospital has ICUs, what is the average length of stay/bed occupancy rate for each ICU at the Hospital?'

      input :has_patient_uid, label: 'The clinical setting assigns unique identifier (identification number) to track patients?',
                              input_html: { data: { if: 'not_checked', action: 'hide', target: '.system_change' } }

      input :patient_uid_in_lab_records, label: 'Is this patient unique identification number, captured in the lab record?', wrapper_html: { class: 'system_change' }

      input :system_change, label: 'Has there been any change to this system since 2018?', wrapper_html: { class: 'system_change' }

      input :system_change_details, label: 'If yes, what are the changes (please describe)?', wrapper_html: { class: 'system_change' }

      input :has_infection_disease_department, label: 'The clinical setting has an infectious disease department',
        input_html: { data: { if: 'not_checked', action: 'hide', target: '.has_infection_disease_department' } }

      input :infectious_diseases_physicians, label: 'How many infectious disease (ID) physicians are there in the department', wrapper_html: { class: 'has_infection_disease_department' }
      input :infectious_diseases_nurses, label: 'How many infectious disease (ID) nurses are there in the department', wrapper_html: { class: 'has_infection_disease_department' }

      input :has_amr_comitee, label: 'The clinical setting has an antimicrobial stewardship programme',
        input_html: { data: { if: 'not_checked', action: 'hide', target: '.has_amr_comitee' } }

      input :meet_frequency, label: 'What are the frequency of the meetings', wrapper_html: { class: 'has_amr_comitee' }

      input :has_annual_antibiogram, label: 'Is an annual antibiogram generated?',
        wrapper_html: { class: 'has_amr_comitee' }

      input :stew_team, label: 'What is the composition of the stewardship team', wrapper_html: { class: 'has_amr_comitee' }

      input :has_guideline_antibiotics, label: 'Has guidelines referred for antibiotic prescribing', wrapper_html: { class: 'has_amr_comitee' }

      input :services_served_by_lab,
              label: 'What are the clinical services the laboratory serves?',
              collection: services,
              as: :select, input_html: { multiple: true }

      input :other_services, label: 'Other services'

      input :has_av_spec_processed, label: 'The laboratory has information on average number of specimens processed for culture sensitivity in 2018', input_html: { data: { if: 'not_checked', action: 'hide', target: '.has_av_spec_processed' } }


      input :av_spec_processed, label: 'Average number of specimens processed for bacterial culture in 2018', wrapper_html: { class: 'has_av_spec_processed' }

      input :av_spec_fungal_processed, label: 'Average number of specimens processed for fungal culture in 2018', wrapper_html: { class: 'has_av_spec_processed' }

      input :av_spec_bacterial_grow, label: 'Average number of specimens that yielded bacterial growth and were processed for susceptibility tests, in 2018', wrapper_html: { class: 'has_av_spec_processed' }

      input :av_spec_fungal_grow, label: 'Average number of specimens that yielded fungal pathogen and were processed for antifungal susceptibility testing in 2018', wrapper_html: { class: 'has_av_spec_processed' }
    end

    inputs "Pharmacies", id: 'pharmaciesPanel' do
      input :frequented_community_pharmacies, label: 'Are community pharmacies surrounding your Hospital Pharmacy, often frequented by patients of the Hospital?',
                              input_html: { data: { if: 'not_checked', action: 'hide', target: '.frequented_community_pharmacies' } }

      input :community_pharmacies_details, label: 'Please state name and address of those community pharmacies.', wrapper_html: { class: 'frequented_community_pharmacies' }
    end

    inputs "Pharmacies and CMS", id: 'pharmaciesAndCmsPanel' do
      input :pharmacy_contact_name, label: 'Contact name'
      input :pharmacy_contact_designation, label: 'Contact designation'
      input :pharmacy_contact_email, label: 'Contact email'
      input :pharmacy_contact_number, label: 'Contact mobile number'

      input :pharmacy_records_keeping, as: :select, collection: ['Manual', 'Electronic', 'Both', 'None'], label: 'What system is used for records keeping in pharmacy?'

      input :pharmacy_data_extraction_records,
        label: 'What records can be used for data extraction?',
        collection: ['Sales invoices to customers', 'Prescriptions', 'Purchase records from supplier', 'Others'],
        as: :select, input_html: { multiple: true }
    end

    inputs "CMS", id: 'cmsPanel' do
      input :cms_dispatch_destinations, label: 'To what points/agencies/facilities are the medicines from this facility dispatched to?'
      input :cms_dispatch_frequency, label: 'How frequently are medicines dispatched from this facility to above mentioned points?'

      input :cms_collect_stock, label: 'Do certain kind of facility types collect stock of antibiotics from current facility?',
            input_html: { data: { if: 'not_checked', action: 'hide', target: '.cms_collect_stock' } }

      input :cms_facility_collector_details, label: 'Please specify the type and number of such facilities and frequency of pick up by each facility type', wrapper_html: { class: 'cms_collect_stock' }
    end

    actions
  end

  filter :name
  filter :address
  filter :ownership
  filter :has_pharmacy
  filter :level
  filter :has_hospital
  filter :has_laboratory
  filter :site_type
  filter :available_beds
  filter :outpatient_by_month
  filter :services_served_by_lab
  filter :has_patient_uid
  filter :system_change
  filter :has_infection_disease_department
  filter :infectious_diseases_physicians
  filter :infectious_diseases_nurses
  filter :has_amr_comitee
  filter :meet_frequency
  filter :has_annual_antibiogram
  filter :stew_team
  filter :has_guideline_antibiotics
  filter :has_av_spec_processed
  filter :av_spec_processed
  filter :av_spec_bacterial_grow
  filter :last_visit
  filter :registration_number
  filter :registration_body
  filter :has_cms
  filter :location_type
  filter :contact_name
  filter :contact_designation
  filter :contact_email
  filter :contact_number
  filter :record_keeping_system
  filter :other_services
  filter :is_specialty_hospital
  filter :specialties
  filter :other_specialties
  filter :served_population_size
  filter :average_patients_per_year
  filter :average_icu_length_of_stay
  filter :patient_uid_in_lab_records
  filter :system_change_details
  filter :av_spec_fungal_processed
  filter :av_spec_fungal_grow
  filter :frequented_community_pharmacies
  filter :community_pharmacies_details
  filter :pharmacy_contact_name
  filter :pharmacy_contact_designation
  filter :pharmacy_contact_email
  filter :pharmacy_contact_number
  filter :pharmacy_records_keeping
  filter :pharmacy_data_extraction_records
  filter :cms_dispatch_destinations
  filter :cms_dispatch_frequency
  filter :cms_collect_stock
  filter :cms_facility_collector_details
  filter :created_at
  filter :updated_at
end
