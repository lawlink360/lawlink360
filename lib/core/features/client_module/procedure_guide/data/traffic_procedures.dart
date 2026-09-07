import '../models/procedure_model.dart';
import '../models/procedure_step.dart';

final List<ProcedureModel> trafficProcedures = [

  //-----------------------------------------------------------
// Procedure: Learner Driving Licence
//-----------------------------------------------------------

ProcedureModel(
  id: "learner_driving_licence",

  categoryId: "traffic",

  title: "Learner Driving Licence",

  overview:
      "A Learner Driving Licence is a temporary licence issued to eligible applicants that permits them to learn driving under the conditions prescribed by the relevant licensing authority before obtaining a permanent driving licence. Applicants must satisfy the prescribed age, documentation, and legal requirements.",

  governmentDepartment:
      "Provincial Traffic Police / Driving Licence Issuing Authority",

  eligibility:
      "Any person meeting the minimum legal age and other prescribed requirements may apply for a Learner Driving Licence in accordance with the applicable traffic laws.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC (or B-Form where permitted by law)",
    "Copy of CNIC",
    "Recent Passport Size Photographs (where required)",
    "Prescribed Application Form",
    "Medical Certificate (where applicable)",
    "Government Prescribed Fee",
  ],

  applicableLaws: [
    "Motor Vehicles Ordinance, 1965",
    "Provincial Motor Vehicles Rules",
    "Applicable Traffic Laws",
  ],

  importantNotes: [
    "Carry the learner licence while practicing driving.",
    "Comply with all conditions printed on the learner licence.",
    "Practice driving only in accordance with the applicable law.",
    "Apply for the permanent driving licence after fulfilling the required conditions.",
  ],

  commonMistakes: [
    "Submitting incomplete documents.",
    "Providing incorrect personal information.",
    "Ignoring eligibility requirements.",
    "Driving without complying with learner licence conditions.",
  ],

  estimatedFee:
      "As prescribed by the relevant provincial licensing authority.",

  estimatedTime:
      "Usually issued on the same day after successful completion of the application process, subject to verification.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Confirm Eligibility",
      description:
          "Ensure that you satisfy the minimum age and other legal requirements for obtaining a learner driving licence.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Collect Required Documents",
      description:
          "Gather all required identity documents, photographs, medical certificate (if applicable), and the prescribed application form.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Visit Licensing Authority",
      description:
          "Visit the designated driving licence issuing office or authorized licensing centre.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Submit Application",
      description:
          "Submit the completed application form together with the required documents and prescribed fee.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Verification",
      description:
          "The licensing authority verifies the applicant's identity and supporting documents.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Complete Required Formalities",
      description:
          "Complete any required eyesight test, biometric verification, or other prescribed formalities.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Issue of Learner Licence",
      description:
          "Upon successful verification, the learner driving licence is issued.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Begin Learning",
      description:
          "Practice driving in accordance with the conditions of the learner licence and applicable traffic laws.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Driving Licence (Permanent)
//-----------------------------------------------------------

ProcedureModel(
  id: "driving_licence",

  categoryId: "traffic",

  title: "Driving Licence",

  overview:
      "A Driving Licence is an official licence issued by the competent licensing authority authorizing an eligible person to drive specified categories of motor vehicles on public roads after successfully completing the prescribed legal requirements, tests, and verification procedures.",

  governmentDepartment:
      "Provincial Traffic Police / Driving Licence Issuing Authority",

  eligibility:
      "Any applicant holding a valid learner driving licence, meeting the prescribed age requirements, and successfully passing the required driving and theoretical tests may apply for a permanent driving licence.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC",
    "Valid Learner Driving Licence",
    "Passport Size Photographs (where required)",
    "Medical Certificate (where applicable)",
    "Prescribed Application Form",
    "Government Prescribed Fee Receipt",
  ],

  applicableLaws: [
    "Motor Vehicles Ordinance, 1965",
    "Provincial Motor Vehicles Rules",
    "Applicable Traffic Laws",
  ],

  importantNotes: [
    "Carry your driving licence while driving.",
    "Drive only the class of vehicle authorized by the licence.",
    "Renew the licence before its expiry date.",
    "Comply with all traffic laws and licensing conditions.",
  ],

  commonMistakes: [
    "Applying before completing the learner licence requirements.",
    "Submitting incomplete documentation.",
    "Failing the driving or theoretical test due to inadequate preparation.",
    "Providing incorrect personal information.",
  ],

  estimatedFee:
      "As prescribed by the relevant provincial licensing authority.",

  estimatedTime:
      "Depends upon successful completion of the required tests and document verification.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Complete Learner Period",
      description:
          "Complete the legally required learner licence period before applying for a permanent licence.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Prepare Required Documents",
      description:
          "Gather all required documents, photographs, medical certificate (where applicable), and fee receipt.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Submit Application",
      description:
          "Submit the prescribed application to the designated driving licence office.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Identity Verification",
      description:
          "Complete biometric verification, eyesight examination, and document verification as required.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Theory Test",
      description:
          "Successfully complete the theoretical or computer-based traffic rules examination where applicable.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Practical Driving Test",
      description:
          "Pass the practical driving examination conducted by the licensing authority.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Licence Approval",
      description:
          "Upon successful completion of all requirements, the licensing authority approves the application.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Receive Driving Licence",
      description:
          "Receive the permanent driving licence and comply with all conditions attached to it.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Driving Licence Renewal
//-----------------------------------------------------------

ProcedureModel(
  id: "driving_licence_renewal",

  categoryId: "traffic",

  title: "Driving Licence Renewal",

  overview:
      "Driving Licence Renewal is the process through which a licence holder renews an expired or expiring driving licence to continue driving motor vehicles legally. Renewal is subject to verification of identity, payment of prescribed fees, and compliance with the applicable traffic laws and licensing requirements.",

  governmentDepartment:
      "Provincial Traffic Police / Driving Licence Issuing Authority",

  eligibility:
      "Any holder of a valid or expired driving licence who satisfies the applicable renewal requirements may apply for renewal in accordance with the prescribed rules.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC",
    "Original Driving Licence",
    "Copy of Driving Licence (where required)",
    "Recent Passport Size Photographs (where required)",
    "Medical Certificate (where applicable)",
    "Prescribed Application Form",
    "Government Prescribed Fee Receipt",
  ],

  applicableLaws: [
    "Motor Vehicles Ordinance, 1965",
    "Provincial Motor Vehicles Rules",
    "Applicable Traffic Laws",
  ],

  importantNotes: [
    "Apply for renewal before the licence expires whenever possible.",
    "Carry the renewed licence while driving.",
    "Ensure all personal information is up to date.",
    "Additional requirements may apply for certain licence categories or senior applicants.",
  ],

  commonMistakes: [
    "Applying long after the licence has expired.",
    "Submitting incomplete documents.",
    "Providing outdated personal information.",
    "Failing to pay the prescribed renewal fee.",
  ],

  estimatedFee:
      "As prescribed by the relevant provincial licensing authority.",

  estimatedTime:
      "Usually completed after successful verification of documents and fulfilment of the prescribed formalities.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Check Licence Status",
      description:
          "Confirm the expiry date and determine whether the licence is eligible for renewal.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Prepare Required Documents",
      description:
          "Gather the original driving licence, CNIC, photographs, medical certificate (where required), and application form.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Visit Licensing Office",
      description:
          "Visit the designated driving licence issuing office or authorized licensing centre.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Submit Renewal Application",
      description:
          "Submit the completed application together with all required documents and prescribed fee.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Verification",
      description:
          "The licensing authority verifies the applicant's identity, licence record, and supporting documents.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Complete Required Formalities",
      description:
          "Complete biometric verification, eyesight examination, medical examination, or any other prescribed formalities where applicable.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Approval",
      description:
          "Upon successful verification, the renewal application is approved by the licensing authority.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Receive Renewed Licence",
      description:
          "Receive the renewed driving licence and continue driving in accordance with the applicable traffic laws.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Duplicate Driving Licence
//-----------------------------------------------------------

ProcedureModel(
  id: "duplicate_driving_licence",

  categoryId: "traffic",

  title: "Duplicate Driving Licence",

  overview:
      "A Duplicate Driving Licence is issued when the original driving licence is lost, stolen, damaged, or destroyed. The applicant must report the loss where required, submit the prescribed application, complete identity verification, and satisfy the requirements of the licensing authority before a duplicate licence is issued.",

  governmentDepartment:
      "Provincial Traffic Police / Driving Licence Issuing Authority",

  eligibility:
      "Any holder of a valid driving licence whose original licence has been lost, stolen, damaged, or rendered unusable may apply for a duplicate driving licence in accordance with the applicable rules.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC",
    "Copy of Driving Licence (if available)",
    "Loss Report or FIR (where required)",
    "Damaged Driving Licence (if applicable)",
    "Recent Passport Size Photographs (where required)",
    "Prescribed Application Form",
    "Government Prescribed Fee Receipt",
  ],

  applicableLaws: [
    "Motor Vehicles Ordinance, 1965",
    "Provincial Motor Vehicles Rules",
    "Applicable Traffic Laws",
  ],

  importantNotes: [
    "Report the loss or theft promptly where required.",
    "Provide accurate information regarding the missing licence.",
    "Keep a copy of the application and acknowledgement.",
    "Use the duplicate licence only after it has been officially issued.",
  ],

  commonMistakes: [
    "Providing incorrect licence details.",
    "Failing to report the loss where legally required.",
    "Submitting incomplete documents.",
    "Applying without identity verification.",
  ],

  estimatedFee:
      "As prescribed by the relevant provincial licensing authority.",

  estimatedTime:
      "Usually issued after verification of the applicant's identity and driving licence record.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Report Loss or Damage",
      description:
          "Report the loss, theft, or damage of the driving licence where required under the applicable procedure.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Collect Required Documents",
      description:
          "Gather the CNIC, available licence details, photographs, and any supporting documents.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Complete Application",
      description:
          "Fill in the prescribed duplicate driving licence application form accurately.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Submit Application",
      description:
          "Submit the application together with the prescribed fee and supporting documents.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Verification",
      description:
          "The licensing authority verifies the applicant's identity and existing licence record.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Biometric & Formalities",
      description:
          "Complete biometric verification or any additional formalities required by the licensing authority.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Approval",
      description:
          "The competent authority approves the issuance of the duplicate driving licence after successful verification.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Receive Duplicate Licence",
      description:
          "Receive the duplicate driving licence and safely preserve it for future use.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: International Driving Permit
//-----------------------------------------------------------

ProcedureModel(
  id: "international_driving_permit",

  categoryId: "traffic",

  title: "International Driving Permit",

  overview:
      "An International Driving Permit (IDP) is an internationally recognized document issued to eligible holders of a valid domestic driving licence. It enables the holder to drive in countries that recognize the permit, subject to the laws of the destination country. The permit does not replace the domestic driving licence and must generally be carried together with it.",

  governmentDepartment:
      "Provincial Traffic Police / Driving Licence Issuing Authority",

  eligibility:
      "Any holder of a valid domestic driving licence who satisfies the applicable legal requirements may apply for an International Driving Permit.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC",
    "Valid Domestic Driving Licence",
    "Valid Passport",
    "Valid Visa (where applicable)",
    "Recent Passport Size Photographs",
    "Prescribed Application Form",
    "Government Prescribed Fee Receipt",
  ],

  applicableLaws: [
    "Motor Vehicles Ordinance, 1965",
    "Provincial Motor Vehicles Rules",
    "Applicable International Driving Permit Regulations",
  ],

  importantNotes: [
    "Carry both the International Driving Permit and the original domestic driving licence while driving abroad.",
    "Verify whether the destination country recognizes the International Driving Permit.",
    "The permit does not authorize driving after its validity period expires.",
    "Comply with the traffic laws of the destination country.",
  ],

  commonMistakes: [
    "Applying with an expired domestic driving licence.",
    "Submitting incomplete travel documents.",
    "Assuming the permit replaces the domestic driving licence.",
    "Ignoring the validity period of the permit.",
  ],

  estimatedFee:
      "As prescribed by the relevant provincial licensing authority.",

  estimatedTime:
      "Usually issued after successful verification of documents and eligibility, subject to the licensing authority's procedures.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Verify Eligibility",
      description:
          "Ensure that you possess a valid domestic driving licence and meet all prescribed requirements.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Collect Required Documents",
      description:
          "Gather the driving licence, passport, visa (where applicable), photographs, and supporting documents.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Complete Application",
      description:
          "Fill in the prescribed International Driving Permit application form accurately.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Submit Application",
      description:
          "Submit the application together with the required documents and prescribed fee.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Verification",
      description:
          "The licensing authority verifies the applicant's identity, driving licence, and supporting documents.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Biometric & Formalities",
      description:
          "Complete biometric verification or any additional formalities required by the licensing authority.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Approval",
      description:
          "The competent authority approves the application after successful verification.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Receive International Driving Permit",
      description:
          "Receive the International Driving Permit and carry it together with the valid domestic driving licence while driving abroad.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Vehicle Registration
//-----------------------------------------------------------

ProcedureModel(
  id: "vehicle_registration",

  categoryId: "traffic",

  title: "Vehicle Registration",

  overview:
      "Vehicle Registration is the legal process through which a newly acquired motor vehicle is officially registered with the competent Excise, Taxation and Narcotics Control Department or other authorized registration authority. Upon successful registration, the vehicle is assigned a registration number and becomes legally authorized for use on public roads.",

  governmentDepartment:
      "Excise, Taxation and Narcotics Control Department",

  eligibility:
      "Any lawful owner of a motor vehicle who satisfies the prescribed legal requirements may apply for vehicle registration.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC",
    "Vehicle Purchase Invoice",
    "Manufacturer's Sale Certificate",
    "Import Documents (for imported vehicles, where applicable)",
    "Sales Tax Invoice (where applicable)",
    "Insurance Documents (where required)",
    "Prescribed Application Form",
    "Government Prescribed Registration Fee",
  ],

  applicableLaws: [
    "Motor Vehicles Ordinance, 1965",
    "Provincial Motor Vehicles Rules",
    "Provincial Excise and Taxation Laws",
  ],

  importantNotes: [
    "Register the vehicle within the legally prescribed period.",
    "Ensure all chassis and engine numbers match the official documents.",
    "Keep the registration book/card safely after issuance.",
    "Display the assigned registration number in accordance with applicable law.",
  ],

  commonMistakes: [
    "Submitting incorrect engine or chassis numbers.",
    "Providing incomplete ownership documents.",
    "Delaying registration beyond the prescribed period.",
    "Failing to pay the prescribed registration charges.",
  ],

  estimatedFee:
      "As prescribed by the Provincial Excise, Taxation and Narcotics Control Department.",

  estimatedTime:
      "Depends upon verification of ownership documents, payment of taxes, and completion of the registration process.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Collect Required Documents",
      description:
          "Gather the purchase invoice, sale certificate, CNIC, tax documents, and other required records.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Complete Application",
      description:
          "Fill in the prescribed vehicle registration application form accurately.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Submit Application",
      description:
          "Submit the application together with all supporting documents and the prescribed registration fee.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Vehicle Verification",
      description:
          "The competent authority verifies the vehicle's chassis number, engine number, and supporting documents.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Tax & Fee Verification",
      description:
          "Applicable taxes, registration charges, and other government dues are verified.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Registration Approval",
      description:
          "The competent authority approves the registration after successful verification.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Registration Number Assignment",
      description:
          "A unique registration number is assigned to the vehicle.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Receive Registration Documents",
      description:
          "Receive the vehicle registration certificate or smart registration card and retain it for future use.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Vehicle Ownership Transfer
//-----------------------------------------------------------

ProcedureModel(
  id: "vehicle_ownership_transfer",

  categoryId: "traffic",

  title: "Vehicle Ownership Transfer",

  overview:
      "Vehicle Ownership Transfer is the legal process through which the ownership of a registered motor vehicle is transferred from the existing owner to a new owner. The transfer is completed through the competent Excise, Taxation and Narcotics Control Department after verification of the vehicle, payment of applicable taxes and transfer fees, and submission of the prescribed documents.",

  governmentDepartment:
      "Excise, Taxation and Narcotics Control Department",

  eligibility:
      "Any registered vehicle owner who lawfully sells or transfers a vehicle, and the purchaser receiving ownership, may apply for transfer of ownership in accordance with the applicable law.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC of Seller",
    "Original CNIC or Smart CNIC of Purchaser",
    "Original Vehicle Registration Book/Smart Card",
    "Sale Agreement or Sale Receipt",
    "Transfer Application Form",
    "Biometric Verification of Seller and Purchaser",
    "Vehicle Clearance Certificate (where applicable)",
    "Government Prescribed Transfer Fee Receipt",
  ],

  applicableLaws: [
    "Motor Vehicles Ordinance, 1965",
    "Provincial Motor Vehicles Rules",
    "Provincial Excise and Taxation Laws",
  ],

  importantNotes: [
    "Transfer ownership immediately after the sale of the vehicle.",
    "Verify the engine and chassis numbers before completing the transaction.",
    "Ensure all outstanding taxes and penalties are cleared before applying.",
    "The purchaser should not use the vehicle without completing the ownership transfer.",
  ],

  commonMistakes: [
    "Purchasing a vehicle without biometric verification.",
    "Failing to clear outstanding token taxes or penalties.",
    "Submitting incomplete transfer documents.",
    "Not verifying the authenticity of the registration record.",
  ],

  estimatedFee:
      "As prescribed by the Provincial Excise, Taxation and Narcotics Control Department.",

  estimatedTime:
      "Usually completed after verification of documents, biometric confirmation, and approval by the registration authority.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Prepare Sale Documents",
      description:
          "Prepare the sale agreement and collect all ownership documents required for the transfer.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Biometric Verification",
      description:
          "Complete biometric verification of the seller and purchaser where required.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Complete Transfer Application",
      description:
          "Fill in the prescribed ownership transfer application form accurately.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Submit Application",
      description:
          "Submit the transfer application together with all required documents and the prescribed fee.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Vehicle & Document Verification",
      description:
          "The competent authority verifies the vehicle details, ownership records, engine number, chassis number, and supporting documents.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Payment Verification",
      description:
          "Verification of transfer fee, token tax status, and any other applicable government dues is completed.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Approval of Transfer",
      description:
          "The competent authority approves the transfer of ownership after successful verification.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Issue Updated Registration",
      description:
          "A new registration certificate or smart card is issued in the name of the new owner.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Vehicle Token Tax
//-----------------------------------------------------------

ProcedureModel(
  id: "vehicle_token_tax",

  categoryId: "traffic",

  title: "Vehicle Token Tax",

  overview:
      "Vehicle Token Tax is the annual tax payable by the registered owner of a motor vehicle to the Provincial Excise, Taxation and Narcotics Control Department. Payment of token tax is mandatory to keep the vehicle legally compliant for use on public roads and to avoid penalties or additional surcharges.",

  governmentDepartment:
      "Excise, Taxation and Narcotics Control Department",

  eligibility:
      "Every registered vehicle owner is responsible for paying the applicable annual token tax in accordance with the relevant provincial laws and regulations.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC",
    "Vehicle Registration Book or Smart Card",
    "Vehicle Registration Number",
    "Previous Token Tax Receipt (where applicable)",
    "Government Prescribed Tax Payment Form (if applicable)",
  ],

  applicableLaws: [
    "Motor Vehicles Ordinance, 1965",
    "Provincial Motor Vehicles Rules",
    "Provincial Excise and Taxation Laws",
  ],

  importantNotes: [
    "Pay the token tax before the due date to avoid penalties.",
    "Keep the payment receipt safely for future reference.",
    "Verify that the vehicle registration details are correct before making payment.",
    "Additional taxes or penalties may apply for late payment.",
  ],

  commonMistakes: [
    "Missing the annual payment deadline.",
    "Entering an incorrect vehicle registration number.",
    "Ignoring outstanding arrears or penalties.",
    "Failing to retain the payment receipt.",
  ],

  estimatedFee:
      "Depends on the vehicle type, engine capacity, age of the vehicle, and the applicable provincial tax schedule.",

  estimatedTime:
      "Payment is generally completed immediately after successful verification through the designated payment channel.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Verify Tax Status",
      description:
          "Check whether the vehicle's token tax is due and confirm the payable amount.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Collect Required Documents",
      description:
          "Keep the vehicle registration documents, CNIC, and previous payment details ready.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Calculate Payable Tax",
      description:
          "Determine the applicable token tax based on the vehicle category, engine capacity, and provincial tax schedule.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Make Payment",
      description:
          "Pay the token tax through the authorized bank, online portal, or designated payment channel.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Payment Verification",
      description:
          "The payment is verified by the competent authority and recorded in the official system.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Receive Payment Receipt",
      description:
          "Obtain the official receipt or electronic confirmation of the token tax payment.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Update Vehicle Record",
      description:
          "The vehicle's tax status is updated in the official registration database.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Retain Proof of Payment",
      description:
          "Keep the receipt safely as proof of compliance and for future inspections or renewals.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Vehicle Fitness Certificate
//-----------------------------------------------------------

ProcedureModel(
  id: "vehicle_fitness_certificate",

  categoryId: "traffic",

  title: "Vehicle Fitness Certificate",

  overview:
      "A Vehicle Fitness Certificate is an official certificate issued by the competent transport authority confirming that a motor vehicle satisfies the prescribed roadworthiness, safety, and environmental standards. Commercial and public service vehicles are generally required to obtain and periodically renew a valid fitness certificate in accordance with applicable laws.",

  governmentDepartment:
      "Provincial Transport Department / Regional Transport Authority",

  eligibility:
      "Owners of vehicles required by law to obtain a fitness certificate, particularly commercial and public service vehicles, may apply upon meeting the prescribed legal and technical requirements.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC",
    "Vehicle Registration Book or Smart Card",
    "Vehicle Ownership Documents",
    "Valid Route Permit (where applicable)",
    "Previous Fitness Certificate (for renewal)",
    "Proof of Payment of Token Tax",
    "Prescribed Application Form",
    "Government Prescribed Fee Receipt",
  ],

  applicableLaws: [
    "Motor Vehicles Ordinance, 1965",
    "Provincial Motor Vehicles Rules",
    "Provincial Transport Laws",
  ],

  importantNotes: [
    "Ensure the vehicle is in proper mechanical condition before inspection.",
    "Repair any safety defects before presenting the vehicle.",
    "Maintain valid token tax and registration records.",
    "Renew the fitness certificate before its expiry date.",
  ],

  commonMistakes: [
    "Presenting a mechanically defective vehicle for inspection.",
    "Applying with expired registration or unpaid token tax.",
    "Submitting incomplete documents.",
    "Ignoring defects identified during inspection.",
  ],

  estimatedFee:
      "As prescribed by the Provincial Transport Department or Regional Transport Authority.",

  estimatedTime:
      "Depends upon successful inspection, document verification, and approval by the competent authority.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Prepare Vehicle",
      description:
          "Ensure the vehicle is roadworthy and complies with the prescribed safety and environmental standards.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Collect Required Documents",
      description:
          "Gather the registration documents, token tax proof, previous fitness certificate (if applicable), and other required documents.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Submit Application",
      description:
          "Submit the prescribed application together with the required documents and fee.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Vehicle Inspection",
      description:
          "The competent authority conducts a technical inspection of the vehicle's safety, mechanical condition, and roadworthiness.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Document Verification",
      description:
          "The authority verifies the ownership documents, registration records, and tax status.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Rectification (if required)",
      description:
          "If defects are identified, repair the vehicle and present it again for re-inspection where required.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Approval",
      description:
          "Upon successful inspection and verification, the competent authority approves the application.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Receive Fitness Certificate",
      description:
          "Receive the Vehicle Fitness Certificate and ensure it remains valid throughout the prescribed period.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Route Permit
//-----------------------------------------------------------

ProcedureModel(
  id: "route_permit",

  categoryId: "traffic",

  title: "Route Permit",

  overview:
      "A Route Permit is an official authorization issued by the competent transport authority allowing a commercial or public service vehicle to operate on a specified route or within a designated area. The permit regulates passenger and goods transport and ensures compliance with transport laws, safety standards, and route conditions.",

  governmentDepartment:
      "Provincial Transport Department / Regional Transport Authority (RTA)",

  eligibility:
      "Owners or operators of eligible commercial and public service vehicles who meet the prescribed legal and technical requirements may apply for a route permit.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC",
    "Vehicle Registration Book or Smart Card",
    "Vehicle Fitness Certificate",
    "Proof of Token Tax Payment",
    "Valid Vehicle Insurance (where applicable)",
    "Commercial Vehicle Registration Documents",
    "Prescribed Application Form",
    "Government Prescribed Fee Receipt",
  ],

  applicableLaws: [
    "Motor Vehicles Ordinance, 1965",
    "Provincial Motor Vehicles Rules",
    "Provincial Transport Laws",
    "Regional Transport Authority Regulations",
  ],

  importantNotes: [
    "Operate only on the route specified in the permit.",
    "Keep the permit in the vehicle during operation.",
    "Maintain a valid fitness certificate and registration.",
    "Renew the route permit before its expiry date.",
  ],

  commonMistakes: [
    "Operating on an unauthorized route.",
    "Applying with an expired fitness certificate.",
    "Submitting incomplete documents.",
    "Failing to renew the permit on time.",
  ],

  estimatedFee:
      "As prescribed by the Provincial Transport Department or Regional Transport Authority.",

  estimatedTime:
      "Depends upon document verification, vehicle compliance, and approval by the competent transport authority.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Confirm Eligibility",
      description:
          "Ensure the vehicle qualifies for a route permit under the applicable transport laws.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Collect Required Documents",
      description:
          "Gather the registration documents, fitness certificate, token tax proof, insurance documents (where applicable), and other required records.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Complete Application",
      description:
          "Fill in the prescribed route permit application form accurately.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Submit Application",
      description:
          "Submit the application together with the required documents and prescribed fee.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Verification",
      description:
          "The transport authority verifies the vehicle, ownership records, and supporting documents.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Technical Compliance Check",
      description:
          "The authority confirms that the vehicle complies with all applicable transport and safety requirements.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Approval",
      description:
          "Upon successful verification, the competent authority approves the route permit.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Issue Route Permit",
      description:
          "Receive the official route permit and operate the vehicle only in accordance with its conditions.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Traffic Challan Payment
//-----------------------------------------------------------

ProcedureModel(
  id: "traffic_challan_payment",

  categoryId: "traffic",

  title: "Traffic Challan Payment",

  overview:
      "Traffic Challan Payment is the process through which a person pays a fine imposed for violations of traffic laws, including speeding, signal violations, illegal parking, driving without a licence, seat belt or helmet violations, and other offences. Payment may be made through authorized banks, online portals, mobile applications, or designated traffic police offices, subject to the applicable provincial procedures.",

  governmentDepartment:
      "Provincial Traffic Police / Excise & Taxation Department (where applicable)",

  eligibility:
      "Any person against whom a traffic challan has been issued may pay the prescribed fine in accordance with the applicable traffic laws and regulations.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC",
    "Traffic Challan Notice or Challan Number",
    "Vehicle Registration Number (where applicable)",
    "Driving Licence (where applicable)",
    "Government Prescribed Fine Amount",
  ],

  applicableLaws: [
    "Motor Vehicles Ordinance, 1965",
    "Provincial Motor Vehicles Rules",
    "Provincial Traffic Police Regulations",
  ],

  importantNotes: [
    "Pay the challan within the prescribed time to avoid additional penalties.",
    "Verify the challan details before making payment.",
    "Keep the payment receipt safely for future reference.",
    "Some traffic violations may require appearance before the competent authority in addition to payment.",
  ],

  commonMistakes: [
    "Ignoring the challan notice.",
    "Entering an incorrect challan or vehicle number during payment.",
    "Missing the payment deadline.",
    "Failing to keep proof of payment.",
  ],

  estimatedFee:
      "Depends on the type of traffic violation and the fine prescribed under the applicable law.",

  estimatedTime:
      "Usually completed immediately after successful payment and system verification.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Review Challan",
      description:
          "Check the challan details, offence, fine amount, and payment deadline.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Choose Payment Method",
      description:
          "Select an authorized payment channel such as a bank, online portal, mobile application, or traffic office.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Provide Required Information",
      description:
          "Enter the challan number, vehicle registration number, or other required details.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Pay the Fine",
      description:
          "Pay the prescribed fine using the selected payment method.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Payment Verification",
      description:
          "The payment is verified and recorded in the official traffic management system.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Receive Payment Receipt",
      description:
          "Obtain the official payment receipt or electronic confirmation.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Confirm Challan Clearance",
      description:
          "Verify that the challan status has been updated as paid in the official records.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Retain Payment Record",
      description:
          "Keep the payment receipt safely for future reference or dispute resolution if required.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Vehicle Number Plate Replacement
//-----------------------------------------------------------

ProcedureModel(
  id: "vehicle_number_plate_replacement",

  categoryId: "traffic",

  title: "Vehicle Number Plate Replacement",

  overview:
      "Vehicle Number Plate Replacement is the process through which the registered owner of a motor vehicle obtains replacement registration plates when the original plates are lost, stolen, damaged, unreadable, or otherwise require replacement. The competent vehicle registration authority verifies ownership and vehicle records before issuing replacement plates.",

  governmentDepartment:
      "Provincial Excise, Taxation and Narcotics Control Department / Motor Vehicle Registration Authority",

  eligibility:
      "The registered owner of a vehicle may apply for replacement of the vehicle's registration number plates where the existing plates have been lost, stolen, damaged, or require replacement under the applicable rules.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC of Registered Owner",
    "Vehicle Registration Book or Smart Card",
    "Vehicle Registration Number",
    "Application for Replacement Number Plate",
    "Lost or Damaged Number Plate (if available)",
    "Police Report or Loss Report (where required)",
    "Prescribed Fee Receipt",
    "Any Additional Documents Required by the Registration Authority",
  ],

  applicableLaws: [
    "Motor Vehicles Ordinance, 1965",
    "Applicable Provincial Motor Vehicles Rules",
    "Provincial Vehicle Registration Regulations",
  ],

  importantNotes: [
    "Report stolen or lost number plates promptly where required.",
    "Do not use unauthorized or counterfeit registration plates.",
    "Ensure the registration information matches the official vehicle record.",
    "Keep the application receipt until the replacement plates are received.",
  ],

  commonMistakes: [
    "Using unofficial replacement plates.",
    "Submitting incorrect vehicle registration details.",
    "Failing to report a stolen plate where required.",
    "Submitting an application without sufficient proof of ownership.",
  ],

  estimatedFee:
      "As prescribed by the relevant provincial vehicle registration authority.",

  estimatedTime:
      "Depends on verification, plate production, and delivery procedures of the relevant registration authority.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Report Loss or Theft",
      description:
          "If the number plate has been lost or stolen, complete any required police or loss-reporting procedure.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Collect Required Documents",
      description:
          "Gather the CNIC, vehicle registration documents, available plate, loss report where applicable, and other supporting records.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Complete Replacement Application",
      description:
          "Fill in the prescribed application for issuance of a replacement registration number plate.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Pay Prescribed Fee",
      description:
          "Pay the applicable replacement or reissuance fee through the authorized payment channel.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Submit Application",
      description:
          "Submit the application, supporting documents, and payment evidence to the competent vehicle registration authority.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Ownership & Record Verification",
      description:
          "The authority verifies the applicant's ownership and checks the vehicle registration record.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Replacement Plate Processing",
      description:
          "After approval, the replacement registration plate is prepared or ordered through the authorized system.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Receive Replacement Plate",
      description:
          "Collect or receive the replacement plate and install it on the vehicle in accordance with applicable requirements.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Vehicle Deregistration
//-----------------------------------------------------------

ProcedureModel(
  id: "vehicle_deregistration",

  categoryId: "traffic",

  title: "Vehicle Deregistration",

  overview:
      "Vehicle Deregistration is the legal process through which a registered motor vehicle is removed from the official registration records due to permanent scrapping, destruction, export, theft with legal closure, or any other circumstance recognized under the applicable law. Upon approval, the vehicle is no longer authorized for use on public roads under the cancelled registration.",

  governmentDepartment:
      "Excise, Taxation and Narcotics Control Department / Motor Vehicle Registration Authority",

  eligibility:
      "The registered owner or a person legally authorized to act on the owner's behalf may apply for vehicle deregistration where permitted under the applicable laws and regulations.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC",
    "Vehicle Registration Book or Smart Card",
    "Application for Vehicle Deregistration",
    "Proof of Ownership",
    "Vehicle Disposal, Scrapping, Export, or Destruction Documents (where applicable)",
    "Police Report (where applicable)",
    "Clearance Certificate for Outstanding Taxes or Dues (where applicable)",
    "Government Prescribed Fee Receipt",
  ],

  applicableLaws: [
    "Motor Vehicles Ordinance, 1965",
    "Provincial Motor Vehicles Rules",
    "Provincial Excise and Taxation Laws",
  ],

  importantNotes: [
    "Clear all outstanding taxes and government dues before applying, where required.",
    "Return any registration documents or number plates if required by the authority.",
    "Ensure the reason for deregistration is supported by documentary evidence.",
    "Keep the deregistration approval safely for future reference.",
  ],

  commonMistakes: [
    "Applying without clearing outstanding liabilities.",
    "Submitting incomplete supporting documents.",
    "Providing incorrect vehicle identification details.",
    "Failing to return registration materials where required.",
  ],

  estimatedFee:
      "As prescribed by the relevant provincial registration authority.",

  estimatedTime:
      "Depends upon document verification, clearance of liabilities, and approval by the competent authority.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Determine Eligibility",
      description:
          "Confirm that the vehicle qualifies for deregistration under the applicable legal provisions.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Collect Required Documents",
      description:
          "Gather the registration documents, ownership records, clearance certificates, and other supporting evidence.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Complete Deregistration Application",
      description:
          "Fill in the prescribed vehicle deregistration application form accurately.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Submit Application",
      description:
          "Submit the application together with all required documents and the prescribed fee.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Verification",
      description:
          "The registration authority verifies ownership, vehicle records, and supporting documents.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Clearance of Liabilities",
      description:
          "Outstanding taxes, penalties, or other liabilities are verified and cleared where applicable.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Approval of Deregistration",
      description:
          "Upon successful verification, the competent authority approves the deregistration of the vehicle.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Update Registration Records",
      description:
          "The official registration records are updated to reflect the cancellation of the vehicle's registration.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Traffic Accident Reporting
//-----------------------------------------------------------

ProcedureModel(
  id: "traffic_accident_reporting",

  categoryId: "traffic",

  title: "Traffic Accident Reporting",

  overview:
      "Traffic Accident Reporting is the legal process through which a road traffic accident is reported to the competent authorities. The report facilitates investigation, preparation of official records, determination of liability where applicable, insurance claims, and legal proceedings arising from the accident.",

  governmentDepartment:
      "Provincial Traffic Police / Police Department",

  eligibility:
      "Any driver, vehicle owner, passenger, injured person, witness, or other person having knowledge of a traffic accident may report the incident in accordance with the applicable law.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC",
    "Driving Licence (where applicable)",
    "Vehicle Registration Book or Smart Card",
    "Vehicle Insurance Documents (where applicable)",
    "Photographs or Videos of the Accident Scene (if available)",
    "Medical Reports (where applicable)",
    "Witness Information (if available)",
    "Any Other Supporting Evidence",
  ],

  applicableLaws: [
    "Motor Vehicles Ordinance, 1965",
    "Pakistan Penal Code (where applicable)",
    "Code of Criminal Procedure (where applicable)",
    "Provincial Motor Vehicles Rules",
  ],

  importantNotes: [
    "Immediately report accidents involving death, injury, or significant property damage.",
    "Seek emergency medical assistance where required.",
    "Do not alter the accident scene unless necessary for safety or as directed by authorities.",
    "Cooperate fully with the investigating officers.",
  ],

  commonMistakes: [
    "Leaving the accident scene without lawful justification.",
    "Delaying the accident report.",
    "Providing inaccurate or misleading information.",
    "Failing to preserve available evidence.",
  ],

  estimatedFee:
      "No government fee is generally charged for reporting a traffic accident.",

  estimatedTime:
      "The reporting process is generally immediate, while investigation and related proceedings depend upon the complexity of the accident.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Ensure Safety",
      description:
          "Move to a safe location where possible, provide assistance to injured persons, and contact emergency services if required.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Inform the Authorities",
      description:
          "Report the accident to the Traffic Police or the nearest Police Station as soon as practicable.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Collect Information",
      description:
          "Record vehicle details, driver information, witness details, and photographs of the accident scene where possible.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Submit Accident Report",
      description:
          "Provide a complete and accurate account of the accident to the competent authority.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Investigation",
      description:
          "The Traffic Police investigate the accident, inspect the scene, and collect relevant evidence.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Official Documentation",
      description:
          "The investigating authority prepares the necessary reports and legal documentation.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Further Legal or Insurance Process",
      description:
          "Where applicable, use the official report for insurance claims or legal proceedings.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Case Follow-up",
      description:
          "Follow up with the relevant authority regarding the investigation, legal proceedings, or other required actions.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Traffic Complaint
//-----------------------------------------------------------

ProcedureModel(
  id: "traffic_complaint",

  categoryId: "traffic",

  title: "Traffic Complaint",

  overview:
      "A Traffic Complaint is the process through which a citizen reports traffic-related violations, misconduct by road users, unsafe road conditions, illegal parking, reckless driving, overloaded vehicles, traffic signal violations, or misconduct by traffic officials to the competent authority for investigation and appropriate action.",

  governmentDepartment:
      "Provincial Traffic Police / Police Department / Relevant Transport Authority",

  eligibility:
      "Any person who witnesses or is affected by a traffic-related violation, unsafe condition, or misconduct may submit a traffic complaint in accordance with the applicable laws and procedures.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC (where required)",
    "Written Complaint or Online Complaint Form",
    "Vehicle Registration Number (if known)",
    "Photographs or Videos (if available)",
    "Location and Date of the Incident",
    "Witness Information (if available)",
    "Any Other Supporting Evidence",
  ],

  applicableLaws: [
    "Motor Vehicles Ordinance, 1965",
    "Provincial Motor Vehicles Rules",
    "Provincial Traffic Police Regulations",
    "Applicable Transport Laws",
  ],

  importantNotes: [
    "Provide accurate and truthful information.",
    "Include sufficient details to help identify the incident.",
    "Preserve available evidence such as photographs or videos.",
    "False or malicious complaints may result in legal consequences.",
  ],

  commonMistakes: [
    "Submitting incomplete complaint details.",
    "Providing incorrect vehicle registration numbers.",
    "Failing to specify the exact location or time of the incident.",
    "Submitting complaints without supporting evidence where available.",
  ],

  estimatedFee:
      "No government fee is generally charged for submitting a traffic complaint.",

  estimatedTime:
      "Depends upon the nature of the complaint, investigation, and action taken by the competent authority.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Gather Information",
      description:
          "Record the date, time, location, vehicle details, and description of the incident.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Collect Evidence",
      description:
          "Collect photographs, videos, witness details, or other available supporting evidence.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Prepare Complaint",
      description:
          "Prepare a clear and accurate written complaint describing the incident.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Submit Complaint",
      description:
          "Submit the complaint through the authorized traffic police office, online portal, helpline, or designated complaint channel.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Complaint Registration",
      description:
          "The competent authority registers the complaint and issues a reference or tracking number where applicable.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Investigation",
      description:
          "The competent authority investigates the complaint and gathers any additional information required.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Decision and Action",
      description:
          "Appropriate legal or administrative action is taken if the complaint is found to be valid.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Complaint Closure",
      description:
          "The complainant may be informed of the outcome where permitted, and the complaint is formally closed after completion of the process.",
    ),
  ],
),

];