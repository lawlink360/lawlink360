import '../models/procedure_model.dart';
import '../models/procedure_step.dart';

final List<ProcedureModel> registrationProcedures = [

  //-----------------------------------------------------------
// Procedure: Birth Registration
//-----------------------------------------------------------

ProcedureModel(
  id: "birth_registration",

  categoryId: "registration",

  title: "Birth Registration",

  overview:
      "Birth Registration is the legal process of recording the birth of a child with the relevant Union Council, Municipal Committee, Cantonment Board, or other authorized local government authority. Upon successful registration, an official Birth Certificate is issued, providing legal proof of the child's birth, identity, date of birth, place of birth, and parentage.",

  governmentDepartment:
      "Local Government Department / Union Council / Municipal Committee / Cantonment Board",

  eligibility:
      "The parents, legal guardian, or any person authorized under the applicable law may apply for the registration of a child's birth within the prescribed time.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC of Parent(s) or Guardian",
    "Hospital Birth Certificate or Birth Notification (if available)",
    "Child's B-Form (where applicable)",
    "Nikah Nama or Marriage Certificate (where applicable)",
    "Prescribed Application Form",
    "Government Prescribed Fee (where applicable)",
  ],

  applicableLaws: [
    "Local Government Act (Applicable Province)",
    "Births, Deaths and Marriages Registration Laws",
    "Applicable Local Government Rules",
  ],

  importantNotes: [
    "Register the birth as early as possible after the child's birth.",
    "Late registration may require additional verification or approval.",
    "Ensure all names and dates are entered correctly.",
    "Keep the Birth Certificate safely for future educational and identification purposes.",
  ],

  commonMistakes: [
    "Incorrect spelling of names.",
    "Providing an incorrect date or place of birth.",
    "Submitting incomplete parent information.",
    "Delaying registration beyond the prescribed period.",
  ],

  estimatedFee:
      "As prescribed by the relevant local government authority.",

  estimatedTime:
      "Usually completed after document verification and approval by the registration authority.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Collect Required Documents",
      description:
          "Gather the birth notification, parents' CNICs, and other required documents.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Complete Application",
      description:
          "Fill in the prescribed Birth Registration application form accurately.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Submit Application",
      description:
          "Submit the application together with all supporting documents and the prescribed fee, where applicable.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Verification",
      description:
          "The registration authority verifies the birth details and supporting documents.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Record Birth",
      description:
          "The child's birth is entered into the official civil registration records.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Approval",
      description:
          "The competent authority approves the birth registration.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Issue Birth Certificate",
      description:
          "The official Birth Certificate is prepared and issued.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Receive Birth Certificate",
      description:
          "Collect the Birth Certificate and keep it safely for future use.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Death Registration
//-----------------------------------------------------------

ProcedureModel(
  id: "death_registration",

  categoryId: "registration",

  title: "Death Registration",

  overview:
      "Death Registration is the legal process of recording the death of a person with the relevant Union Council, Municipal Committee, Cantonment Board, or other authorized local government authority. Upon successful registration, an official Death Certificate is issued, which serves as legal proof of death and is required for inheritance matters, pension claims, insurance claims, bank account closure, and other legal proceedings.",

  governmentDepartment:
      "Local Government Department / Union Council / Municipal Committee / Cantonment Board",

  eligibility:
      "A close family member, legal heir, guardian, or any person authorized under the applicable law may apply for the registration of a person's death.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC of the Deceased (if available)",
    "Original CNIC or Smart CNIC of the Applicant",
    "Medical Death Certificate or Hospital Death Report",
    "Burial Permit or Burial Record (where applicable)",
    "Prescribed Application Form",
    "Government Prescribed Fee (where applicable)",
  ],

  applicableLaws: [
    "Local Government Act (Applicable Province)",
    "Births, Deaths and Marriages Registration Laws",
    "Applicable Local Government Rules",
  ],

  importantNotes: [
    "Register the death as soon as possible after its occurrence.",
    "Ensure that the deceased's personal information is entered accurately.",
    "The Death Certificate is required for many legal and financial matters.",
    "Keep multiple certified copies of the Death Certificate for future use.",
  ],

  commonMistakes: [
    "Incorrect spelling of the deceased's name.",
    "Providing an incorrect date or place of death.",
    "Submitting incomplete supporting documents.",
    "Delaying registration beyond the prescribed period.",
  ],

  estimatedFee:
      "As prescribed by the relevant local government authority.",

  estimatedTime:
      "Usually completed after verification of documents and approval by the registration authority.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Collect Required Documents",
      description:
          "Gather the medical death certificate, applicant's CNIC, and all other required documents.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Complete Application",
      description:
          "Fill in the prescribed Death Registration application form accurately.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Submit Application",
      description:
          "Submit the application together with all supporting documents and the prescribed fee, where applicable.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Verification",
      description:
          "The registration authority verifies the identity of the deceased and the supporting documents.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Record Death",
      description:
          "The death is entered into the official civil registration records.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Approval",
      description:
          "The competent authority approves the death registration.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Issue Death Certificate",
      description:
          "The official Death Certificate is prepared and issued.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Receive Death Certificate",
      description:
          "Collect the Death Certificate and retain it safely for future legal and administrative purposes.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Marriage Registration
//-----------------------------------------------------------

ProcedureModel(
  id: "marriage_registration",

  categoryId: "registration",

  title: "Marriage Registration",

  overview:
      "Marriage Registration is the legal process through which a valid marriage is officially recorded with the competent registration authority. Upon successful registration, the marriage becomes part of the official public record, and a Marriage Registration Certificate may be issued as legal proof of the marriage for use in government, judicial, immigration, banking, inheritance, and other legal matters.",

  governmentDepartment:
      "Union Council / Local Government Department / Nikah Registrar (where authorized)",

  eligibility:
      "A marriage solemnized in accordance with the applicable law may be registered by the spouses or any person authorized under the relevant legal provisions.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC of Husband",
    "Original CNIC or Smart CNIC of Wife",
    "Original Nikah Nama",
    "CNICs of Witnesses (where required)",
    "Passport-sized Photographs (where applicable)",
    "Prescribed Application Form",
    "Government Prescribed Registration Fee",
  ],

  applicableLaws: [
    "Muslim Family Laws Ordinance, 1961 (where applicable)",
    "Local Government Act (Applicable Province)",
    "Relevant Marriage Registration Laws",
  ],

  importantNotes: [
    "Ensure that all information in the Nikah Nama is accurate before registration.",
    "Register the marriage promptly after the Nikah ceremony.",
    "Keep certified copies of the Marriage Certificate for future legal use.",
    "Different procedures may apply depending on the applicable personal law.",
  ],

  commonMistakes: [
    "Incorrect CNIC numbers.",
    "Spelling errors in the names of the spouses.",
    "Submitting an incomplete Nikah Nama.",
    "Failure to register the marriage within the prescribed period.",
  ],

  estimatedFee:
      "As prescribed by the relevant local government authority.",

  estimatedTime:
      "Usually completed after verification of documents and approval by the competent authority.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Collect Required Documents",
      description:
          "Gather the Nikah Nama, CNICs of both spouses, witness details, and other required documents.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Complete Application",
      description:
          "Fill in the prescribed Marriage Registration application accurately.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Submit Application",
      description:
          "Submit the application together with the required supporting documents and prescribed fee.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Document Verification",
      description:
          "The competent authority verifies the Nikah Nama, identity documents, and other supporting records.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Registration Entry",
      description:
          "The marriage particulars are entered into the official marriage registration record.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Approval",
      description:
          "The competent authority approves the marriage registration after successful verification.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Issue Marriage Certificate",
      description:
          "The official Marriage Registration Certificate is prepared and issued.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Receive Certificate",
      description:
          "Collect the Marriage Registration Certificate and preserve it for future legal and administrative purposes.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Divorce Registration
//-----------------------------------------------------------

ProcedureModel(
  id: "divorce_registration",

  categoryId: "registration",

  title: "Divorce Registration",

  overview:
      "Divorce Registration is the legal process through which a divorce is officially recorded with the competent authority after compliance with the applicable legal requirements. Registration provides legal evidence of the dissolution of marriage and is required for updating official records and for future legal, family, inheritance, immigration, and personal status matters.",

  governmentDepartment:
      "Union Council / Local Government Department / Chairman Union Council",

  eligibility:
      "A husband or wife, or any person legally authorized under the applicable law, may initiate or complete the divorce registration process after fulfilling the legal requirements governing dissolution of marriage.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC of the Applicant",
    "Copy of CNIC of the Other Spouse (where available)",
    "Original or Certified Copy of Nikah Nama",
    "Divorce Notice / Talaq Notice or Court Decree (where applicable)",
    "Reconciliation Proceedings Record (where applicable)",
    "Prescribed Application Form",
    "Government Prescribed Fee (where applicable)",
  ],

  applicableLaws: [
    "Muslim Family Laws Ordinance, 1961 (where applicable)",
    "Family Courts Act, 1964 (where applicable)",
    "Local Government Act (Applicable Province)",
    "Relevant Personal and Family Laws",
  ],

  importantNotes: [
    "Follow the legal procedure applicable to the type of divorce.",
    "Ensure all statutory notices are served where required.",
    "Keep certified copies of the Divorce Certificate.",
    "Different legal procedures may apply depending on the applicable personal law and circumstances.",
  ],

  commonMistakes: [
    "Failing to submit the required divorce notice.",
    "Ignoring mandatory legal timelines.",
    "Providing incomplete documentation.",
    "Assuming the divorce is complete without fulfilling the legal registration requirements.",
  ],

  estimatedFee:
      "As prescribed by the relevant local government authority.",

  estimatedTime:
      "Depends upon compliance with the applicable legal procedure, reconciliation process (where required), and approval by the competent authority.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Prepare Required Documents",
      description:
          "Collect the Nikah Nama, CNIC, divorce notice or court decree, and all other required supporting documents.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Submit Divorce Notice or Application",
      description:
          "Submit the prescribed notice or application to the competent authority in accordance with the applicable law.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Verification",
      description:
          "The authority verifies the documents and confirms compliance with the legal requirements.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Reconciliation Process",
      description:
          "Where required by law, reconciliation proceedings are conducted before finalization of the divorce.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Completion of Statutory Period",
      description:
          "The legally prescribed waiting period is completed where applicable.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Approval",
      description:
          "The competent authority confirms completion of the legal requirements and approves the registration.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Issue Divorce Certificate",
      description:
          "The official Divorce Registration Certificate is prepared and issued.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Receive Certificate",
      description:
          "Collect the Divorce Certificate and preserve it for future legal, personal, and administrative purposes.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Family Registration Certificate (FRC)
//-----------------------------------------------------------

ProcedureModel(
  id: "family_registration_certificate",

  categoryId: "registration",

  title: "Family Registration Certificate (FRC)",

  overview:
      "A Family Registration Certificate (FRC) is an official document issued by the National Database and Registration Authority (NADRA) that provides information regarding a person's registered family composition based on NADRA's database. The certificate is commonly required for visa applications, immigration matters, succession proceedings, educational admissions, banking, and other legal or administrative purposes.",

  governmentDepartment:
      "National Database and Registration Authority (NADRA)",

  eligibility:
      "Any eligible Pakistani citizen whose family information is available in NADRA's official database may apply for a Family Registration Certificate in accordance with the applicable rules.",

  requiredDocuments: [
    "Original Smart CNIC or CNIC",
    "NICOP or POC (where applicable)",
    "Relevant Family Member Identification Details",
    "Prescribed Application Form (if applicable)",
    "Government Prescribed Fee",
  ],

  applicableLaws: [
    "National Database and Registration Authority Ordinance, 2000",
    "NADRA Rules and Regulations",
  ],

  importantNotes: [
    "The certificate reflects only the family data available in NADRA's records.",
    "Ensure that all family members' records are updated before applying.",
    "Different FRC categories may be available depending on the applicant's relationship.",
    "The certificate is generally issued for informational and legal purposes and does not itself establish inheritance or ownership rights.",
  ],

  commonMistakes: [
    "Applying before updating family records in NADRA.",
    "Providing incorrect family information.",
    "Selecting an incorrect certificate category.",
    "Ignoring discrepancies in NADRA records before submission.",
  ],

  estimatedFee:
      "As prescribed by NADRA under the applicable fee schedule.",

  estimatedTime:
      "Usually completed after identity verification and successful processing by NADRA.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Verify Family Record",
      description:
          "Ensure that the applicant's family information in NADRA's database is complete and accurate.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Collect Required Documents",
      description:
          "Keep the CNIC, NICOP (where applicable), and any supporting information ready.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Submit Application",
      description:
          "Apply through the authorized NADRA Registration Center or approved online service, where available.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Identity Verification",
      description:
          "NADRA verifies the applicant's identity and family records in its official database.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Application Processing",
      description:
          "The application is processed after successful verification of the submitted information.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Fee Confirmation",
      description:
          "The prescribed government fee is confirmed and recorded in the processing system.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Issue Family Registration Certificate",
      description:
          "NADRA prepares and issues the official Family Registration Certificate.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Receive Certificate",
      description:
          "Receive the Family Registration Certificate and keep it safely for future legal, immigration, educational, banking, or administrative purposes.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: CNIC Application
//-----------------------------------------------------------

ProcedureModel(
  id: "cnic_application",

  categoryId: "registration",

  title: "CNIC Application",

  overview:
      "A Computerized National Identity Card (CNIC) is the official proof of identity issued by the National Database and Registration Authority (NADRA) to eligible Pakistani citizens. It is required for voting, banking, employment, taxation, passports, property transactions, driving licences, and numerous government and private services.",

  governmentDepartment:
      "National Database and Registration Authority (NADRA)",

  eligibility:
      "Any Pakistani citizen who has attained the prescribed age for issuance of a CNIC and fulfills the legal requirements may apply for a Computerized National Identity Card.",

  requiredDocuments: [
    "Child Registration Certificate (CRC/B-Form) where applicable",
    "Original CNIC of Parent or Guardian (where required)",
    "Supporting Documents Required by NADRA (if applicable)",
    "Biometric Verification",
    "Government Prescribed Fee",
  ],

  applicableLaws: [
    "National Database and Registration Authority Ordinance, 2000",
    "NADRA Rules and Regulations",
  ],

  importantNotes: [
    "Provide accurate personal information during the application process.",
    "Ensure biometric data and photograph are captured clearly.",
    "Review all information before final submission.",
    "Keep the application tracking receipt until the CNIC is collected or delivered.",
  ],

  commonMistakes: [
    "Providing incorrect personal information.",
    "Submitting outdated supporting documents.",
    "Ignoring errors before biometric confirmation.",
    "Losing the application tracking receipt.",
  ],

  estimatedFee:
      "As prescribed by NADRA under the applicable fee schedule and service category (Normal, Urgent, or Executive).",

  estimatedTime:
      "Depends upon the selected service category and successful completion of NADRA's verification process.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Visit NADRA Registration Center",
      description:
          "Visit the nearest NADRA Registration Center or any other authorized service facility.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Token Issuance",
      description:
          "Obtain an application token and wait for your turn according to the queue management system.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Identity Verification",
      description:
          "Provide the required documents for identity verification by the registration officer.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Biometric & Photograph",
      description:
          "Provide fingerprints, digital photograph, and electronic signature as required.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Data Entry",
      description:
          "The registration officer records your personal information in NADRA's system.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Review & Confirmation",
      description:
          "Carefully review the entered information before confirming the application.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Fee Payment & Processing",
      description:
          "Pay the applicable fee and receive the application tracking receipt.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Receive CNIC",
      description:
          "Collect your CNIC from the designated center or receive it through the approved delivery service after successful processing.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: CNIC Renewal
//-----------------------------------------------------------

ProcedureModel(
  id: "cnic_renewal",

  categoryId: "registration",

  title: "CNIC Renewal",

  overview:
      "CNIC Renewal is the process through which a Pakistani citizen renews an expired or soon-to-expire Computerized National Identity Card (CNIC) issued by the National Database and Registration Authority (NADRA). Renewal ensures that the citizen's identity document remains valid for use in government, banking, legal, commercial, and other official transactions.",

  governmentDepartment:
      "National Database and Registration Authority (NADRA)",

  eligibility:
      "Any Pakistani citizen whose CNIC has expired or is due for renewal may apply for a renewed CNIC in accordance with NADRA's applicable rules and procedures.",

  requiredDocuments: [
    "Original Expired or Existing CNIC",
    "Supporting Documents (where required)",
    "Biometric Verification",
    "Government Prescribed Fee",
  ],

  applicableLaws: [
    "National Database and Registration Authority Ordinance, 2000",
    "NADRA Rules and Regulations",
  ],

  importantNotes: [
    "Apply before the CNIC expires to avoid inconvenience.",
    "Ensure that your personal information remains accurate.",
    "Report any errors or changes before completing the renewal.",
    "Keep the application receipt until the renewed CNIC is received.",
  ],

  commonMistakes: [
    "Applying with incomplete supporting documents.",
    "Failing biometric verification due to incorrect fingerprint placement.",
    "Ignoring incorrect personal information during review.",
    "Misplacing the application receipt.",
  ],

  estimatedFee:
      "As prescribed by NADRA under the applicable Normal, Urgent, or Executive service category.",

  estimatedTime:
      "Depends upon the selected processing category and successful verification by NADRA.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Visit NADRA Registration Center",
      description:
          "Visit the nearest NADRA Registration Center or use an authorized online service where available.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Obtain Token",
      description:
          "Receive an application token and wait for your turn.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Identity Verification",
      description:
          "Present your existing CNIC and any additional required documents for verification.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Biometric & Photograph",
      description:
          "Provide fingerprints, photograph, and electronic signature where required.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Review Personal Information",
      description:
          "Review the information displayed in the system and confirm its accuracy.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Fee Payment",
      description:
          "Pay the applicable renewal fee according to the selected service category.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Application Processing",
      description:
          "NADRA processes the renewal application after successful verification.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Receive Renewed CNIC",
      description:
          "Collect the renewed CNIC from the designated center or receive it through the approved delivery service.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: CNIC Modification
//-----------------------------------------------------------

ProcedureModel(
  id: "cnic_modification",

  categoryId: "registration",

  title: "CNIC Modification",

  overview:
      "CNIC Modification is the process through which a Pakistani citizen updates or corrects information recorded on a Computerized National Identity Card (CNIC). Modifications may include changes to personal particulars such as name, father's or husband's name, date of birth, marital status, address, photograph, fingerprints, or other information maintained by the National Database and Registration Authority (NADRA).",

  governmentDepartment:
      "National Database and Registration Authority (NADRA)",

  eligibility:
      "Any Pakistani citizen seeking correction or modification of information recorded in NADRA's official database may apply, subject to verification and supporting documentary evidence.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC",
    "Supporting Documentary Evidence for the Requested Modification",
    "Birth Certificate (where applicable)",
    "Marriage Certificate or Divorce Certificate (where applicable)",
    "Court Order (where required)",
    "Original CNIC of Parent or Guardian (where applicable)",
    "Biometric Verification",
    "Government Prescribed Fee",
  ],

  applicableLaws: [
    "National Database and Registration Authority Ordinance, 2000",
    "NADRA Rules and Regulations",
  ],

  importantNotes: [
    "Provide authentic supporting documents for every requested modification.",
    "Certain changes may require additional verification or legal documentation.",
    "Review all information carefully before confirming the application.",
    "Keep the application receipt until the modified CNIC is received.",
  ],

  commonMistakes: [
    "Submitting insufficient documentary evidence.",
    "Providing inconsistent information.",
    "Failing biometric verification.",
    "Ignoring errors during the final review.",
  ],

  estimatedFee:
      "As prescribed by NADRA according to the applicable modification type and service category.",

  estimatedTime:
      "Depends upon the nature of the requested modification and NADRA's verification process.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Collect Supporting Documents",
      description:
          "Gather all original documents supporting the requested modification.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Visit NADRA Registration Center",
      description:
          "Visit the nearest NADRA Registration Center or use an authorized online facility where available.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Identity Verification",
      description:
          "Present your existing CNIC and supporting documents for verification.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Biometric & Photograph",
      description:
          "Provide fingerprints, photograph, and electronic signature where required.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Update Personal Information",
      description:
          "The registration officer updates the requested information after verification of supporting documents.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Review Application",
      description:
          "Carefully review all updated information before final confirmation.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Fee Payment & Processing",
      description:
          "Pay the prescribed fee and receive the application tracking receipt.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Receive Modified CNIC",
      description:
          "Collect the modified CNIC from the designated center or receive it through the approved delivery service after successful processing.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Child Registration Certificate (B-Form)
//-----------------------------------------------------------

ProcedureModel(
  id: "child_registration_certificate",

  categoryId: "registration",

  title: "Child Registration Certificate (B-Form)",

  overview:
      "A Child Registration Certificate (CRC), commonly known as a B-Form, is an official identity document issued by the National Database and Registration Authority (NADRA) for Pakistani citizens below the age prescribed for obtaining a Computerized National Identity Card (CNIC). It records the child's identity and links the child to the parents in NADRA's official database. The CRC is commonly required for school admissions, passports, visas, inheritance matters, and other legal or administrative purposes.",

  governmentDepartment:
      "National Database and Registration Authority (NADRA)",

  eligibility:
      "A parent or legal guardian may apply for a Child Registration Certificate on behalf of an eligible Pakistani child in accordance with NADRA's applicable rules and procedures.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC of Parent or Guardian",
    "Birth Certificate or Birth Registration Record",
    "Child's Birth Registration Details",
    "Presence of the Child (where required)",
    "Biometric or Photograph Requirements (where applicable)",
    "Government Prescribed Fee",
  ],

  applicableLaws: [
    "National Database and Registration Authority Ordinance, 2000",
    "NADRA Rules and Regulations",
  ],

  importantNotes: [
    "Ensure that the child's birth has already been registered.",
    "The child's personal information must exactly match the birth registration record.",
    "Parents' information should already be correctly recorded in NADRA's database.",
    "Keep the Child Registration Certificate safely for future use.",
  ],

  commonMistakes: [
    "Applying before completing birth registration.",
    "Providing inconsistent information regarding the child's identity.",
    "Submitting incomplete supporting documents.",
    "Ignoring discrepancies in parents' NADRA records.",
  ],

  estimatedFee:
      "As prescribed by NADRA under the applicable fee schedule.",

  estimatedTime:
      "Depends upon successful identity verification and processing by NADRA.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Collect Required Documents",
      description:
          "Gather the parent's CNIC, birth certificate, and all required supporting documents.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Visit NADRA Registration Center",
      description:
          "Visit the nearest NADRA Registration Center or use an authorized online service where available.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Identity Verification",
      description:
          "The registration officer verifies the identity of the parent or guardian and supporting documents.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Record Child Information",
      description:
          "The child's personal information is entered into NADRA's registration system after verification.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Photograph or Biometric Requirements",
      description:
          "Where applicable, complete the required photograph or biometric formalities.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Review Application",
      description:
          "Carefully review all entered information before confirming the application.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Fee Payment & Processing",
      description:
          "Pay the prescribed fee and receive the application tracking receipt.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Receive Child Registration Certificate",
      description:
          "Collect the Child Registration Certificate (B-Form) after successful processing.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Family Tree Correction
//-----------------------------------------------------------

ProcedureModel(
  id: "family_tree_correction",

  categoryId: "registration",

  title: "Family Tree Correction",

  overview:
      "Family Tree Correction is the process through which a Pakistani citizen requests the correction or updating of family relationship records maintained by the National Database and Registration Authority (NADRA). The process ensures that parentage, spouse details, children, siblings, and other family relationships recorded in NADRA's official database accurately reflect the applicant's legal family information.",

  governmentDepartment:
      "National Database and Registration Authority (NADRA)",

  eligibility:
      "Any eligible Pakistani citizen seeking correction or updating of family relationship information recorded in NADRA's database may apply, subject to verification and supporting legal documentation.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC",
    "Birth Certificate (where applicable)",
    "Marriage Certificate (where applicable)",
    "Death Certificate (where applicable)",
    "Divorce Certificate (where applicable)",
    "Court Order (where required)",
    "Supporting Family Documents",
    "Government Prescribed Fee",
  ],

  applicableLaws: [
    "National Database and Registration Authority Ordinance, 2000",
    "NADRA Rules and Regulations",
  ],

  importantNotes: [
    "Provide authentic documentary evidence for every requested correction.",
    "Some corrections may require verification of multiple family members.",
    "Certain requests may require legal proceedings or court orders.",
    "Review the updated family information carefully before final confirmation.",
  ],

  commonMistakes: [
    "Submitting incomplete documentary evidence.",
    "Providing inconsistent family information.",
    "Ignoring discrepancies between different official documents.",
    "Failing to update related family records where necessary.",
  ],

  estimatedFee:
      "As prescribed by NADRA according to the applicable fee schedule.",

  estimatedTime:
      "Depends upon the complexity of the requested correction and NADRA's verification process.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Collect Supporting Documents",
      description:
          "Gather all documents supporting the requested correction of family records.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Visit NADRA Registration Center",
      description:
          "Visit the nearest NADRA Registration Center or other authorized service point.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Identity Verification",
      description:
          "Present the required identity documents and supporting evidence for verification.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Submit Correction Request",
      description:
          "Submit the application requesting correction of the family tree records.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Verification Process",
      description:
          "NADRA verifies the submitted documents, family relationships, and supporting evidence.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Update Family Records",
      description:
          "Upon successful verification, the requested corrections are entered into NADRA's official database.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Application Processing",
      description:
          "The corrected family information is finalized after approval by the competent authority.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Receive Updated Record",
      description:
          "Receive confirmation of the updated family record or the relevant certificate, where applicable.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Business Registration
//-----------------------------------------------------------

ProcedureModel(
  id: "business_registration",

  categoryId: "registration",

  title: "Business Registration",

  overview:
      "Business Registration is the legal process of establishing a business entity in Pakistan in accordance with the applicable laws. Depending on the nature of the business, registration may be carried out with the Securities and Exchange Commission of Pakistan (SECP), provincial authorities, local government bodies, the Federal Board of Revenue (FBR), or other competent regulatory authorities. Registration provides legal recognition and enables the business to operate lawfully.",

  governmentDepartment:
      "Securities and Exchange Commission of Pakistan (SECP) / Federal Board of Revenue (FBR) / Relevant Provincial or Local Authority",

  eligibility:
      "Any individual, partnership, company, or other lawful entity intending to establish and operate a business in Pakistan may apply for registration subject to the applicable legal requirements.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC of Proprietor, Partners, or Directors",
    "Business Name (where applicable)",
    "Business Address Proof",
    "Partnership Deed or Incorporation Documents (where applicable)",
    "Memorandum and Articles of Association (for companies)",
    "Tax Registration Information (where applicable)",
    "Government Prescribed Fee",
  ],

  applicableLaws: [
    "Companies Act, 2017 (where applicable)",
    "Partnership Act, 1932 (where applicable)",
    "Income Tax Ordinance, 2001",
    "Sales Tax Act, 1990 (where applicable)",
    "Relevant Provincial and Local Government Laws",
  ],

  importantNotes: [
    "Choose the appropriate business structure before registration.",
    "Verify the availability of the proposed business name where required.",
    "Complete tax registration after business registration if applicable.",
    "Obtain all sector-specific licences and permits before commencing operations.",
  ],

  commonMistakes: [
    "Selecting an unsuitable business structure.",
    "Submitting incomplete registration documents.",
    "Ignoring tax registration requirements.",
    "Operating before obtaining mandatory licences or approvals.",
  ],

  estimatedFee:
      "Depends upon the type of business entity and the applicable government fee schedule.",

  estimatedTime:
      "Varies depending on the nature of the business and the authority responsible for registration.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Determine Business Structure",
      description:
          "Decide whether the business will operate as a sole proprietorship, partnership, company, or another legally recognized structure.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Prepare Required Documents",
      description:
          "Collect all required identity, business, and organizational documents.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Reserve Business Name",
      description:
          "Reserve the proposed business name where required under the applicable law.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Submit Registration Application",
      description:
          "Submit the application and supporting documents to the competent registration authority.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Document Verification",
      description:
          "The authority verifies the application and supporting documents.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Fee Payment",
      description:
          "Pay the prescribed government registration fee.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Registration Approval",
      description:
          "Upon successful verification, the competent authority approves the business registration.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Receive Registration Certificate",
      description:
          "Receive the official business registration certificate and complete any additional tax or regulatory registrations where required.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Partnership Firm Registration
//-----------------------------------------------------------

ProcedureModel(
  id: "partnership_firm_registration",

  categoryId: "registration",

  title: "Partnership Firm Registration",

  overview:
      "Partnership Firm Registration is the legal process through which two or more persons establish and register a partnership business in accordance with the Partnership Act, 1932. Registration provides legal recognition to the partnership, facilitates business operations, and strengthens the firm's ability to enforce contractual and legal rights.",

  governmentDepartment:
      "Registrar of Firms / Provincial Industries, Commerce & Investment Department",

  eligibility:
      "Two or more competent persons who agree to carry on a lawful business with a view to earning profits may register a partnership firm in accordance with the applicable laws.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC of All Partners",
    "Executed Partnership Deed",
    "Business Address Proof",
    "Passport-sized Photographs of Partners (where applicable)",
    "Prescribed Registration Application",
    "Government Prescribed Registration Fee",
  ],

  applicableLaws: [
    "Partnership Act, 1932",
    "Registration Act, 1908 (where applicable)",
    "Income Tax Ordinance, 2001",
    "Relevant Provincial Rules",
  ],

  importantNotes: [
    "Clearly define the rights and responsibilities of each partner in the partnership deed.",
    "Register the partnership to strengthen the firm's legal standing.",
    "Obtain tax registration and any required licences after registration.",
    "Notify the Registrar of any changes in partners or firm particulars.",
  ],

  commonMistakes: [
    "Preparing an incomplete partnership deed.",
    "Providing inconsistent information about partners.",
    "Ignoring tax registration requirements.",
    "Failing to update changes in partnership details.",
  ],

  estimatedFee:
      "As prescribed by the relevant provincial Registrar of Firms.",

  estimatedTime:
      "Depends upon document verification and approval by the Registrar of Firms.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Prepare Partnership Deed",
      description:
          "Draft and execute a partnership deed containing the terms and conditions agreed upon by all partners.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Collect Required Documents",
      description:
          "Gather the CNICs of all partners, business address proof, partnership deed, and other supporting documents.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Complete Registration Application",
      description:
          "Fill in the prescribed partnership registration application accurately.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Submit Application",
      description:
          "Submit the application together with the required documents and prescribed fee.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Document Verification",
      description:
          "The Registrar verifies the partnership deed, identity documents, and supporting records.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Fee Confirmation",
      description:
          "The prescribed government fee is verified and recorded.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Registration Approval",
      description:
          "Upon successful verification, the Registrar approves the registration of the partnership firm.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Issue Registration Certificate",
      description:
          "Receive the official Partnership Firm Registration Certificate and complete any additional tax or regulatory registrations where required.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: NGO Registration
//-----------------------------------------------------------

ProcedureModel(
  id: "ngo_registration",

  categoryId: "registration",

  title: "NGO Registration",

  overview:
      "NGO Registration is the legal process through which a non-governmental, non-profit, charitable, welfare, educational, religious, or social organization obtains legal recognition under the applicable laws of Pakistan. Registration enables the organization to operate lawfully, own property, open bank accounts, receive grants or donations, and carry out its objectives in accordance with the law.",

  governmentDepartment:
      "Securities and Exchange Commission of Pakistan (SECP) / Social Welfare Department / Registrar of Societies / Relevant Provincial Authority",

  eligibility:
      "Individuals intending to establish a lawful non-profit or charitable organization may apply for registration under the applicable legal framework governing the selected type of organization.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC of Founding Members",
    "Memorandum of Association",
    "Articles, Constitution, or Bye-laws",
    "List of Governing Body Members",
    "Office Address Proof",
    "Resolution for Registration",
    "Government Prescribed Registration Fee",
  ],

  applicableLaws: [
    "Societies Registration Act, 1860 (where applicable)",
    "Voluntary Social Welfare Agencies (Registration and Control) Ordinance, 1961",
    "Companies Act, 2017 (Section 42 Companies where applicable)",
    "Relevant Provincial Laws",
  ],

  importantNotes: [
    "Choose the most appropriate legal structure before applying.",
    "Clearly define the organization's objectives in its constitution.",
    "Maintain proper financial and administrative records after registration.",
    "Comply with annual filing and reporting requirements where applicable.",
  ],

  commonMistakes: [
    "Preparing an incomplete constitution or memorandum.",
    "Submitting inconsistent information about governing members.",
    "Choosing an unsuitable registration law.",
    "Failing to comply with post-registration reporting obligations.",
  ],

  estimatedFee:
      "As prescribed by the relevant registration authority.",

  estimatedTime:
      "Depends upon document verification, legal scrutiny, and approval by the competent authority.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Choose Registration Framework",
      description:
          "Determine the appropriate law and registration authority for the NGO based on its objectives and legal structure.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Prepare Constitutional Documents",
      description:
          "Prepare the memorandum, constitution, bye-laws, governing body details, and other required documents.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Complete Registration Application",
      description:
          "Fill in the prescribed NGO registration application accurately.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Submit Application",
      description:
          "Submit the application together with supporting documents and the prescribed registration fee.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Document Verification",
      description:
          "The competent authority verifies the documents and legal requirements.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Inspection or Additional Verification",
      description:
          "Where required, the authority may conduct inspections or request additional information.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Registration Approval",
      description:
          "Upon successful verification, the competent authority approves the NGO registration.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Issue Registration Certificate",
      description:
          "Receive the official NGO Registration Certificate and comply with any post-registration legal obligations.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Trademark Registration
//-----------------------------------------------------------

ProcedureModel(
  id: "trademark_registration",

  categoryId: "registration",

  title: "Trademark Registration",

  overview:
      "Trademark Registration is the legal process through which a person or business obtains exclusive legal protection for a distinctive trademark, including a name, logo, symbol, slogan, device, label, or combination thereof. Registration grants the proprietor statutory rights to use the trademark in relation to the registered goods or services and to prevent unauthorized use by others.",

  governmentDepartment:
      "Intellectual Property Organization of Pakistan (IPO-Pakistan)",

  eligibility:
      "Any individual, partnership, company, or other legal entity claiming to be the proprietor of a trademark used or intended to be used in relation to goods or services may apply for trademark registration.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC of Applicant (or Incorporation Documents for Companies)",
    "Trademark Representation (Logo, Name, Label, Device, etc.)",
    "Description of Goods or Services",
    "Power of Attorney (where filed through an Agent)",
    "Business Information (where applicable)",
    "Government Prescribed Fee",
  ],

  applicableLaws: [
    "Trade Marks Ordinance, 2001",
    "Trade Marks Rules, 2004",
    "Intellectual Property Organization of Pakistan Act, 2012",
  ],

  importantNotes: [
    "Conduct a trademark availability search before filing the application.",
    "Choose the correct class of goods or services.",
    "Use a distinctive mark that does not infringe the rights of others.",
    "Renew the trademark before expiry to maintain protection.",
  ],

  commonMistakes: [
    "Selecting an incorrect trademark class.",
    "Applying for a descriptive or non-distinctive trademark.",
    "Submitting an unclear trademark representation.",
    "Ignoring objections or examination reports issued during processing.",
  ],

  estimatedFee:
      "As prescribed by IPO-Pakistan according to the applicable fee schedule.",

  estimatedTime:
      "Depends upon examination, publication, opposition (if any), and final registration by IPO-Pakistan.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Conduct Trademark Search",
      description:
          "Search existing trademark records to determine whether a similar trademark has already been registered or applied for.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Prepare Application",
      description:
          "Prepare the trademark application together with the trademark representation and supporting documents.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Submit Application",
      description:
          "Submit the trademark application to IPO-Pakistan together with the prescribed fee.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Formal Examination",
      description:
          "IPO-Pakistan examines the application for compliance with legal and procedural requirements.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Publication",
      description:
          "Where applicable, the trademark is published in the official Trade Marks Journal for opposition purposes.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Opposition Proceedings",
      description:
          "If an opposition is filed, the matter is decided in accordance with the applicable law before registration proceeds.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Registration Approval",
      description:
          "Upon successful completion of all legal requirements, IPO-Pakistan approves the trademark registration.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Issue Registration Certificate",
      description:
          "Receive the official Trademark Registration Certificate and maintain the trademark through timely renewals.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Copyright Registration
//-----------------------------------------------------------

ProcedureModel(
  id: "copyright_registration",

  categoryId: "registration",

  title: "Copyright Registration",

  overview:
      "Copyright Registration is the legal process through which the creator or owner of an original literary, artistic, musical, dramatic, cinematographic, software, architectural, or other copyright-protected work records ownership with the Intellectual Property Organization of Pakistan (IPO-Pakistan). Registration serves as strong legal evidence of ownership and facilitates enforcement of copyright rights against infringement.",

  governmentDepartment:
      "Intellectual Property Organization of Pakistan (IPO-Pakistan)",

  eligibility:
      "The author, creator, owner, assignee, or any person legally entitled to claim ownership of an original copyright-protected work may apply for copyright registration in accordance with the applicable law.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC of Applicant",
    "Copies of the Original Work",
    "Description of the Copyright Work",
    "Ownership or Assignment Documents (where applicable)",
    "Power of Attorney (where filed through an Agent)",
    "Government Prescribed Fee",
  ],

  applicableLaws: [
    "Copyright Ordinance, 1962",
    "Copyright Rules",
    "Intellectual Property Organization of Pakistan Act, 2012",
  ],

  importantNotes: [
    "Only original works qualify for copyright protection.",
    "Maintain records proving authorship and ownership.",
    "Registration strengthens legal protection but does not replace the underlying copyright created by law.",
    "Promptly report unauthorized use or infringement.",
  ],

  commonMistakes: [
    "Submitting incomplete copies of the work.",
    "Failing to establish ownership where the work has been assigned.",
    "Providing an inaccurate description of the copyrighted work.",
    "Ignoring objections raised during examination.",
  ],

  estimatedFee:
      "As prescribed by IPO-Pakistan under the applicable fee schedule.",

  estimatedTime:
      "Depends upon examination, verification, and approval by IPO-Pakistan.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Prepare Copyright Application",
      description:
          "Prepare the copyright application together with copies of the original work and supporting documents.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Collect Supporting Documents",
      description:
          "Gather identity documents, ownership records, assignment documents (if applicable), and other required evidence.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Submit Application",
      description:
          "Submit the copyright application together with the prescribed fee to IPO-Pakistan.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Examination",
      description:
          "IPO-Pakistan examines the application and verifies compliance with the applicable legal requirements.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Respond to Objections",
      description:
          "Provide explanations or additional documents if any objection or deficiency is raised during examination.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Approval",
      description:
          "Upon successful examination, the competent authority approves the copyright registration.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Registration Entry",
      description:
          "The copyright is entered into the official Register of Copyrights maintained by IPO-Pakistan.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Issue Registration Certificate",
      description:
          "Receive the official Copyright Registration Certificate and preserve it for future legal enforcement and commercial use.",
    ),
  ],
),

];