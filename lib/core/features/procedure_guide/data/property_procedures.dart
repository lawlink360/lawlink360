import '../models/procedure_model.dart';
import '../models/procedure_step.dart';

final List<ProcedureModel> propertyProcedures = [
  
// ==========================================================
// PROPERTY MATTERS
// ==========================================================

//-----------------------------------------------------------
// Procedure: Property Mutation
//-----------------------------------------------------------
    ProcedureModel(
      id: "property_mutation",

      categoryId: "property",

      title: "Property Mutation",

      overview:
          "Property mutation is the process of updating the official revenue record after ownership changes due to sale, inheritance, gift, exchange, or a court decree. Mutation records the new owner's name in the land revenue record but does not itself create ownership.",
      governmentDepartment:
          "Revenue Department (Patwari, Kanungo, Tehsildar / Assistant Commissioner as applicable)",

      eligibility:
          "Any person who has legally acquired ownership through sale, inheritance, gift, exchange, or a court decree.",

      requiredDocuments: [
        "Original CNIC of applicant",
        "CNIC copies of transferor/legal heirs",
        "Registered Sale Deed / Gift Deed / Court Decree (as applicable)",
        "Latest Fard (Record of Rights)",
        "Passport-size photographs",
        "Supporting revenue documents",
      ],

      applicableLaws: [
        "Registration Act, 1908",
        "Stamp Act, 1899",
        "Relevant Provincial Land Revenue Law",
      ],

      importantNotes: [
        "Verify all ownership documents before submission.",
        "Keep original documents safe during the process.",
        "Requirements may vary slightly between provinces.",
      ],

      commonMistakes: [
        "Submitting an outdated Fard.",
        "Incorrect CNIC details.",
        "Missing signatures of required parties.",
        "Incomplete supporting documents.",
      ],

      estimatedFee: "According to the applicable provincial revenue schedule.",

      estimatedTime:
          "Usually 15–45 days depending on the province and complexity of the case.",

      steps: [
        ProcedureStep(
          stepNo: 1,
          title: "Obtain the Latest Fard",
          description:
              "Collect the latest Record of Rights (Fard) from the Revenue Department.",
        ),

        ProcedureStep(
          stepNo: 2,
          title: "Prepare Required Documents",
          description:
              "Gather all ownership documents, CNIC copies and supporting papers.",
        ),

        ProcedureStep(
          stepNo: 3,
          title: "Submit Mutation Request",
          description:
              "Submit the application before the concerned Patwari or Revenue Officer.",
        ),

        ProcedureStep(
          stepNo: 4,
          title: "Revenue Verification",
          description:
              "The revenue staff verifies ownership, land record and supporting documents.",
        ),

        ProcedureStep(
          stepNo: 5,
          title: "Appearance of Parties",
          description:
              "Concerned parties appear before the Revenue Officer where required by law.",
        ),

        ProcedureStep(
          stepNo: 6,
          title: "Recording Statements",
          description:
              "Statements of the parties and witnesses are recorded where applicable.",
        ),

        ProcedureStep(
          stepNo: 7,
          title: "Mutation Order",
          description:
              "The competent Revenue Officer approves or rejects the mutation after verification.",
        ),

        ProcedureStep(
          stepNo: 8,
          title: "Update Revenue Record",
          description:
              "After approval, the new owner's name is entered into the official revenue record.",
        ),
      ],
    ),

//-----------------------------------------------------------
// Procedure: Sale Deed Registration
//-----------------------------------------------------------


    ProcedureModel(
      id: "sale_deed_registration",

      categoryId: "property",

      title: "Sale Deed Registration",

      overview:
          "Sale Deed Registration is the legal process through which ownership of immovable property is transferred from the seller to the buyer. Registration before the Sub-Registrar gives the transaction legal recognition and protects the rights of both parties.",

      governmentDepartment:
          "Sub-Registrar Office under the Registration Department",

      eligibility:
          "Any person who legally owns a property and intends to transfer ownership through sale to another eligible purchaser.",

      requiredDocuments: [
        "Original CNIC of Seller",
        "Original CNIC of Buyer",
        "Registered Ownership Documents",
        "Latest Fard (Record of Rights)",
        "Property Tax Clearance (where applicable)",
        "Passport-size photographs",
        "Sale Agreement (if executed)",
        "Witnesses with CNICs",
      ],

      applicableLaws: [
        "Registration Act, 1908",
        "Transfer of Property Act, 1882",
        "Stamp Act, 1899",
        "Relevant Provincial Land Revenue Laws",
      ],

      importantNotes: [
        "Verify ownership before executing the sale.",
        "Ensure all dues and taxes are cleared.",
        "Appear personally before the Sub-Registrar unless legally represented.",
        "Read every clause before signing the deed.",
      ],

      commonMistakes: [
        "Purchasing property without ownership verification.",
        "Incorrect CNIC information.",
        "Failure to pay required stamp duty.",
        "Not registering the deed after execution.",
      ],

      estimatedFee:
          "According to the applicable provincial stamp duty and registration fee schedule.",

      estimatedTime:
          "Usually completed within 1–7 working days depending upon the province and document verification.",

      steps: [
        ProcedureStep(
          stepNo: 1,
          title: "Verify Property Ownership",
          description:
              "Confirm ownership through the latest Fard and previous registered documents.",
        ),

        ProcedureStep(
          stepNo: 2,
          title: "Prepare Sale Deed",
          description:
              "Draft the Sale Deed containing complete details of the buyer, seller and property.",
        ),

        ProcedureStep(
          stepNo: 3,
          title: "Purchase Stamp Paper",
          description:
              "Purchase stamp paper according to the applicable government valuation and stamp duty.",
        ),

        ProcedureStep(
          stepNo: 4,
          title: "Appear Before Sub-Registrar",
          description:
              "Buyer, seller and witnesses appear before the concerned Sub-Registrar for execution.",
        ),

        ProcedureStep(
          stepNo: 5,
          title: "Identity Verification",
          description:
              "The Registration Officer verifies CNICs, biometric information and supporting documents.",
        ),

        ProcedureStep(
          stepNo: 6,
          title: "Registration of Sale Deed",
          description:
              "The Sale Deed is officially registered and assigned a registration number.",
        ),

        ProcedureStep(
          stepNo: 7,
          title: "Collect Registered Sale Deed",
          description:
              "Obtain the registered copy after completion of the registration process.",
        ),

        ProcedureStep(
          stepNo: 8,
          title: "Apply for Property Mutation",
          description:
              "Apply for mutation before the Revenue Department to update ownership in the land record.",
        ),
      ],
    ),

//-----------------------------------------------------------
// Procedure: Gift Deed Registration
//-----------------------------------------------------------

    ProcedureModel(
      id: "gift_deed_registration",

      categoryId: "property",

      title: "Gift Deed Registration",

      overview:
          "Gift Deed Registration is the legal process through which a property owner voluntarily transfers ownership of immovable property to another person without receiving any monetary consideration. A properly registered Gift Deed provides legal protection to both the donor and the donee.",

      governmentDepartment:
          "Sub-Registrar Office under the Registration Department",

      eligibility:
          "Any legally competent owner of immovable property may voluntarily transfer ownership through a Gift Deed to another eligible person.",

      requiredDocuments: [
        "Original CNIC of Donor",
        "Original CNIC of Donee",
        "Original Property Ownership Documents",
        "Latest Fard (Record of Rights)",
        "Passport-size photographs",
        "Witnesses with CNICs",
        "Supporting Revenue Documents",
      ],

      applicableLaws: [
        "Transfer of Property Act, 1882",
        "Registration Act, 1908",
        "Stamp Act, 1899",
        "Relevant Provincial Land Revenue Laws",
      ],

      importantNotes: [
        "The gift must be voluntary and free from coercion.",
        "The donor must be the lawful owner of the property.",
        "Read the Gift Deed carefully before signing.",
        "Complete mutation after registration.",
      ],

      commonMistakes: [
        "Attempting to gift property without ownership.",
        "Incorrect personal information.",
        "Failure to register the Gift Deed.",
        "Ignoring post-registration mutation.",
      ],

      estimatedFee:
          "According to the applicable provincial registration and stamp duty schedule.",

      estimatedTime:
          "Usually completed within 1–7 working days depending upon document verification.",

      steps: [
        ProcedureStep(
          stepNo: 1,
          title: "Verify Ownership",
          description:
              "Confirm ownership using the latest Fard and registered property documents.",
        ),

        ProcedureStep(
          stepNo: 2,
          title: "Prepare Gift Deed",
          description:
              "Prepare the Gift Deed with complete details of the donor, donee and property.",
        ),

        ProcedureStep(
          stepNo: 3,
          title: "Arrange Required Documents",
          description:
              "Collect CNICs, ownership documents and supporting revenue records.",
        ),

        ProcedureStep(
          stepNo: 4,
          title: "Appear Before Sub-Registrar",
          description:
              "The donor, donee and witnesses appear before the Sub-Registrar.",
        ),

        ProcedureStep(
          stepNo: 5,
          title: "Identity Verification",
          description:
              "The Registration Officer verifies identities and supporting documents.",
        ),

        ProcedureStep(
          stepNo: 6,
          title: "Register Gift Deed",
          description:
              "The Gift Deed is officially registered and assigned a registration number.",
        ),

        ProcedureStep(
          stepNo: 7,
          title: "Collect Registered Gift Deed",
          description: "Obtain the registered copy of the Gift Deed.",
        ),

        ProcedureStep(
          stepNo: 8,
          title: "Apply for Mutation",
          description:
              "Apply for mutation before the Revenue Department to update the ownership record.",
        ),
      ],
    ),

//-----------------------------------------------------------
// Procedure: Property Partition
//-----------------------------------------------------------

ProcedureModel(
  id: "property_partition",

  categoryId: "property",

  title: "Property Partition",

  overview:
      "Property Partition is the legal process through which jointly owned property is divided among co-owners according to their respective ownership shares. Partition may be completed through mutual agreement or through legal proceedings before the competent authority or court.",

  governmentDepartment:
      "Revenue Department / Civil Court (depending upon the nature of the partition)",

  eligibility:
      "Any co-owner or legal shareholder of jointly owned property may apply for partition according to applicable law.",

  requiredDocuments: [
    "Original CNIC of Applicant",
    "CNICs of Other Co-owners (if available)",
    "Latest Fard (Record of Rights)",
    "Ownership Documents",
    "Family Tree or Succession Documents (if applicable)",
    "Site Plan or Property Map (where required)",
    "Supporting Revenue Documents",
  ],

  applicableLaws: [
    "Partition Act, 1893",
    "Relevant Provincial Land Revenue Laws",
    "Civil Procedure Code, 1908",
  ],

  importantNotes: [
    "Verify ownership shares before initiating partition.",
    "Attempt mutual settlement where possible.",
    "Revenue partition and civil partition may follow different procedures.",
    "Maintain copies of all submitted documents.",
  ],

  commonMistakes: [
    "Incorrect ownership details.",
    "Incomplete revenue records.",
    "Ignoring legal notices issued by authorities.",
    "Failure to include all necessary co-owners.",
  ],

  estimatedFee:
      "Depends upon the applicable provincial fee schedule and nature of proceedings.",

  estimatedTime:
      "Usually 2–12 months depending upon the complexity of the case and objections raised.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Collect Ownership Records",
      description:
          "Obtain the latest Fard and ownership documents from the Revenue Department.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Determine Ownership Shares",
      description:
          "Verify the ownership share of each co-owner according to revenue records or succession documents.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Submit Partition Application",
      description:
          "File a partition application before the competent Revenue Officer or Civil Court, as applicable.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Issue Notices",
      description:
          "The authority issues notices to all concerned co-owners for appearance.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Site Inspection",
      description:
          "Where necessary, the concerned authority conducts a site inspection and prepares a proposed partition plan.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Hearing of Parties",
      description:
          "All parties are given an opportunity to present objections and supporting evidence.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Partition Order",
      description:
          "The competent authority approves the final partition according to the legal ownership shares.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Update Revenue Record",
      description:
          "Separate ownership entries are recorded in the official land record after completion of the partition.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Inheritance Property Transfer
//-----------------------------------------------------------

ProcedureModel(
  id: "inheritance_property_transfer",

  categoryId: "property",

  title: "Inheritance Property Transfer",

  overview:
      "Inheritance Property Transfer is the legal process through which ownership of property belonging to a deceased person is transferred to the lawful heirs according to the applicable inheritance laws and revenue procedures.",

  governmentDepartment:
      "Revenue Department / Relevant Civil Authority",

  eligibility:
      "Any lawful legal heir of a deceased property owner may apply for transfer of inherited property after fulfilling the legal requirements.",

  requiredDocuments: [
    "Original CNIC of all legal heirs",
    "Death Certificate of the deceased",
    "Succession Certificate or Letter of Administration (where required)",
    "Family Registration Certificate (FRC), where applicable",
    "Latest Fard (Record of Rights)",
    "Ownership Documents",
    "Passport-size photographs",
    "Supporting Revenue Documents",
  ],

  applicableLaws: [
    "Relevant Provincial Land Revenue Laws",
    "Succession Act (where applicable)",
    "Muslim Personal Law (where applicable)",
    "Registration Act, 1908",
  ],

  importantNotes: [
    "Verify the legal heirs before initiating the transfer.",
    "Ensure there are no pending ownership disputes.",
    "Keep certified copies of all supporting documents.",
    "Revenue requirements may vary slightly between provinces.",
  ],

  commonMistakes: [
    "Incomplete legal heir information.",
    "Failure to submit the death certificate.",
    "Using outdated revenue records.",
    "Missing signatures or consent where required.",
  ],

  estimatedFee:
      "According to the applicable provincial revenue fee schedule.",

  estimatedTime:
      "Usually 30–90 days depending upon document verification and the number of legal heirs.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Obtain Death Certificate",
      description:
          "Collect the official death certificate of the deceased property owner.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Identify Legal Heirs",
      description:
          "Determine all lawful legal heirs according to the applicable inheritance law.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Collect Required Documents",
      description:
          "Prepare CNICs, ownership documents, Fard and succession-related documents.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Submit Application",
      description:
          "Submit the inheritance transfer application before the concerned Revenue Officer.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Verification of Legal Heirs",
      description:
          "The Revenue Department verifies the identity of the legal heirs and supporting documents.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Revenue Proceedings",
      description:
          "The competent Revenue Officer conducts proceedings and records statements where required.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Transfer Order",
      description:
          "After verification, the competent authority approves the transfer in favour of the legal heirs.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Update Land Record",
      description:
          "The names of the legal heirs are entered into the official revenue record.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Fard (Record of Rights)
//-----------------------------------------------------------

ProcedureModel(
  id: "fard_record_of_rights",

  categoryId: "property",

  title: "Fard (Record of Rights)",

  overview:
      "Fard (Record of Rights) is an official land ownership record issued by the Revenue Department. It contains details of the owner, property description, Khasra numbers, ownership shares, and other revenue information. It is one of the most important documents required in almost every property transaction.",

  governmentDepartment:
      "Revenue Department (Patwari / Service Center / Tehsil Office)",

  eligibility:
      "Any property owner, legal heir, authorized representative, or person legally entitled under applicable law may apply for a certified copy of the Fard.",

  requiredDocuments: [
    "Original CNIC of Applicant",
    "Copy of CNIC (if required)",
    "Property particulars (Khewat, Khasra, Khatooni or Survey details, if available)",
    "Authority Letter (if applying through an authorized representative)",
    "Supporting ownership documents (where required)",
  ],

  applicableLaws: [
    "Relevant Provincial Land Revenue Laws",
    "Punjab Land Revenue Act (where applicable)",
    "Khyber Pakhtunkhwa Land Revenue Act (where applicable)",
    "Sindh Land Revenue Laws (where applicable)",
    "Balochistan Land Revenue Laws (where applicable)",
  ],

  importantNotes: [
    "Always obtain the latest Fard before purchasing property.",
    "Verify ownership details carefully.",
    "Check whether any mutation is pending.",
    "Ensure all ownership shares are correctly recorded.",
  ],

  commonMistakes: [
    "Using an outdated Fard.",
    "Incorrect property details provided during application.",
    "Ignoring pending mutations.",
    "Failure to verify ownership before property transactions.",
  ],

  estimatedFee:
      "According to the applicable provincial revenue fee schedule.",

  estimatedTime:
      "Usually issued on the same day or within 1–3 working days depending upon the province and service center.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Visit Revenue Office or Service Center",
      description:
          "Visit the concerned Revenue Office or authorized Land Record Service Center.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Provide Property Details",
      description:
          "Provide available property details such as Khewat, Khatooni, Khasra number or owner information.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Identity Verification",
      description:
          "Present your original CNIC for identity verification.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Submit Application",
      description:
          "Submit the request for issuance of the latest certified Fard.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Pay Government Fee",
      description:
          "Deposit the prescribed government fee according to the applicable schedule.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Revenue Record Verification",
      description:
          "The Revenue Department verifies the land record before issuing the document.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Receive Certified Fard",
      description:
          "Collect the certified copy of the Record of Rights after verification.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Verify the Contents",
      description:
          "Carefully verify the owner's name, ownership shares, property description and mutation status before using the document.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Certified Copy of Registry
//-----------------------------------------------------------

ProcedureModel(
  id: "certified_copy_of_registry",

  categoryId: "property",

  title: "Certified Copy of Registry",

  overview:
      "A Certified Copy of Registry is an officially authenticated copy of a registered property document issued by the Registration Department. It serves as legal proof of the contents of the original registered deed and is commonly required in court proceedings, property verification, bank loans and ownership-related matters.",

  governmentDepartment:
      "Sub-Registrar Office / Registration Department",

  eligibility:
      "Any person having a lawful interest in the registered property or any person legally entitled under the applicable law may apply for a certified copy.",

  requiredDocuments: [
    "Original CNIC of Applicant",
    "Copy of CNIC",
    "Registration Number (if available)",
    "Property Details",
    "Authority Letter (if applying through a representative)",
  ],

  applicableLaws: [
    "Registration Act, 1908",
    "Relevant Provincial Registration Rules",
  ],

  importantNotes: [
    "Provide accurate registration details to avoid delays.",
    "A certified copy has evidentiary value under the law.",
    "Keep multiple certified copies for future legal use.",
    "Verify all document details before leaving the office.",
  ],

  commonMistakes: [
    "Providing incorrect registration number.",
    "Applying at the wrong Sub-Registrar Office.",
    "Incomplete applicant information.",
    "Failure to verify the issued copy.",
  ],

  estimatedFee:
      "According to the applicable provincial fee schedule.",

  estimatedTime:
      "Usually issued within 1–5 working days depending upon record availability.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Visit the Sub-Registrar Office",
      description:
          "Visit the office where the original document was registered.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Complete the Application",
      description:
          "Fill out the prescribed application form with complete property details.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Provide Identification",
      description:
          "Present your original CNIC for verification.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Submit Supporting Information",
      description:
          "Provide the registration number or other available property particulars.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Pay the Government Fee",
      description:
          "Deposit the prescribed fee according to the applicable schedule.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Verification of Record",
      description:
          "The Registration Department verifies the original registered document.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Issue of Certified Copy",
      description:
          "A certified copy bearing the official seal is prepared and issued.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Verify the Certified Copy",
      description:
          "Check that all pages, seals and registration details are complete before leaving.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Property Verification
//-----------------------------------------------------------

ProcedureModel(
  id: "property_verification",

  categoryId: "property",

  title: "Property Verification",

  overview:
      "Property Verification is the process of confirming the legal status, ownership, encumbrances, revenue records, and registration details of a property before purchasing, selling, or mortgaging it. Proper verification helps prevent fraud and future legal disputes.",

  governmentDepartment:
      "Revenue Department / Sub-Registrar Office / Relevant Development Authority",

  eligibility:
      "Any prospective buyer, property owner, legal heir, financial institution, or person having a lawful interest in the property may conduct property verification.",

  requiredDocuments: [
    "Original CNIC of Applicant",
    "Property Ownership Documents",
    "Latest Fard (Record of Rights)",
    "Registered Sale Deed or Gift Deed",
    "Property Tax Record (if applicable)",
    "Approved Site Plan (where applicable)",
  ],

  applicableLaws: [
    "Registration Act, 1908",
    "Transfer of Property Act, 1882",
    "Relevant Provincial Land Revenue Laws",
  ],

  importantNotes: [
    "Always verify ownership before making any payment.",
    "Check for pending litigation affecting the property.",
    "Verify that all mutations have been completed.",
    "Confirm there are no mortgages or legal encumbrances.",
  ],

  commonMistakes: [
    "Purchasing property without verifying ownership.",
    "Ignoring pending court cases.",
    "Failing to verify mutation entries.",
    "Depending only on photocopies of documents.",
  ],

  estimatedFee:
      "Varies depending upon the authority and documents required.",

  estimatedTime:
      "Usually 1–7 working days depending upon record availability.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Collect Ownership Documents",
      description:
          "Obtain all available ownership and registration documents from the seller.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Verify Revenue Record",
      description:
          "Obtain the latest Fard and verify ownership details.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Check Registration Record",
      description:
          "Verify the registered deed with the Sub-Registrar Office.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Confirm Mutation Status",
      description:
          "Ensure all ownership transfers have been properly mutated.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Check for Encumbrances",
      description:
          "Verify whether the property is mortgaged, attached, or subject to legal restrictions.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Verify Taxes and Dues",
      description:
          "Confirm that all applicable taxes and government dues have been paid.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Inspect the Property",
      description:
          "Physically inspect the property to confirm boundaries and possession.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Complete Verification Report",
      description:
          "Prepare a final verification report before proceeding with any transaction.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Demarcation of Land
//-----------------------------------------------------------

ProcedureModel(
  id: "demarcation_of_land",

  categoryId: "property",

  title: "Demarcation of Land",

  overview:
      "Demarcation of Land is the official process of identifying and marking the exact boundaries of a property on the ground according to the official revenue records. It helps resolve boundary disputes, prevent encroachments, and confirm the correct location and dimensions of the land.",

  governmentDepartment:
      "Revenue Department (Patwari / Kanungo / Tehsildar / Assistant Commissioner)",

  eligibility:
      "Any property owner, co-owner, legal heir, or person having a lawful interest in the land may apply for demarcation.",

  requiredDocuments: [
    "Original CNIC of Applicant",
    "Latest Fard (Record of Rights)",
    "Ownership Documents",
    "Property Map (Shajra) where applicable",
    "Application for Demarcation",
    "Supporting Revenue Documents",
  ],

  applicableLaws: [
    "Relevant Provincial Land Revenue Laws",
    "Punjab Land Revenue Act (where applicable)",
    "Relevant Revenue Rules",
  ],

  importantNotes: [
    "Ensure the latest revenue record is available before applying.",
    "All concerned landowners should be notified where required.",
    "Present any previous demarcation reports if available.",
    "Attend the site inspection on the scheduled date.",
  ],

  commonMistakes: [
    "Providing incorrect property details.",
    "Failure to notify neighbouring landowners where required.",
    "Using outdated revenue records.",
    "Ignoring official notices.",
  ],

  estimatedFee:
      "According to the applicable provincial revenue fee schedule.",

  estimatedTime:
      "Usually completed within 15–45 days depending upon the district and complexity of the case.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Prepare Required Documents",
      description:
          "Collect ownership documents, latest Fard and supporting revenue records.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Submit Demarcation Application",
      description:
          "Submit the prescribed application before the concerned Revenue Officer.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Verification of Record",
      description:
          "The Revenue Department verifies ownership and land records.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Issue Notices",
      description:
          "Notices are issued to the concerned parties where required by law.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Site Inspection",
      description:
          "The Revenue Officer visits the site to inspect and measure the land.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Boundary Measurement",
      description:
          "Official measurements are taken according to the revenue record and maps.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Preparation of Demarcation Report",
      description:
          "The findings are recorded in the official demarcation report.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Issue Final Order",
      description:
          "The competent authority issues the final demarcation report and records the proceedings.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Correction of Revenue Record
//-----------------------------------------------------------

ProcedureModel(
  id: "correction_of_revenue_record",

  categoryId: "property",

  title: "Correction of Revenue Record",

  overview:
      "Correction of Revenue Record is the legal process of rectifying errors or omissions in official land records maintained by the Revenue Department. Corrections may relate to ownership details, names, parentage, area, Khasra numbers, or other revenue entries, ensuring that the land record accurately reflects the legal position.",

  governmentDepartment:
      "Revenue Department (Patwari / Kanungo / Tehsildar / Assistant Commissioner)",

  eligibility:
      "Any property owner, legal heir, co-owner, or person having a lawful interest in the property may apply for correction of the revenue record where an error exists.",

  requiredDocuments: [
    "Original CNIC of Applicant",
    "Latest Fard (Record of Rights)",
    "Ownership Documents",
    "Documents Supporting the Requested Correction",
    "Court Order (if applicable)",
    "Application for Correction",
    "Supporting Revenue Documents",
  ],

  applicableLaws: [
    "Relevant Provincial Land Revenue Laws",
    "Punjab Land Revenue Act (where applicable)",
    "Relevant Revenue Rules",
  ],

  importantNotes: [
    "Clearly identify the incorrect entry before applying.",
    "Attach documentary evidence supporting the correction.",
    "Attend hearings whenever required.",
    "Keep copies of all submitted documents.",
  ],

  commonMistakes: [
    "Submitting insufficient supporting evidence.",
    "Applying before the wrong revenue authority.",
    "Ignoring notices issued during proceedings.",
    "Providing outdated revenue documents.",
  ],

  estimatedFee:
      "According to the applicable provincial revenue fee schedule.",

  estimatedTime:
      "Usually 30–90 days depending upon the complexity of the correction and verification process.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Identify the Error",
      description:
          "Review the revenue record and identify the incorrect entry requiring correction.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Collect Supporting Documents",
      description:
          "Gather ownership documents and all evidence supporting the requested correction.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Submit Application",
      description:
          "Submit the correction application before the concerned Revenue Officer.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Verification of Record",
      description:
          "The Revenue Department verifies the existing record and supporting documents.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Issue Notices",
      description:
          "Where required, notices are issued to affected parties for hearing.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Hearing of Parties",
      description:
          "The competent authority hears the applicant and any interested parties.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Pass Correction Order",
      description:
          "The competent Revenue Officer passes an order allowing or rejecting the requested correction.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Update Revenue Record",
      description:
          "If approved, the official land record is corrected accordingly.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Mortgage Registration
//-----------------------------------------------------------

ProcedureModel(
  id: "mortgage_registration",

  categoryId: "property",

  title: "Mortgage Registration",

  overview:
      "Mortgage Registration is the legal process through which immovable property is offered as security for repayment of a loan or financial obligation. Registration protects the rights of both the borrower and the lender and provides legal recognition of the mortgage.",

  governmentDepartment:
      "Sub-Registrar Office / Registration Department",

  eligibility:
      "Any lawful owner of immovable property who intends to secure a loan or financial obligation by creating a mortgage over the property.",

  requiredDocuments: [
    "Original CNIC of Mortgagor",
    "Original CNIC of Mortgagee (where applicable)",
    "Original Ownership Documents",
    "Latest Fard (Record of Rights)",
    "Loan Agreement or Financing Documents",
    "Passport-size Photographs",
    "Supporting Revenue Documents",
  ],

  applicableLaws: [
    "Transfer of Property Act, 1882",
    "Registration Act, 1908",
    "Stamp Act, 1899",
    "Relevant Provincial Land Revenue Laws",
  ],

  importantNotes: [
    "Verify ownership before creating the mortgage.",
    "Read all financing terms carefully.",
    "Understand the consequences of default.",
    "Keep certified copies of the registered mortgage deed.",
  ],

  commonMistakes: [
    "Mortgaging disputed property.",
    "Failure to verify ownership documents.",
    "Signing documents without understanding the terms.",
    "Not registering the mortgage where registration is required.",
  ],

  estimatedFee:
      "According to the applicable provincial registration and stamp duty schedule.",

  estimatedTime:
      "Usually completed within 1–7 working days depending upon document verification.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Verify Property Ownership",
      description:
          "Confirm ownership through the latest revenue records and title documents.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Prepare Mortgage Documents",
      description:
          "Prepare the mortgage deed and financing documents.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Collect Supporting Documents",
      description:
          "Gather CNICs, ownership documents and loan-related documents.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Appear Before Sub-Registrar",
      description:
          "Appear before the Registration Officer for execution of the mortgage deed.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Identity Verification",
      description:
          "The Registration Officer verifies identities and supporting documents.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Registration of Mortgage",
      description:
          "The mortgage deed is officially registered.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Collect Registered Documents",
      description:
          "Receive the registered mortgage documents.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Maintain Official Record",
      description:
          "Keep the registered mortgage documents safely for future legal use.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Lease Registration
//-----------------------------------------------------------

ProcedureModel(
  id: "lease_registration",

  categoryId: "property",

  title: "Lease Registration",

  overview:
      "Lease Registration is the legal process through which a property owner grants possession of immovable property to another person for a specified period in exchange for rent or other agreed consideration. Registration provides legal recognition to the lease agreement where required by law.",

  governmentDepartment:
      "Sub-Registrar Office / Registration Department",

  eligibility:
      "Any lawful property owner or authorized representative may register a lease agreement with an eligible tenant in accordance with applicable law.",

  requiredDocuments: [
    "Original CNIC of Lessor",
    "Original CNIC of Lessee",
    "Original Ownership Documents",
    "Lease Agreement",
    "Latest Fard (Record of Rights)",
    "Passport-size Photographs",
    "Witnesses with CNICs",
  ],

  applicableLaws: [
    "Transfer of Property Act, 1882",
    "Registration Act, 1908",
    "Stamp Act, 1899",
    "Relevant Provincial Registration Rules",
  ],

  importantNotes: [
    "Clearly mention the lease period and rent.",
    "Read all clauses carefully before signing.",
    "Keep certified copies of the registered lease.",
    "Understand renewal and termination conditions.",
  ],

  commonMistakes: [
    "Unclear lease terms.",
    "Incorrect tenant or owner information.",
    "Failure to register where registration is legally required.",
    "Ignoring stamp duty requirements.",
  ],

  estimatedFee:
      "According to the applicable provincial registration and stamp duty schedule.",

  estimatedTime:
      "Usually completed within 1–5 working days depending upon document verification.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Prepare Lease Agreement",
      description:
          "Draft the lease agreement containing complete details of the property, rent, lease period and obligations of both parties.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Collect Required Documents",
      description:
          "Gather CNICs, ownership documents, latest Fard and supporting records.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Purchase Stamp Paper",
      description:
          "Purchase the required stamp paper according to the applicable law.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Appear Before Sub-Registrar",
      description:
          "The lessor, lessee and witnesses appear before the Registration Officer.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Identity Verification",
      description:
          "The Registration Officer verifies the identities and supporting documents.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Registration of Lease",
      description:
          "The lease agreement is officially registered and assigned a registration number.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Collect Registered Lease",
      description:
          "Receive the registered lease agreement after completion of registration.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Maintain Official Record",
      description:
          "Keep the registered lease documents safely for future legal use.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Agricultural Land Transfer
//-----------------------------------------------------------

ProcedureModel(
  id: "agricultural_land_transfer",

  categoryId: "property",

  title: "Agricultural Land Transfer",

  overview:
      "Agricultural Land Transfer is the legal process through which ownership of agricultural land is transferred from one person to another through sale, gift, inheritance, exchange, or any other legally recognized mode. The transfer must comply with applicable revenue laws and be reflected in the official land records.",

  governmentDepartment:
      "Revenue Department / Sub-Registrar Office",

  eligibility:
      "Any lawful owner of agricultural land or a person legally entitled to receive ownership under the applicable law may apply for transfer.",

  requiredDocuments: [
    "Original CNIC of Transferor",
    "Original CNIC of Transferee",
    "Latest Fard (Record of Rights)",
    "Registered Sale Deed / Gift Deed / Court Order (as applicable)",
    "Passport-size Photographs",
    "Supporting Revenue Documents",
  ],

  applicableLaws: [
    "Transfer of Property Act, 1882",
    "Registration Act, 1908",
    "Relevant Provincial Land Revenue Laws",
    "Provincial Agricultural Land Regulations (where applicable)",
  ],

  importantNotes: [
    "Verify ownership before initiating the transfer.",
    "Ensure the land is free from legal disputes or encumbrances.",
    "Complete mutation after registration.",
    "Comply with provincial restrictions on agricultural land transfer where applicable.",
  ],

  commonMistakes: [
    "Failure to verify ownership records.",
    "Ignoring pending mutations.",
    "Incomplete supporting documents.",
    "Failure to update the revenue record after transfer.",
  ],

  estimatedFee:
      "According to the applicable provincial revenue and registration fee schedule.",

  estimatedTime:
      "Usually completed within 15–45 days depending upon verification and mutation proceedings.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Verify Ownership",
      description:
          "Obtain the latest Fard and confirm ownership of the agricultural land.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Prepare Transfer Documents",
      description:
          "Prepare the sale deed, gift deed or other transfer documents as applicable.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Submit Documents",
      description:
          "Submit the required documents before the concerned Registration or Revenue Authority.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Identity Verification",
      description:
          "The identities of the parties are verified through CNIC and supporting records.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Registration",
      description:
          "Where required, the transfer document is registered before the Sub-Registrar.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Mutation Proceedings",
      description:
          "Apply for mutation to record the transfer in the revenue record.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Revenue Verification",
      description:
          "The Revenue Department verifies ownership and supporting documents.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Update Land Record",
      description:
          "The official revenue record is updated to reflect the new ownership.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Cancellation of Sale Deed
//-----------------------------------------------------------

ProcedureModel(
  id: "cancellation_of_sale_deed",

  categoryId: "property",

  title: "Cancellation of Sale Deed",

  overview:
      "Cancellation of a Sale Deed is the legal process through which a registered sale deed is annulled or declared ineffective due to fraud, misrepresentation, coercion, mutual agreement, lack of legal authority, or by an order of a competent court. The procedure depends on the facts of each case and the applicable law.",

  governmentDepartment:
      "Civil Court / Sub-Registrar Office / Registration Department",

  eligibility:
      "Any person having a legal right or interest in the property, including the seller, purchaser, legal heir, or any affected party, may seek cancellation of a sale deed where permitted by law.",

  requiredDocuments: [
    "Original CNIC of Applicant",
    "Copy of the Registered Sale Deed",
    "Ownership Documents",
    "Latest Fard (Record of Rights)",
    "Evidence Supporting Cancellation",
    "Court Order (where applicable)",
    "Supporting Revenue Documents",
  ],

  applicableLaws: [
    "Specific Relief Act, 1877",
    "Transfer of Property Act, 1882",
    "Registration Act, 1908",
    "Qanun-e-Shahadat Order, 1984 (where applicable)",
  ],

  importantNotes: [
    "A registered sale deed cannot ordinarily be cancelled without lawful grounds.",
    "Court proceedings may be required depending on the circumstances.",
    "Keep all original documents and evidence safely.",
    "Seek legal advice before initiating cancellation proceedings.",
  ],

  commonMistakes: [
    "Assuming a registered deed can be cancelled without legal grounds.",
    "Failure to preserve documentary evidence.",
    "Delay in initiating legal proceedings.",
    "Ignoring limitation periods under the applicable law.",
  ],

  estimatedFee:
      "Depends upon court fees, registration requirements and applicable government charges.",

  estimatedTime:
      "May range from several months to more than a year depending upon the facts of the case and court proceedings.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Review the Sale Deed",
      description:
          "Carefully examine the registered sale deed and identify the legal grounds for cancellation.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Collect Supporting Evidence",
      description:
          "Gather documents and evidence supporting the claim for cancellation.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Consult a Legal Professional",
      description:
          "Obtain legal advice regarding the appropriate legal remedy.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Prepare Legal Proceedings",
      description:
          "Prepare the necessary legal documents or court pleadings where required.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "File the Case",
      description:
          "File the appropriate application or civil suit before the competent court if required by law.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Court Proceedings",
      description:
          "Participate in hearings and present evidence before the competent court.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Obtain Final Order",
      description:
          "Receive the final judgment or order regarding cancellation of the sale deed.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Update Official Records",
      description:
          "Where applicable, update the registration and revenue records in accordance with the final order.",
    ),
  ],
),
];