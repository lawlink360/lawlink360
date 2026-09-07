import '../models/procedure_model.dart';
import '../models/procedure_step.dart';

final List<ProcedureModel> governmentProcedures = [

  //-----------------------------------------------------------
// Procedure: New CNIC
//-----------------------------------------------------------

ProcedureModel(
  id: "new_cnic",

  categoryId: "government",

  title: "New CNIC",

  overview:
      "A Computerized National Identity Card (CNIC) is an official identity document issued by the National Database and Registration Authority (NADRA) to eligible Pakistani citizens. The CNIC serves as primary proof of identity for legal, financial, governmental, and administrative purposes.",

  governmentDepartment:
      "National Database and Registration Authority (NADRA)",

  eligibility:
      "Every Pakistani citizen who has attained the prescribed age under the applicable law is eligible to apply for a CNIC.",

  requiredDocuments: [
    "Birth Certificate or Matriculation Certificate (where applicable)",
    "B-Form / Child Registration Certificate (if available)",
    "Original CNIC of Parent or Guardian (where required)",
    "Supporting Identity Documents (if applicable)",
  ],

  applicableLaws: [
    "National Database and Registration Authority Ordinance, 2000",
    "NADRA Rules and Regulations",
    "Applicable Government Notifications",
  ],

  importantNotes: [
    "Visit the nearest NADRA Registration Center.",
    "Biometric verification is mandatory.",
    "Ensure personal information is accurate.",
    "Collect the receipt after completing the application.",
  ],

  commonMistakes: [
    "Incorrect spelling of personal information.",
    "Failure to provide supporting documents.",
    "Incomplete biometric verification.",
    "Providing inconsistent family information.",
  ],

  estimatedFee:
      "According to the latest NADRA fee schedule.",

  estimatedTime:
      "Depends upon the selected processing category (Normal, Urgent or Executive).",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Visit NADRA Registration Center",
      description:
          "Visit the nearest NADRA Registration Center with the required documents.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Token Issuance",
      description:
          "Obtain a token and wait for your turn.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Data Entry",
      description:
          "Provide your personal and family information to the registration officer.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Biometric Verification",
      description:
          "Complete fingerprints, photograph and digital signature.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Verification",
      description:
          "Review all entered information carefully before submission.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Fee Payment",
      description:
          "Pay the prescribed application fee.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Application Submission",
      description:
          "Submit the completed application and receive the acknowledgment receipt.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Receive CNIC",
      description:
          "Collect the CNIC after processing or receive it through the selected delivery method.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: CNIC Renewal
//-----------------------------------------------------------

ProcedureModel(
  id: "cnic_renewal",

  categoryId: "government",

  title: "CNIC Renewal",

  overview:
      "CNIC Renewal is the process of obtaining a new Computerized National Identity Card (CNIC) after the expiry of the existing card or when renewal is otherwise required under the applicable NADRA regulations. The renewed CNIC continues to serve as the official proof of identity for legal, governmental, financial, and administrative purposes.",

  governmentDepartment:
      "National Database and Registration Authority (NADRA)",

  eligibility:
      "Any Pakistani citizen whose CNIC has expired or is due for renewal may apply for a renewed CNIC.",

  requiredDocuments: [
    "Original Expired or Expiring CNIC",
    "Supporting Documents (where required)",
    "Original CNIC of Parent or Guardian (if applicable)",
  ],

  applicableLaws: [
    "National Database and Registration Authority Ordinance, 2000",
    "NADRA Rules and Regulations",
    "Applicable Government Notifications",
  ],

  importantNotes: [
    "Apply before the CNIC expires to avoid inconvenience.",
    "Verify all personal information before submission.",
    "Biometric verification is mandatory.",
    "Choose the desired processing category (Normal, Urgent or Executive).",
  ],

  commonMistakes: [
    "Applying with incorrect personal information.",
    "Failure to verify fingerprints.",
    "Selecting an incorrect delivery address.",
    "Not reviewing the printed information before submission.",
  ],

  estimatedFee:
      "According to the latest NADRA fee schedule.",

  estimatedTime:
      "Depends upon the selected processing category (Normal, Urgent or Executive).",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Visit NADRA Registration Center",
      description:
          "Visit the nearest NADRA Registration Center or apply through the available online service where eligible.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Obtain Token",
      description:
          "Receive a token and wait for your turn.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Provide Existing CNIC",
      description:
          "Present your existing CNIC for verification.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Biometric Verification",
      description:
          "Complete fingerprints, photograph and digital signature.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Review Personal Information",
      description:
          "Verify that all personal details are correct before submission.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Pay Application Fee",
      description:
          "Pay the prescribed renewal fee according to the selected processing category.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Submit Application",
      description:
          "Submit the completed renewal application and receive the acknowledgment receipt.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Receive Renewed CNIC",
      description:
          "Collect the renewed CNIC after successful processing or receive it through the selected delivery method.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: CNIC Modification
//-----------------------------------------------------------

ProcedureModel(
  id: "cnic_modification",

  categoryId: "government",

  title: "CNIC Modification",

  overview:
      "CNIC Modification is the process through which a Pakistani citizen requests NADRA to update or correct personal information recorded on an existing Computerized National Identity Card (CNIC). Modifications may include changes permitted under applicable laws and NADRA regulations, such as name, father's or husband's name, marital status, address, date of birth (where legally permissible), or other personal particulars.",

  governmentDepartment:
      "National Database and Registration Authority (NADRA)",

  eligibility:
      "Any Pakistani citizen requiring correction or modification of personal information recorded in the National Identity Database may apply, subject to NADRA's applicable rules and documentary requirements.",

  requiredDocuments: [
    "Original CNIC",
    "Supporting Documents for Requested Modification",
    "Marriage Certificate (where applicable)",
    "Birth Certificate (where applicable)",
    "Court Order (where applicable)",
    "Educational Certificate (where applicable)",
    "Other Supporting Documents required by NADRA",
  ],

  applicableLaws: [
    "National Database and Registration Authority Ordinance, 2000",
    "NADRA Rules and Regulations",
    "Applicable Government Notifications",
  ],

  importantNotes: [
    "Documentary proof is required for every requested modification.",
    "Biometric verification is mandatory.",
    "Only legally permissible modifications are processed.",
    "Verify all updated information before final submission.",
  ],

  commonMistakes: [
    "Providing insufficient documentary evidence.",
    "Incorrect spelling of updated information.",
    "Failure to submit original supporting documents.",
    "Not reviewing the updated information before approval.",
  ],

  estimatedFee:
      "According to the latest NADRA fee schedule and the type of modification requested.",

  estimatedTime:
      "Depends upon the nature of the modification and the selected processing category.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Visit NADRA Registration Center",
      description:
          "Visit the nearest NADRA Registration Center with all supporting documents.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Obtain Token",
      description:
          "Receive a token and wait for your turn.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Submit Existing CNIC",
      description:
          "Provide the existing CNIC along with supporting documents.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Verification of Documents",
      description:
          "The registration officer verifies the supporting documents for the requested modification.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Biometric Verification",
      description:
          "Complete fingerprints, photograph and digital signature.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Review Updated Information",
      description:
          "Carefully verify all modified personal information before submission.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Pay Application Fee",
      description:
          "Deposit the prescribed modification fee according to the selected service category.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Receive Updated CNIC",
      description:
          "Collect the modified CNIC after successful processing or receive it through the selected delivery method.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Family Registration Certificate (FRC)
//-----------------------------------------------------------

ProcedureModel(
  id: "family_registration_certificate",

  categoryId: "government",

  title: "Family Registration Certificate (FRC)",

  overview:
      "A Family Registration Certificate (FRC) is an official document issued by the National Database and Registration Authority (NADRA) that provides details of a person's registered family members as recorded in the National Identity Database. The certificate is commonly required for visa applications, immigration, legal proceedings, inheritance matters, educational admissions, and other official purposes.",

  governmentDepartment:
      "National Database and Registration Authority (NADRA)",

  eligibility:
      "Any Pakistani citizen whose family information is available in the National Identity Database may apply for a Family Registration Certificate (FRC).",

  requiredDocuments: [
    "Original CNIC or NICOP of Applicant",
    "Supporting Family Documents (where required)",
    "Power of Attorney (if applicable)",
    "Other Documents required by NADRA",
  ],

  applicableLaws: [
    "National Database and Registration Authority Ordinance, 2000",
    "NADRA Rules and Regulations",
    "Applicable Government Notifications",
  ],

  importantNotes: [
    "Ensure all family members are properly registered with NADRA.",
    "Verify family information before applying.",
    "The FRC only reflects data available in the National Identity Database.",
    "The certificate may be required by foreign embassies and government departments.",
  ],

  commonMistakes: [
    "Applying before updating family records.",
    "Incorrect family information in NADRA records.",
    "Failure to carry the original CNIC.",
    "Not checking the issued certificate for errors.",
  ],

  estimatedFee:
      "According to the latest NADRA fee schedule.",

  estimatedTime:
      "Usually issued on the same day or within the prescribed processing time, depending on the mode of application.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Visit NADRA Registration Center",
      description:
          "Visit the nearest NADRA Registration Center or use the online facility where available.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Identity Verification",
      description:
          "Present the original CNIC or NICOP for identity verification.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Request FRC",
      description:
          "Request issuance of the Family Registration Certificate.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Verification of Family Record",
      description:
          "The registration officer verifies the family information available in the National Identity Database.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Review Family Details",
      description:
          "Carefully review the displayed family information before final processing.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Pay Prescribed Fee",
      description:
          "Deposit the applicable fee for issuance of the certificate.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Certificate Processing",
      description:
          "NADRA processes the request and prepares the Family Registration Certificate.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Receive FRC",
      description:
          "Receive the Family Registration Certificate and verify all information before leaving.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Child Registration Certificate (CRC / B-Form)
//-----------------------------------------------------------

ProcedureModel(
  id: "child_registration_certificate",

  categoryId: "government",

  title: "Child Registration Certificate (CRC / B-Form)",

  overview:
      "A Child Registration Certificate (CRC), commonly known as the B-Form, is an official identity document issued by the National Database and Registration Authority (NADRA) for Pakistani children below the eligible age for obtaining a Computerized National Identity Card (CNIC). The CRC establishes the child's identity and family linkage and is commonly required for passports, school admissions, immigration, and various governmental services.",

  governmentDepartment:
      "National Database and Registration Authority (NADRA)",

  eligibility:
      "Any Pakistani child below the eligible age for obtaining a CNIC whose birth has been registered may apply for a Child Registration Certificate (CRC).",

  requiredDocuments: [
    "Birth Certificate issued by the Union Council or relevant authority",
    "Original CNIC of Parent or Guardian",
    "Child's Photograph (where applicable)",
    "Supporting Documents (if required)",
  ],

  applicableLaws: [
    "National Database and Registration Authority Ordinance, 2000",
    "NADRA Rules and Regulations",
    "Applicable Government Notifications",
  ],

  importantNotes: [
    "The child's birth should be registered before applying.",
    "Parents' information must match NADRA records.",
    "Carry original documents during the application process.",
    "Verify all information before final submission.",
  ],

  commonMistakes: [
    "Mismatch between parents' CNIC records.",
    "Unregistered birth certificate.",
    "Incorrect spelling of the child's name.",
    "Failure to provide original supporting documents.",
  ],

  estimatedFee:
      "According to the latest NADRA fee schedule.",

  estimatedTime:
      "Depends upon the selected processing category and verification requirements.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Visit NADRA Registration Center",
      description:
          "Visit the nearest NADRA Registration Center with the required documents.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Identity Verification",
      description:
          "Present the original CNIC of the parent or guardian for verification.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Submit Birth Certificate",
      description:
          "Provide the child's birth certificate and other required supporting documents.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Data Entry",
      description:
          "The registration officer enters the child's information into the National Identity Database.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Review Information",
      description:
          "Carefully verify the child's personal and family information before submission.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Pay Prescribed Fee",
      description:
          "Deposit the applicable fee according to the selected processing category.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Application Submission",
      description:
          "Submit the completed application and receive the acknowledgment receipt.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Receive CRC / B-Form",
      description:
          "Collect the Child Registration Certificate after successful processing and verify all printed information.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Domicile Certificate
//-----------------------------------------------------------

ProcedureModel(
  id: "domicile_certificate",

  categoryId: "government",

  title: "Domicile Certificate",

  overview:
      "A Domicile Certificate is an official document issued by the competent district administration certifying that a person is a permanent resident of a particular district or province. It is commonly required for educational admissions, government employment, recruitment, scholarships, and various legal and administrative purposes.",

  governmentDepartment:
      "Deputy Commissioner (DC) Office / District Administration",

  eligibility:
      "Any Pakistani citizen who permanently resides in the concerned district or province and fulfills the applicable legal requirements may apply for a Domicile Certificate.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC",
    "Copy of CNIC",
    "Permanent Residence Proof",
    "Family Registration Certificate (where applicable)",
    "Educational Certificate (where applicable)",
    "Passport-size Photographs",
    "Affidavit (where required)",
    "Application Form",
  ],

  applicableLaws: [
    "Relevant Provincial Local Government Laws",
    "Provincial Domicile Rules",
    "Applicable Government Notifications",
  ],

  importantNotes: [
    "Apply only in the district of permanent residence.",
    "Provide genuine residential information.",
    "Requirements may differ slightly among provinces.",
    "Verify all personal information before submission.",
  ],

  commonMistakes: [
    "Submitting incomplete residence proof.",
    "Incorrect district information.",
    "Failure to attach required affidavits.",
    "Providing inconsistent personal records.",
  ],

  estimatedFee:
      "According to the applicable provincial government fee schedule.",

  estimatedTime:
      "Usually 7–30 working days depending upon the province and verification process.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Collect Required Documents",
      description:
          "Gather CNIC, residence proof, photographs and other required supporting documents.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Complete Application Form",
      description:
          "Fill in the domicile application form accurately.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Visit the DC Office",
      description:
          "Submit the application to the Deputy Commissioner Office or designated facilitation center.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Document Verification",
      description:
          "The concerned authority verifies the submitted documents.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Residence Verification",
      description:
          "Residence verification may be conducted where required.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Pay Prescribed Fee",
      description:
          "Deposit the applicable government fee.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Application Processing",
      description:
          "The district administration processes the domicile application.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Receive Domicile Certificate",
      description:
          "Collect the Domicile Certificate and verify all printed information.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Character Certificate
//-----------------------------------------------------------

ProcedureModel(
  id: "character_certificate",

  categoryId: "government",

  title: "Character Certificate",

  overview:
      "A Character Certificate is an official document issued by the competent authority certifying, to the extent of available records, that an individual has maintained satisfactory conduct or has no adverse record for the purpose for which the certificate is issued. It is commonly required for employment, educational admissions, immigration, licensing, and other official purposes.",

  governmentDepartment:
      "District Police Office / District Administration (as applicable)",

  eligibility:
      "Any Pakistani citizen requiring proof of good character for a lawful purpose may apply, subject to verification by the competent authority.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC",
    "Copy of CNIC",
    "Recent Passport-size Photographs",
    "Application Form",
    "Proof of Residence",
    "Recommendation Letter (where required)",
    "Purpose Letter (if applicable)",
  ],

  applicableLaws: [
    "Relevant Provincial Police Rules",
    "Applicable Government Notifications",
    "Relevant Administrative Instructions",
  ],

  importantNotes: [
    "Provide accurate personal information.",
    "Police verification may be conducted before issuance.",
    "Requirements may vary between provinces.",
    "The certificate is generally issued for a specific purpose.",
  ],

  commonMistakes: [
    "Submitting incomplete application forms.",
    "Providing incorrect residential information.",
    "Failure to attach required documents.",
    "Applying before updating CNIC information.",
  ],

  estimatedFee:
      "According to the applicable provincial government fee schedule.",

  estimatedTime:
      "Usually 3–15 working days depending on the verification process.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Collect Required Documents",
      description:
          "Gather CNIC, photographs, residence proof and other supporting documents.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Complete Application Form",
      description:
          "Fill out the prescribed application form accurately.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Submit Application",
      description:
          "Submit the application to the concerned Police Office or designated authority.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Document Verification",
      description:
          "The authority verifies the submitted documents.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Police Verification",
      description:
          "Background verification is conducted where required.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Pay Prescribed Fee",
      description:
          "Deposit the applicable government fee, if any.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Application Processing",
      description:
          "The competent authority reviews and processes the application.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Receive Character Certificate",
      description:
          "Collect the Character Certificate and verify all printed information before leaving.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Birth Certificate
//-----------------------------------------------------------

ProcedureModel(
  id: "birth_certificate",

  categoryId: "government",

  title: "Birth Certificate",

  overview:
      "A Birth Certificate is an official civil registration document issued by the competent local authority recording the birth of a child. It serves as legal proof of birth, identity, parentage, place of birth, and date of birth, and is commonly required for obtaining a Child Registration Certificate (CRC/B-Form), passport, educational admissions, inheritance matters, and other legal and administrative purposes.",

  governmentDepartment:
      "Union Council / Municipal Committee / Cantonment Board (as applicable)",

  eligibility:
      "The parent, legal guardian, or an authorized representative of a child whose birth has occurred within the jurisdiction of the concerned authority may apply for a Birth Certificate in accordance with the applicable law.",

  requiredDocuments: [
    "Hospital Birth Record or Birth Notification",
    "Original CNIC of Parent(s) or Guardian",
    "Child Registration Form (where applicable)",
    "Marriage Certificate (where applicable)",
    "Application Form",
    "Supporting Documents required by the concerned authority",
  ],

  applicableLaws: [
    "Provincial Births, Deaths and Marriages Registration Laws",
    "Local Government Laws",
    "Applicable Government Notifications",
  ],

  importantNotes: [
    "Register the birth as early as possible.",
    "Ensure the child's name and parents' details are accurate.",
    "Keep the original certificate in a safe place.",
    "Requirements may vary among provinces and local authorities.",
  ],

  commonMistakes: [
    "Delay in birth registration.",
    "Incorrect spelling of names.",
    "Mismatch between parents' CNIC information.",
    "Submitting incomplete supporting documents.",
  ],

  estimatedFee:
      "According to the applicable local government fee schedule.",

  estimatedTime:
      "Usually issued within a few working days, depending on the local authority and verification process.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Collect Required Documents",
      description:
          "Gather the hospital birth record, parents' CNICs and other required documents.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Complete Application Form",
      description:
          "Fill in the prescribed Birth Registration application form.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Submit Application",
      description:
          "Submit the application to the concerned Union Council, Municipal Committee or Cantonment Board.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Document Verification",
      description:
          "The authority verifies the submitted documents and birth information.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Registration of Birth",
      description:
          "The birth is officially recorded in the civil registration system.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Pay Prescribed Fee",
      description:
          "Deposit the applicable registration fee, where required.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Certificate Preparation",
      description:
          "The Birth Certificate is prepared after successful verification.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Receive Birth Certificate",
      description:
          "Collect the Birth Certificate and verify all information before leaving.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Death Certificate
//-----------------------------------------------------------

ProcedureModel(
  id: "death_certificate",

  categoryId: "government",

  title: "Death Certificate",

  overview:
      "A Death Certificate is an official civil registration document issued by the competent local authority recording the death of a person. It serves as legal proof of death and is commonly required for succession matters, inheritance, pension claims, insurance claims, bank account closure, property transfer, and other legal and administrative proceedings.",

  governmentDepartment:
      "Union Council / Municipal Committee / Cantonment Board (as applicable)",

  eligibility:
      "A legal heir, close family member, authorized representative, or other person permitted under the applicable law may apply for registration of a death and issuance of a Death Certificate.",

  requiredDocuments: [
    "Medical Death Certificate or Hospital Death Record",
    "Original CNIC of the Deceased (if available)",
    "CNIC of Applicant",
    "Proof of Relationship (where applicable)",
    "Application Form",
    "Supporting Documents required by the concerned authority",
  ],

  applicableLaws: [
    "Provincial Births, Deaths and Marriages Registration Laws",
    "Local Government Laws",
    "Applicable Government Notifications",
  ],

  importantNotes: [
    "Register the death as soon as possible.",
    "Ensure the deceased's personal information is accurate.",
    "The Death Certificate is required for many legal proceedings.",
    "Requirements may vary among provinces and local authorities.",
  ],

  commonMistakes: [
    "Delay in death registration.",
    "Incorrect CNIC or personal details of the deceased.",
    "Failure to provide medical death documentation.",
    "Submitting incomplete supporting documents.",
  ],

  estimatedFee:
      "According to the applicable local government fee schedule.",

  estimatedTime:
      "Usually issued within a few working days, depending upon verification by the concerned authority.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Collect Required Documents",
      description:
          "Gather the medical death certificate, CNICs and all supporting documents.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Complete Application Form",
      description:
          "Fill in the prescribed Death Registration application form accurately.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Submit Application",
      description:
          "Submit the application to the concerned Union Council, Municipal Committee or Cantonment Board.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Verification of Documents",
      description:
          "The authority verifies the death record and supporting documents.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Death Registration",
      description:
          "The death is officially recorded in the civil registration system.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Pay Prescribed Fee",
      description:
          "Deposit the applicable registration fee where required.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Certificate Preparation",
      description:
          "The Death Certificate is prepared after successful verification.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Receive Death Certificate",
      description:
          "Collect the Death Certificate and verify all printed information before leaving.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Marriage Registration Certificate
//-----------------------------------------------------------

ProcedureModel(
  id: "marriage_registration_certificate",

  categoryId: "government",

  title: "Marriage Registration Certificate",

  overview:
      "A Marriage Registration Certificate is an official document issued by the competent Union Council or relevant local authority confirming that a marriage has been duly registered in accordance with the applicable law. The certificate serves as legal proof of marriage and is commonly required for immigration, visa applications, family registration, inheritance matters, banking, insurance, and other legal and administrative purposes.",

  governmentDepartment:
      "Union Council / Local Government / Nikah Registrar",

  eligibility:
      "Either spouse or an authorized representative may apply for a Marriage Registration Certificate after the marriage has been validly solemnized and registered in accordance with the applicable law.",

  requiredDocuments: [
    "Original Nikahnama",
    "CNIC of Husband",
    "CNIC of Wife",
    "Copies of CNICs",
    "Passport-size Photographs (where required)",
    "Application Form",
    "Supporting Documents (if applicable)",
  ],

  applicableLaws: [
    "Muslim Family Laws Ordinance, 1961",
    "Provincial Local Government Laws",
    "Relevant Marriage Registration Rules",
    "Applicable Government Notifications",
  ],

  importantNotes: [
    "Ensure that the Nikahnama has been properly registered.",
    "Verify all personal information before submission.",
    "Keep certified copies for future legal use.",
    "Requirements may vary depending upon the local authority.",
  ],

  commonMistakes: [
    "Submitting an unregistered Nikahnama.",
    "Mismatch between CNIC information and Nikahnama.",
    "Failure to attach required documents.",
    "Incorrect spelling of names or dates.",
  ],

  estimatedFee:
      "According to the applicable local government fee schedule.",

  estimatedTime:
      "Usually issued within a few working days after successful verification.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Collect Required Documents",
      description:
          "Gather the original Nikahnama, CNICs and all supporting documents.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Complete Application Form",
      description:
          "Fill in the prescribed application form accurately.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Submit Application",
      description:
          "Submit the application to the concerned Union Council or authorized office.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Document Verification",
      description:
          "The authority verifies the Nikahnama and supporting documents.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Marriage Record Verification",
      description:
          "The marriage record is verified from the official register.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Pay Prescribed Fee",
      description:
          "Deposit the applicable government fee.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Certificate Preparation",
      description:
          "The Marriage Registration Certificate is prepared after successful verification.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Receive Certificate",
      description:
          "Collect the Marriage Registration Certificate and verify all printed information before leaving.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Arms License
//-----------------------------------------------------------

ProcedureModel(
  id: "arms_license",

  categoryId: "government",

  title: "Arms License",

  overview:
      "An Arms License is an official authorization issued by the competent government authority permitting an eligible person to possess or carry a firearm in accordance with the applicable laws and licensing policies. The licensing process involves verification of eligibility, background checks, and compliance with all legal requirements.",

  governmentDepartment:
      "Provincial Home Department / District Administration / Competent Licensing Authority",

  eligibility:
      "Any eligible Pakistani citizen who fulfills the requirements prescribed under the applicable arms laws and government policies may apply for an Arms License.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC",
    "Copy of CNIC",
    "Passport-size Photographs",
    "Completed Application Form",
    "Proof of Residence",
    "Medical Certificate (where required)",
    "Character Certificate or Police Verification (where applicable)",
    "Any other document required by the Licensing Authority",
  ],

  applicableLaws: [
    "Applicable Provincial Arms Rules",
    "Relevant Federal and Provincial Government Notifications",
    "Licensing Policies issued by the Competent Authority",
  ],

  importantNotes: [
    "Eligibility requirements vary according to applicable laws and provincial policies.",
    "Background verification may be mandatory.",
    "Providing false information may result in rejection or legal action.",
    "License holders must comply with all applicable firearm laws.",
  ],

  commonMistakes: [
    "Submitting incomplete documentation.",
    "Providing incorrect personal information.",
    "Ignoring eligibility requirements.",
    "Failure to complete verification requirements.",
  ],

  estimatedFee:
      "According to the applicable government fee schedule.",

  estimatedTime:
      "Depends upon verification, approval process and applicable provincial procedures.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Confirm Eligibility",
      description:
          "Review the applicable eligibility requirements before applying.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Collect Required Documents",
      description:
          "Gather all required documents and supporting evidence.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Complete Application",
      description:
          "Fill out the prescribed Arms License application form accurately.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Submit Application",
      description:
          "Submit the application before the competent licensing authority.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Verification Process",
      description:
          "The concerned authority conducts document, background and other required verifications.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Pay Prescribed Fee",
      description:
          "Deposit the applicable government fee.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Decision by Licensing Authority",
      description:
          "The competent authority considers the application in accordance with the applicable law.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "License Issuance",
      description:
          "If approved, the Arms License is issued subject to applicable terms and conditions.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: E-Stamp / Stamp Paper
//-----------------------------------------------------------

ProcedureModel(
  id: "e_stamp_stamp_paper",

  categoryId: "government",

  title: "E-Stamp / Stamp Paper",

  overview:
      "An E-Stamp or Stamp Paper is an officially issued stamp instrument used for executing legal documents, agreements, affidavits, declarations, powers of attorney, property transactions, contracts, and other instruments that require payment of stamp duty under the applicable law. E-Stamping provides a secure and verifiable alternative to traditional stamp papers where implemented.",

  governmentDepartment:
      "Board of Revenue / Excise, Taxation & Revenue Department / Authorized E-Stamp Vendor",

  eligibility:
      "Any individual, company, partnership, organization, or legal entity requiring execution of a document subject to stamp duty may obtain an E-Stamp or Stamp Paper.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC",
    "Copy of CNIC",
    "Details of the Transaction",
    "Amount of Stamp Duty",
    "Application Form (where applicable)",
    "Supporting Documents (if required)",
  ],

  applicableLaws: [
    "Stamp Act, 1899",
    "Provincial Stamp Rules",
    "Applicable Board of Revenue Notifications",
    "Relevant Government Policies",
  ],

  importantNotes: [
    "Purchase the correct value of stamp duty.",
    "Use only authorized vendors or official e-stamping services.",
    "Verify the serial number or e-stamp reference.",
    "Keep the original stamp document in a safe place.",
  ],

  commonMistakes: [
    "Purchasing an incorrect denomination.",
    "Using unauthorized stamp papers.",
    "Incorrect purchaser or party details.",
    "Using expired or invalid stamp instruments where prohibited.",
  ],

  estimatedFee:
      "Stamp duty according to the applicable law and nature of the transaction.",

  estimatedTime:
      "Usually issued immediately after successful payment and verification.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Determine Stamp Duty",
      description:
          "Identify the applicable stamp duty according to the nature of the legal document.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Visit Authorized Vendor",
      description:
          "Visit an authorized e-stamp center or licensed stamp vendor.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Provide Transaction Details",
      description:
          "Provide details of the parties, document type and stamp value.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Identity Verification",
      description:
          "Present the required identity documents for verification.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Pay Stamp Duty",
      description:
          "Pay the applicable stamp duty and service charges.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Issue of E-Stamp / Stamp Paper",
      description:
          "Receive the officially issued e-stamp certificate or stamp paper.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Verify Document Details",
      description:
          "Check the stamp number, purchaser details and stamp value for accuracy.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Use for Legal Transaction",
      description:
          "Execute the legal document using the issued e-stamp or stamp paper in accordance with the applicable law.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Notary & Attestation
//-----------------------------------------------------------

ProcedureModel(
  id: "notary_attestation",

  categoryId: "government",

  title: "Notary & Attestation",

  overview:
      "Notary & Attestation is the legal process through which signatures, affidavits, declarations, copies of documents, agreements, and other legal instruments are authenticated or certified by a Notary Public or the competent government authority. Attested documents are commonly required for court proceedings, banking, immigration, educational admissions, employment, property transactions, and other official purposes.",

  governmentDepartment:
      "Notary Public / Oath Commissioner / Relevant Government Department",

  eligibility:
      "Any individual, company, organization, or legal representative requiring authentication or certification of a lawful document may apply for notary or attestation services.",

  requiredDocuments: [
    "Original Document",
    "Photocopies of the Document",
    "Original CNIC or Smart CNIC",
    "Copy of CNIC",
    "Passport-size Photograph (where required)",
    "Supporting Documents (if applicable)",
  ],

  applicableLaws: [
    "Notaries Ordinance, 1961",
    "Notaries Rules",
    "Oaths Act",
    "Applicable Government Notifications",
  ],

  importantNotes: [
    "Carry the original documents for verification.",
    "Do not sign documents before the Notary unless instructed.",
    "Ensure all document details are complete before attestation.",
    "Some documents may require additional departmental verification.",
  ],

  commonMistakes: [
    "Submitting unsigned or incomplete documents.",
    "Bringing photocopies without originals.",
    "Incorrect identity information.",
    "Obtaining attestation from an unauthorized person.",
  ],

  estimatedFee:
      "According to the prescribed notarial or government fee schedule.",

  estimatedTime:
      "Usually completed on the same day, subject to document verification.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Prepare Documents",
      description:
          "Collect the original documents along with the required photocopies.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Visit the Competent Authority",
      description:
          "Visit the Notary Public, Oath Commissioner or relevant government office.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Identity Verification",
      description:
          "Present your original CNIC or other required identity documents.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Document Examination",
      description:
          "The officer verifies the authenticity and completeness of the documents.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Sign Before the Authority",
      description:
          "Where required, sign the document in the presence of the authorized official.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Pay Prescribed Fee",
      description:
          "Deposit the applicable notarial or attestation fee.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Attestation Process",
      description:
          "The competent authority signs, seals, and attests the document.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Receive Attested Documents",
      description:
          "Collect the attested documents and verify that all signatures, seals, and details are correct.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Succession Certificate (NADRA Facilitation)
//-----------------------------------------------------------

ProcedureModel(
  id: "succession_certificate",

  categoryId: "government",

  title: "Succession Certificate (NADRA Facilitation)",

  overview:
      "A Succession Certificate is an official certificate issued through the legal mechanism prescribed under Pakistani law, with NADRA providing facilitation in the issuance process where applicable. The certificate establishes the legal heirs entitled to inherit the movable assets of a deceased person, such as bank accounts, investments, pensions, shares, vehicles, and other financial assets.",

  governmentDepartment:
      "NADRA Facilitation Center / Competent Authority",

  eligibility:
      "Any legal heir of a deceased person may apply for a Succession Certificate in accordance with the applicable law.",

  requiredDocuments: [
    "Death Certificate of the Deceased",
    "Original CNIC of the Applicant",
    "CNICs of All Legal Heirs",
    "Family Registration Certificate (FRC)",
    "Details of Movable Assets",
    "Affidavit or Declaration (where required)",
    "Supporting Documents required by the Competent Authority",
  ],

  applicableLaws: [
    "Letters of Administration and Succession Certificates Act, 2021",
    "National Database and Registration Authority Ordinance, 2000",
    "Applicable Government Notifications",
  ],

  importantNotes: [
    "All legal heirs should be correctly identified.",
    "Ensure the Family Registration Certificate is updated.",
    "Provide complete details of movable assets.",
    "False information may result in legal consequences.",
  ],

  commonMistakes: [
    "Incomplete information regarding legal heirs.",
    "Failure to disclose all movable assets.",
    "Mismatch between NADRA records and submitted documents.",
    "Submitting incomplete supporting documents.",
  ],

  estimatedFee:
      "According to the applicable government fee schedule.",

  estimatedTime:
      "Depends upon verification, publication requirements (if applicable), objections, and approval by the competent authority.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Collect Required Documents",
      description:
          "Gather the Death Certificate, CNICs, FRC and details of the deceased's movable assets.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Prepare Application",
      description:
          "Complete the prescribed Succession Certificate application.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Submit Application",
      description:
          "Submit the application through the prescribed NADRA facilitation process or before the competent authority.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Verification of Legal Heirs",
      description:
          "The authorities verify the identity of the deceased and all legal heirs.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Verification of Assets",
      description:
          "The declared movable assets are verified according to the applicable procedure.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Pay Prescribed Fee",
      description:
          "Deposit the applicable government fee.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Processing & Decision",
      description:
          "The competent authority processes the application after completing all required legal formalities.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Receive Succession Certificate",
      description:
          "Receive the Succession Certificate and verify all legal heir and asset details before use.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: National Tax Number (NTN) Registration
//-----------------------------------------------------------

ProcedureModel(
  id: "ntn_registration",

  categoryId: "government",

  title: "National Tax Number (NTN) Registration",

  overview:
      "National Tax Number (NTN) Registration is the process through which an eligible individual, business, company, association, or other taxable entity registers with the Federal Board of Revenue (FBR) and obtains a National Tax Number. NTN registration enables taxpayers to fulfill their tax obligations, file income tax returns, conduct business with government departments, and comply with Pakistan's tax laws.",

  governmentDepartment:
      "Federal Board of Revenue (FBR)",

  eligibility:
      "Any individual, sole proprietor, partnership firm, company, association of persons, or other taxable entity required or intending to register under the applicable tax laws may apply for NTN registration.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC",
    "Copy of CNIC",
    "Mobile Number registered in Applicant's Name",
    "Active Email Address",
    "Proof of Business Address (where applicable)",
    "Business Registration Documents (where applicable)",
    "Bank Account Details (where applicable)",
    "Supporting Documents required by FBR",
  ],

  applicableLaws: [
    "Income Tax Ordinance, 2001",
    "Federal Board of Revenue Rules",
    "Applicable Government Notifications",
  ],

  importantNotes: [
    "Provide accurate personal and business information.",
    "Use an active email address and mobile number.",
    "Maintain updated taxpayer information.",
    "Timely filing of tax returns is required after registration.",
  ],

  commonMistakes: [
    "Providing incorrect CNIC or contact information.",
    "Failure to update taxpayer profile.",
    "Submitting incomplete business details.",
    "Using inactive email addresses or mobile numbers.",
  ],

  estimatedFee:
      "Government registration is generally free; professional service charges may apply if using a tax consultant.",

  estimatedTime:
      "Usually completed after successful online verification and profile creation, subject to FBR processing.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Create Taxpayer Account",
      description:
          "Create a taxpayer profile through the prescribed FBR registration system.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Enter Personal Information",
      description:
          "Provide your CNIC, contact details and other required personal information.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Provide Business Details",
      description:
          "Enter business information where applicable.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Upload Supporting Documents",
      description:
          "Upload or submit the required supporting documents.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Verification Process",
      description:
          "The Federal Board of Revenue verifies the submitted information.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Profile Confirmation",
      description:
          "Review and confirm all taxpayer profile information.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Registration Approval",
      description:
          "The registration request is processed and approved after successful verification.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Receive NTN",
      description:
          "Receive the National Tax Number and maintain compliance with applicable tax laws.",
    ),
  ],
),

];