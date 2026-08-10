import '../models/procedure_model.dart';
import '../models/procedure_step.dart';

final List<ProcedureModel> inheritanceProcedures = [

  //-----------------------------------------------------------
// Procedure: Succession Certificate
//-----------------------------------------------------------

ProcedureModel(
  id: "succession_certificate",

  categoryId: "inheritance",

  title: "Succession Certificate",

  overview:
      "A Succession Certificate is a legal document issued by the competent court declaring the lawful successors entitled to collect the debts, securities, bank accounts, shares, financial investments, and other movable assets of a deceased person. It authorizes the legal heirs to receive and administer such assets in accordance with the applicable laws of Pakistan.",

  governmentDepartment:
      "Civil Court / District Court / Competent Civil Authority",

  eligibility:
      "Any lawful legal heir or person entitled under the applicable inheritance laws may apply for a Succession Certificate after the death of the deceased person.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC of the Applicant",
    "Death Certificate of the Deceased",
    "Family Registration Certificate (FRC)",
    "List of Legal Heirs",
    "Details of Debts, Bank Accounts, Shares, Securities, or Other Movable Assets",
    "Supporting Ownership Documents",
    "Court Fee as Prescribed by Law",
  ],

  applicableLaws: [
    "Succession Act, 1925",
    "Civil Procedure Code, 1908 (where applicable)",
    "Relevant High Court Rules",
    "Applicable Personal Laws of Inheritance",
  ],

  importantNotes: [
    "A Succession Certificate generally relates to movable assets such as bank accounts, shares, and securities.",
    "Accurately disclose all legal heirs and movable assets in the application.",
    "False statements or concealment of heirs may result in legal consequences.",
    "Keep certified copies of the certificate for financial institutions and other authorities.",
  ],

  commonMistakes: [
    "Omitting legal heirs from the application.",
    "Providing incomplete details of movable assets.",
    "Submitting incorrect supporting documents.",
    "Failing to comply with court directions during proceedings.",
  ],

  estimatedFee:
      "As prescribed under the applicable court fee laws and rules.",

  estimatedTime:
      "Depends upon verification, publication of notices, hearing of objections (if any), and the court's decision.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Collect Required Documents",
      description:
          "Gather the death certificate, CNICs, family records, and documents relating to the deceased's movable assets.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Prepare Petition",
      description:
          "Prepare a succession petition containing complete details of the deceased, legal heirs, and movable assets.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "File Petition",
      description:
          "Submit the petition before the competent court together with the prescribed court fee and supporting documents.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Court Notice",
      description:
          "The court issues notices to the concerned parties and may publish a public notice where required by law.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Verification & Hearing",
      description:
          "The court verifies the evidence, hears the legal heirs and any objectors, and examines the legal entitlement of the applicants.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Court Decision",
      description:
          "Upon satisfaction, the court allows the petition and orders issuance of the Succession Certificate.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Issue Succession Certificate",
      description:
          "The court issues the official Succession Certificate in favour of the entitled legal heirs.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Use the Certificate",
      description:
          "Present the Succession Certificate before banks, financial institutions, companies, or other authorities to obtain the movable assets of the deceased.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Letter of Administration
//-----------------------------------------------------------

ProcedureModel(
  id: "letter_of_administration",

  categoryId: "inheritance",

  title: "Letter of Administration",

  overview:
      "A Letter of Administration is a legal document issued by the competent court authorizing a suitable person to administer the estate of a deceased individual who died without leaving a valid executor or where no executor is able or willing to act. It empowers the administrator to collect, manage, protect, and distribute the deceased's estate according to the applicable law.",

  governmentDepartment:
      "Civil Court / District Court / Competent Civil Authority",

  eligibility:
      "A lawful legal heir, beneficiary, creditor (where permitted), or any other person legally entitled under the applicable law may apply for a Letter of Administration.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC of the Applicant",
    "Death Certificate of the Deceased",
    "Family Registration Certificate (FRC)",
    "List of Legal Heirs",
    "Details of the Deceased's Assets and Liabilities",
    "Ownership Documents of the Estate",
    "Will (if applicable)",
    "Court Fee as Prescribed by Law",
  ],

  applicableLaws: [
    "Succession Act, 1925",
    "Civil Procedure Code, 1908 (where applicable)",
    "Relevant High Court Rules",
    "Applicable Personal Laws of Inheritance",
  ],

  importantNotes: [
    "A Letter of Administration authorizes estate administration but does not alter the legal shares of heirs.",
    "All known legal heirs should be disclosed in the petition.",
    "The administrator must act honestly and in the best interests of the estate.",
    "The court may require security or additional documentation before granting the letter.",
  ],

  commonMistakes: [
    "Concealing legal heirs or estate assets.",
    "Submitting incomplete estate information.",
    "Failing to comply with court directions.",
    "Misunderstanding the administrator's legal responsibilities.",
  ],

  estimatedFee:
      "As prescribed under the applicable court fee laws and rules.",

  estimatedTime:
      "Depends upon verification, publication of notices, hearing of objections (if any), and the court's final order.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Collect Required Documents",
      description:
          "Gather the death certificate, identity documents, family records, and documents relating to the deceased's estate.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Prepare Petition",
      description:
          "Prepare a petition requesting the grant of a Letter of Administration with complete estate details.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "File Petition",
      description:
          "Submit the petition before the competent court together with supporting documents and the prescribed court fee.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Issue of Notices",
      description:
          "The court issues notices to legal heirs and other interested persons and may publish a public notice where required.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Verification & Hearing",
      description:
          "The court verifies the evidence, hears the parties, and considers any objections before deciding the petition.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Court Approval",
      description:
          "If satisfied, the court grants the Letter of Administration in favour of the applicant.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Issue Letter of Administration",
      description:
          "The official Letter of Administration is issued by the court.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Administer the Estate",
      description:
          "Use the Letter of Administration to collect, manage, settle liabilities, and distribute the estate according to law and court directions.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Legal Heir Certificate
//-----------------------------------------------------------

ProcedureModel(
  id: "legal_heir_certificate",

  categoryId: "inheritance",

  title: "Legal Heir Certificate",

  overview:
      "A Legal Heir Certificate is an official document that identifies and certifies the lawful legal heirs of a deceased person. It is commonly required for pension claims, government service benefits, insurance claims, utility transfers, property-related matters, and other legal or administrative purposes where proof of legal heirship is necessary.",

  governmentDepartment:
      "Deputy Commissioner (DC) Office / Assistant Commissioner (AC) Office / Competent Revenue or Civil Authority (as applicable)",

  eligibility:
      "Any lawful legal heir of a deceased person may apply for a Legal Heir Certificate in accordance with the applicable laws and administrative procedures.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC of the Applicant",
    "Death Certificate of the Deceased",
    "Family Registration Certificate (FRC)",
    "CNICs of Other Legal Heirs (where available)",
    "Supporting Family Relationship Documents",
    "Affidavit (where required)",
    "Government Prescribed Fee (if applicable)",
  ],

  applicableLaws: [
    "Relevant Provincial Revenue Laws",
    "Succession Act, 1925 (where applicable)",
    "Applicable Personal Laws of Inheritance",
    "Relevant Government Notifications and Rules",
  ],

  importantNotes: [
    "Disclose all legal heirs truthfully in the application.",
    "The certificate identifies legal heirs but does not itself determine or distribute inheritance shares.",
    "Additional verification may be conducted by the competent authority.",
    "Different authorities may follow different administrative procedures depending on the province.",
  ],

  commonMistakes: [
    "Omitting one or more legal heirs.",
    "Providing incorrect family information.",
    "Submitting incomplete supporting documents.",
    "Making false declarations regarding family relationships.",
  ],

  estimatedFee:
      "As prescribed by the relevant authority, where applicable.",

  estimatedTime:
      "Depends upon verification of family records, local inquiries (if required), and approval by the competent authority.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Collect Required Documents",
      description:
          "Gather the death certificate, CNICs, family records, and all supporting documents.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Complete Application",
      description:
          "Fill in the prescribed Legal Heir Certificate application accurately.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Submit Application",
      description:
          "Submit the application together with supporting documents to the competent authority.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Verification",
      description:
          "The authority verifies the identity of the applicant, family relationships, and supporting documents.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Local Inquiry",
      description:
          "Where required, the authority may conduct a local inquiry or obtain reports from the relevant officials.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Approval",
      description:
          "After successful verification, the competent authority approves the issuance of the certificate.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Issue Legal Heir Certificate",
      description:
          "The official Legal Heir Certificate is prepared and issued.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Use the Certificate",
      description:
          "Use the certificate for lawful administrative, financial, pension, insurance, or property-related purposes where proof of legal heirship is required.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Inheritance Mutation
//-----------------------------------------------------------

ProcedureModel(
  id: "inheritance_mutation",

  categoryId: "inheritance",

  title: "Inheritance Mutation",

  overview:
      "Inheritance Mutation is the legal process through which ownership of immovable property belonging to a deceased person is transferred in the official revenue records to the lawful legal heirs. Mutation does not itself create ownership but records the transfer of ownership in the government land records based on inheritance rights recognized under the applicable law.",

  governmentDepartment:
      "Board of Revenue / Deputy Commissioner (DC) Office / Assistant Commissioner (AC) Office / Tehsil Office / Land Revenue Department",

  eligibility:
      "Any lawful legal heir or person legally entitled to inherit the immovable property of a deceased person may apply for inheritance mutation in accordance with the applicable revenue laws.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC of the Applicant",
    "Death Certificate of the Deceased",
    "Family Registration Certificate (FRC)",
    "Legal Heir Certificate or Succession Documents (where applicable)",
    "Original Property Ownership Documents",
    "Latest Fard / Record of Rights",
    "Affidavit (where required)",
    "Government Prescribed Fee",
  ],

  applicableLaws: [
    "Land Revenue Act (Applicable Province)",
    "Board of Revenue Rules",
    "Succession Act, 1925 (where applicable)",
    "Applicable Personal Laws of Inheritance",
  ],

  importantNotes: [
    "Mutation updates government land records but does not by itself determine title ownership.",
    "All legal heirs should be disclosed during the mutation proceedings.",
    "Ensure that property records accurately match the deceased's ownership details.",
    "Keep certified copies of the mutation order for future property transactions.",
  ],

  commonMistakes: [
    "Omitting legal heirs from the mutation proceedings.",
    "Submitting incomplete property documents.",
    "Providing incorrect revenue record details.",
    "Ignoring objections raised during verification.",
  ],

  estimatedFee:
      "As prescribed under the applicable provincial revenue laws and rules.",

  estimatedTime:
      "Depends upon verification of ownership records, field inquiry (where required), hearing of objections, and approval by the Revenue Officer.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Collect Required Documents",
      description:
          "Gather the death certificate, family records, property ownership documents, and supporting revenue records.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Submit Mutation Application",
      description:
          "Submit the inheritance mutation application before the competent Revenue Officer together with the required documents.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Verification of Documents",
      description:
          "The Revenue Officer verifies the identity of the legal heirs and the ownership records of the property.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Notice to Interested Parties",
      description:
          "Where required, notices are issued to legal heirs and other interested persons for objections, if any.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Revenue Inquiry",
      description:
          "The Revenue Officer conducts the necessary inquiry and records statements of the legal heirs where applicable.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Mutation Order",
      description:
          "Upon satisfaction, the Revenue Officer sanctions the inheritance mutation in favour of the lawful legal heirs.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Update Revenue Records",
      description:
          "The inheritance mutation is entered into the official land revenue records.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Receive Certified Mutation",
      description:
          "Obtain a certified copy of the sanctioned mutation for future legal and property-related use.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Estate Administration
//-----------------------------------------------------------

ProcedureModel(
  id: "estate_administration",

  categoryId: "inheritance",

  title: "Estate Administration",

  overview:
      "Estate Administration is the legal process of collecting, preserving, managing, settling liabilities, and distributing the assets of a deceased person under the supervision of the competent authority where required. The administrator or executor acts in accordance with the applicable law, the deceased's valid will (if any), and the lawful rights of the legal heirs and beneficiaries.",

  governmentDepartment:
      "Civil Court / District Court / Competent Civil Authority / Revenue Authorities (where applicable)",

  eligibility:
      "An executor named in a valid will, an administrator appointed by the court, or any person legally authorized under the applicable law may administer the estate of a deceased person.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC of the Executor or Administrator",
    "Death Certificate of the Deceased",
    "Succession Certificate or Letter of Administration (where applicable)",
    "Probated Will (where applicable)",
    "List of Legal Heirs and Beneficiaries",
    "Inventory of Assets and Liabilities",
    "Property Ownership Documents",
    "Court Orders (where applicable)",
  ],

  applicableLaws: [
    "Succession Act, 1925",
    "Civil Procedure Code, 1908 (where applicable)",
    "Applicable Personal Laws of Inheritance",
    "Relevant High Court Rules",
  ],

  importantNotes: [
    "Prepare a complete inventory of all movable and immovable assets.",
    "Outstanding debts, taxes, and lawful liabilities should generally be settled before distribution of the estate.",
    "Maintain accurate financial records throughout the administration process.",
    "Act impartially and in the best interests of all legal heirs and beneficiaries.",
  ],

  commonMistakes: [
    "Distributing the estate before settling liabilities.",
    "Failing to maintain proper records of estate transactions.",
    "Concealing estate assets or beneficiaries.",
    "Ignoring court directions or legal obligations.",
  ],

  estimatedFee:
      "Depends upon the nature of the proceedings and any applicable court or administrative charges.",

  estimatedTime:
      "Varies according to the size of the estate, verification process, settlement of liabilities, and resolution of any disputes.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Identify Estate Assets",
      description:
          "Prepare a complete inventory of all movable and immovable assets, liabilities, and legal obligations of the deceased.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Obtain Legal Authority",
      description:
          "Obtain the necessary legal authority to administer the estate, such as a Succession Certificate, Probate, or Letter of Administration where required.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Notify Concerned Parties",
      description:
          "Notify beneficiaries, legal heirs, financial institutions, and other relevant parties of the estate administration process.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Collect Estate Assets",
      description:
          "Take lawful control of the estate assets and preserve them until final distribution.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Settle Debts and Liabilities",
      description:
          "Pay lawful debts, taxes, expenses, and other obligations from the estate in accordance with the applicable law.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Prepare Distribution Plan",
      description:
          "Determine the lawful distribution of the remaining estate among the legal heirs or beneficiaries.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Distribute Estate",
      description:
          "Transfer the remaining estate to the entitled legal heirs or beneficiaries according to the applicable law or the valid will.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Close Estate Administration",
      description:
          "Complete the administration process, maintain final records, and comply with any court or legal requirements before closing the estate.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Distribution of Inherited Property
//-----------------------------------------------------------

ProcedureModel(
  id: "distribution_of_inherited_property",

  categoryId: "inheritance",

  title: "Distribution of Inherited Property",

  overview:
      "Distribution of Inherited Property is the legal process through which the estate of a deceased person is divided among the lawful legal heirs or beneficiaries in accordance with the applicable inheritance laws or a valid will, where legally enforceable. The distribution may include movable and immovable assets after settlement of lawful debts, taxes, expenses, and other liabilities.",

  governmentDepartment:
      "Civil Court / Revenue Department / Competent Civil Authority (where applicable)",

  eligibility:
      "Lawful legal heirs, beneficiaries named in a valid will, executors, administrators, or persons legally authorized to distribute the estate may initiate the distribution process after fulfilling the applicable legal requirements.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC of Legal Heirs",
    "Death Certificate of the Deceased",
    "Succession Certificate, Letter of Administration, or Probate (where applicable)",
    "Legal Heir Certificate (where applicable)",
    "Inventory of Estate Assets",
    "Property Ownership Documents",
    "Valid Will (where applicable)",
    "Court Orders (where applicable)",
  ],

  applicableLaws: [
    "Succession Act, 1925",
    "Applicable Personal Laws of Inheritance",
    "Civil Procedure Code, 1908 (where applicable)",
    "Relevant Provincial Revenue Laws",
  ],

  importantNotes: [
    "All lawful debts, taxes, funeral expenses, and liabilities should generally be settled before distributing the estate.",
    "Distribution should comply with the applicable inheritance law or any legally enforceable will.",
    "Maintain proper records of all distributed assets.",
    "Where disputes arise, distribution may require court intervention.",
  ],

  commonMistakes: [
    "Distributing property before settlement of liabilities.",
    "Ignoring the lawful shares of legal heirs.",
    "Failing to document the distribution properly.",
    "Concealing estate assets during distribution.",
  ],

  estimatedFee:
      "Depends upon the nature of the proceedings and any applicable court or administrative charges.",

  estimatedTime:
      "Varies according to the complexity of the estate, verification process, and resolution of disputes, if any.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Confirm Legal Authority",
      description:
          "Ensure that the necessary succession documents or court orders have been obtained where required.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Prepare Asset Inventory",
      description:
          "Prepare a complete list of movable and immovable assets forming part of the estate.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Settle Liabilities",
      description:
          "Pay lawful debts, taxes, expenses, and other liabilities before distributing the remaining estate.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Determine Legal Shares",
      description:
          "Identify the lawful entitlement of each legal heir or beneficiary according to the applicable law or valid will.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Prepare Distribution Record",
      description:
          "Document the details of assets allocated to each legal heir or beneficiary.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Obtain Consent or Court Approval",
      description:
          "Where required, obtain the consent of all legal heirs or approval from the competent court.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Transfer Assets",
      description:
          "Transfer the distributed assets to the entitled legal heirs through the appropriate legal process.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Maintain Final Records",
      description:
          "Preserve all distribution documents and transfer records for future legal, financial, and administrative purposes.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Transfer of Inherited Property
//-----------------------------------------------------------

ProcedureModel(
  id: "transfer_of_inherited_property",

  categoryId: "inheritance",

  title: "Transfer of Inherited Property",

  overview:
      "Transfer of Inherited Property is the legal process through which ownership of property inherited from a deceased person is formally transferred to the lawful legal heirs in the relevant government records. The transfer may involve land, houses, commercial properties, apartments, agricultural land, or other immovable property after completion of the applicable inheritance formalities.",

  governmentDepartment:
      "Board of Revenue / Land Revenue Department / Housing Authority / Development Authority / Relevant Registration Authority",

  eligibility:
      "Any lawful legal heir who has acquired inheritance rights under the applicable law or a competent court order may apply for transfer of inherited property.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC of the Applicant",
    "Death Certificate of the Deceased",
    "Succession Certificate or Court Order (where applicable)",
    "Inheritance Mutation Record",
    "Original Property Ownership Documents",
    "Family Registration Certificate (FRC)",
    "Latest Fard / Record of Rights",
    "Government Prescribed Fee",
  ],

  applicableLaws: [
    "Land Revenue Act (Applicable Province)",
    "Registration Act, 1908",
    "Succession Act, 1925",
    "Applicable Personal Laws of Inheritance",
    "Relevant Housing Authority Rules (where applicable)",
  ],

  importantNotes: [
    "Ensure inheritance mutation has been completed before applying for property transfer where required.",
    "Outstanding taxes, dues, or utility liabilities should be cleared before transfer.",
    "Verify that all ownership documents accurately match the revenue records.",
    "Maintain certified copies of all transfer documents for future transactions.",
  ],

  commonMistakes: [
    "Applying before completion of inheritance mutation.",
    "Submitting outdated ownership records.",
    "Failing to obtain consent where jointly required.",
    "Ignoring unpaid government dues attached to the property.",
  ],

  estimatedFee:
      "As prescribed by the relevant authority under the applicable fee schedule.",

  estimatedTime:
      "Depends upon document verification, revenue record updates, and approval by the competent authority.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Collect Required Documents",
      description:
          "Gather inheritance documents, property ownership records, revenue documents, and identity documents.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Complete Transfer Application",
      description:
          "Fill in the prescribed application for transfer of inherited property.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Submit Application",
      description:
          "Submit the application together with supporting documents and the prescribed fee to the competent authority.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Verification",
      description:
          "The authority verifies the inheritance documents, ownership records, and identity of the legal heirs.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Inspection or Revenue Inquiry",
      description:
          "Where required, the authority conducts a site inspection or revenue inquiry before approving the transfer.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Approval",
      description:
          "The competent authority approves the transfer after successful verification.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Update Ownership Records",
      description:
          "The official ownership records are updated in the name of the lawful legal heir or heirs.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Receive Updated Record",
      description:
          "Obtain the updated ownership documents and revenue records showing the transferred ownership.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Partition of Joint Inherited Property
//-----------------------------------------------------------

ProcedureModel(
  id: "partition_of_joint_inherited_property",

  categoryId: "inheritance",

  title: "Partition of Joint Inherited Property",

  overview:
      "Partition of Joint Inherited Property is the legal process through which jointly inherited property is divided among the lawful legal heirs so that each heir receives a separate and identifiable share in accordance with the applicable inheritance laws or a lawful settlement. Partition may be effected by mutual agreement or through court proceedings where disputes exist.",

  governmentDepartment:
      "Civil Court / Revenue Department / Board of Revenue / Competent Revenue Authority",

  eligibility:
      "Any co-owner or lawful legal heir having an ownership interest in jointly inherited property may apply for partition under the applicable law.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC of the Applicant",
    "Death Certificate of the Deceased",
    "Inheritance Mutation Record",
    "Property Ownership Documents",
    "Latest Fard / Record of Rights",
    "Site Plan or Property Map (where applicable)",
    "Consent of Co-heirs (where applicable)",
    "Court Fee or Government Prescribed Fee",
  ],

  applicableLaws: [
    "Partition Act, 1893",
    "Civil Procedure Code, 1908",
    "Land Revenue Act (Applicable Province)",
    "Succession Act, 1925",
    "Applicable Personal Laws of Inheritance",
  ],

  importantNotes: [
    "Partition by mutual agreement is generally quicker and less costly than litigation.",
    "Every legal heir should be given an opportunity to participate in the proceedings.",
    "Accurate property measurements and boundaries are essential.",
    "The final partition should be properly recorded in the relevant revenue records.",
  ],

  commonMistakes: [
    "Ignoring the rights of one or more co-heirs.",
    "Using outdated property records.",
    "Failing to update revenue records after partition.",
    "Proceeding without obtaining necessary approvals where required.",
  ],

  estimatedFee:
      "Depends upon the applicable court fees, revenue charges, and administrative fees.",

  estimatedTime:
      "Varies depending on whether the partition is by mutual consent or through contested legal proceedings.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Collect Property Documents",
      description:
          "Gather ownership documents, inheritance records, revenue records, and identification documents.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Attempt Mutual Settlement",
      description:
          "Where possible, attempt to reach a mutually agreed partition among all co-heirs.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Submit Partition Application",
      description:
          "Submit the partition application before the competent revenue authority or civil court.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Verification",
      description:
          "The authority verifies ownership, inheritance records, and the shares of all co-heirs.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Survey and Measurement",
      description:
          "Where required, the property is surveyed and measured to facilitate lawful partition.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Partition Order",
      description:
          "The competent authority or court passes an order specifying the respective shares of the co-heirs.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Update Revenue Records",
      description:
          "Separate ownership records are prepared and entered into the official revenue record.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Receive Updated Ownership Documents",
      description:
          "Obtain certified copies of the updated ownership and revenue records reflecting the completed partition.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Relinquishment (Release) Deed
//-----------------------------------------------------------

ProcedureModel(
  id: "relinquishment_release_deed",

  categoryId: "inheritance",

  title: "Relinquishment (Release) Deed",

  overview:
      "A Relinquishment (Release) Deed is a legal document through which one or more legal heirs voluntarily surrender, release, or relinquish their ownership rights or inheritance share in favour of another lawful legal heir or co-owner. Once duly executed and registered where required by law, the relinquished share passes to the beneficiary in accordance with the applicable legal provisions.",

  governmentDepartment:
      "Sub-Registrar / Registrar Office / Land Revenue Department (where applicable)",

  eligibility:
      "Any competent legal heir or co-owner having a lawful share in inherited property may voluntarily execute a Relinquishment (Release) Deed in favour of another eligible legal heir or co-owner.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC of All Parties",
    "Inheritance Mutation Record",
    "Property Ownership Documents",
    "Latest Fard / Record of Rights",
    "Draft Relinquishment (Release) Deed",
    "Passport-sized Photographs (where required)",
    "Applicable Stamp Duty and Registration Fee",
  ],

  applicableLaws: [
    "Registration Act, 1908",
    "Stamp Act, 1899",
    "Transfer of Property Act, 1882 (where applicable)",
    "Land Revenue Act (Applicable Province)",
    "Applicable Personal Laws of Inheritance",
  ],

  importantNotes: [
    "The deed should clearly specify the property and the share being relinquished.",
    "Execution should be voluntary and free from fraud, coercion, or undue influence.",
    "Registration may be mandatory depending on the nature of the property and applicable law.",
    "Retain certified copies of the registered deed for future legal use.",
  ],

  commonMistakes: [
    "Incorrect description of the property or ownership share.",
    "Failure to register the deed where registration is legally required.",
    "Ignoring applicable stamp duty requirements.",
    "Signing the deed without fully understanding its legal consequences.",
  ],

  estimatedFee:
      "Applicable stamp duty, registration charges, and other government fees as prescribed by law.",

  estimatedTime:
      "Depends upon document verification, execution, registration formalities, and updating of official records.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Verify Ownership",
      description:
          "Confirm the inheritance rights and ownership share of the person intending to relinquish the property.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Prepare the Deed",
      description:
          "Draft the Relinquishment (Release) Deed containing complete property and ownership details.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Collect Supporting Documents",
      description:
          "Gather identity documents, ownership records, inheritance documents, and revenue records.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Pay Applicable Duties",
      description:
          "Pay the prescribed stamp duty, registration fee, and any other applicable government charges.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Execute the Deed",
      description:
          "The parties sign the deed before the competent authority and witnesses where required.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Register the Deed",
      description:
          "Register the deed with the appropriate registration authority where registration is required by law.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Update Revenue Records",
      description:
          "Apply for updating the land or ownership records to reflect the relinquishment.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Receive Updated Records",
      description:
          "Obtain certified copies of the registered deed and updated ownership records for future legal purposes.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Gift of Inherited Share
//-----------------------------------------------------------

ProcedureModel(
  id: "gift_of_inherited_share",

  categoryId: "inheritance",

  title: "Gift of Inherited Share",

  overview:
      "Gift of Inherited Share is the legal process through which a lawful legal heir voluntarily transfers his or her inherited ownership share to another person by way of a gift during his or her lifetime. The transfer must satisfy the legal requirements governing gifts and, where applicable, registration and mutation formalities.",

  governmentDepartment:
      "Sub-Registrar / Registrar Office / Land Revenue Department / Housing Authority (where applicable)",

  eligibility:
      "Any competent legal heir who has lawfully acquired ownership of an inherited share may voluntarily gift that share to another person in accordance with the applicable law.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC of Donor and Donee",
    "Inheritance Mutation Record",
    "Property Ownership Documents",
    "Latest Fard / Record of Rights",
    "Draft Gift Deed",
    "Passport-sized Photographs (where required)",
    "Applicable Stamp Duty and Registration Fee",
  ],

  applicableLaws: [
    "Transfer of Property Act, 1882 (where applicable)",
    "Registration Act, 1908",
    "Stamp Act, 1899",
    "Land Revenue Act (Applicable Province)",
    "Applicable Personal Laws governing Gifts and Inheritance",
  ],

  importantNotes: [
    "The donor must have lawful ownership and legal capacity to make the gift.",
    "The gift should be made voluntarily without fraud, coercion, or undue influence.",
    "Registration and mutation requirements should be completed where applicable.",
    "Keep certified copies of all registered documents for future legal purposes.",
  ],

  commonMistakes: [
    "Attempting to gift property before acquiring lawful ownership.",
    "Preparing an incomplete or inaccurate gift deed.",
    "Ignoring registration or mutation requirements.",
    "Failing to pay applicable government charges.",
  ],

  estimatedFee:
      "Applicable stamp duty, registration charges, mutation fee, and other prescribed government fees.",

  estimatedTime:
      "Depends upon document verification, registration formalities, mutation proceedings, and approval by the competent authority.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Verify Ownership",
      description:
          "Confirm that the donor has lawful ownership of the inherited share.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Prepare Gift Deed",
      description:
          "Prepare the Gift Deed containing complete details of the parties, property, and gifted share.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Collect Supporting Documents",
      description:
          "Gather identity documents, ownership records, inheritance documents, and revenue records.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Pay Applicable Duties",
      description:
          "Pay the prescribed stamp duty, registration fee, mutation fee, and other applicable government charges.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Execute the Gift Deed",
      description:
          "The donor executes the Gift Deed voluntarily before the competent authority and witnesses where required.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Register the Gift Deed",
      description:
          "Register the Gift Deed where registration is required under the applicable law.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Complete Mutation",
      description:
          "Apply for mutation of the gifted share in the official revenue or ownership records.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Receive Updated Ownership Record",
      description:
          "Obtain the updated ownership documents and certified records showing the gifted share in the donee's name.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Will (Wasiyat) Registration
//-----------------------------------------------------------

ProcedureModel(
  id: "will_registration",

  categoryId: "inheritance",

  title: "Will (Wasiyat) Registration",

  overview:
      "A Will (Wasiyat) is a legal declaration made by a competent person specifying how his or her estate should be distributed after death, subject to the applicable laws of Pakistan. Although registration of a will is not mandatory in every case, registering it can strengthen its evidentiary value and help reduce future disputes regarding authenticity.",

  governmentDepartment:
      "Sub-Registrar / Registrar Office",

  eligibility:
      "Any adult person of sound mind who is legally competent to make a will may voluntarily register it in accordance with the applicable law.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC of the Testator",
    "Draft Will (Wasiyat)",
    "Passport-sized Photographs (where required)",
    "CNICs of Witnesses",
    "Property Ownership Documents (where applicable)",
    "Applicable Registration Fee",
  ],

  applicableLaws: [
    "Succession Act, 1925",
    "Registration Act, 1908",
    "Applicable Personal Laws governing Wills",
  ],

  importantNotes: [
    "The will should clearly identify the beneficiaries and the assets covered.",
    "The testator must execute the will voluntarily while of sound mind.",
    "Witnesses should be legally competent.",
    "The will may be amended or revoked during the lifetime of the testator in accordance with law.",
  ],

  commonMistakes: [
    "Preparing an ambiguous or incomplete will.",
    "Failing to properly identify beneficiaries or assets.",
    "Using ineligible or unavailable witnesses.",
    "Failing to update the will after significant life events.",
  ],

  estimatedFee:
      "As prescribed under the applicable registration laws.",

  estimatedTime:
      "Usually depends on document verification and registration formalities.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Prepare the Will",
      description:
          "Draft a clear and legally compliant will describing the distribution of the estate.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Collect Supporting Documents",
      description:
          "Gather identity documents, property records, and witness details.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Visit the Registrar Office",
      description:
          "Appear before the competent registration authority with the required documents.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Verification",
      description:
          "The authority verifies the identity and legal capacity of the testator.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Execution of Will",
      description:
          "The testator signs the will voluntarily in the presence of the required witnesses.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Registration",
      description:
          "The registrar records the will where registration is sought and legally permissible.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Preservation",
      description:
          "Maintain the registered will securely and inform trusted persons of its existence.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Future Revision (If Required)",
      description:
          "Review and update the will whenever significant personal or financial circumstances change.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Probate of Will
//-----------------------------------------------------------

ProcedureModel(
  id: "probate_of_will",

  categoryId: "inheritance",

  title: "Probate of Will",

  overview:
      "Probate of a Will is the legal process through which a competent court verifies the authenticity and validity of a deceased person's will and grants authority to the executor named in the will to administer and distribute the estate according to its terms. Probate provides legal recognition of the will and protects the executor in carrying out his or her duties.",

  governmentDepartment:
      "District Court / Civil Court having Probate Jurisdiction",

  eligibility:
      "The executor named in the will, or any person legally entitled under the applicable law, may apply for probate after the death of the testator.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC of the Applicant",
    "Original Will (Wasiyat)",
    "Death Certificate of the Testator",
    "List of Legal Heirs and Beneficiaries",
    "Property Ownership Documents",
    "Affidavit (where required)",
    "Court Fee as Prescribed by Law",
  ],

  applicableLaws: [
    "Succession Act, 1925",
    "Civil Procedure Code, 1908 (where applicable)",
    "Relevant High Court Rules",
    "Applicable Personal Laws governing Wills",
  ],

  importantNotes: [
    "Probate confirms the legal validity of the will but does not alter the applicable law regarding inheritance.",
    "The original will should be preserved and produced before the court.",
    "Interested parties may file objections during probate proceedings.",
    "The executor must faithfully administer the estate after probate is granted.",
  ],

  commonMistakes: [
    "Submitting a damaged or incomplete original will.",
    "Failing to disclose all legal heirs or beneficiaries.",
    "Ignoring objections or court notices.",
    "Delaying probate where the will governs significant assets.",
  ],

  estimatedFee:
      "As prescribed under the applicable court fee laws and rules.",

  estimatedTime:
      "Depends upon verification of the will, publication of notices, hearing of objections (if any), and the court's decision.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Collect Required Documents",
      description:
          "Gather the original will, death certificate, identity documents, and all supporting records relating to the estate.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Prepare Probate Petition",
      description:
          "Prepare a probate petition containing details of the deceased, executor, beneficiaries, and estate.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "File Petition",
      description:
          "Submit the probate petition before the competent court together with the prescribed court fee and supporting documents.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Issue Notices",
      description:
          "The court issues notices to legal heirs and other interested persons and may publish a public notice where required.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Verification & Hearing",
      description:
          "The court verifies the authenticity of the will, records evidence, and hears any objections raised by interested parties.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Court Decision",
      description:
          "If satisfied regarding the validity of the will, the court grants probate in favour of the executor.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Issue Probate",
      description:
          "The official Probate Order is issued authorizing the executor to administer the estate.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Administer the Estate",
      description:
          "The executor administers and distributes the estate in accordance with the probated will and applicable law.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Inheritance Dispute
//-----------------------------------------------------------

ProcedureModel(
  id: "inheritance_dispute",

  categoryId: "inheritance",

  title: "Inheritance Dispute",

  overview:
      "An Inheritance Dispute arises when legal heirs, beneficiaries, or other interested persons disagree regarding the ownership, distribution, validity of a will, inheritance shares, or administration of a deceased person's estate. Such disputes are resolved by the competent court in accordance with the applicable inheritance laws of Pakistan.",

  governmentDepartment:
      "Civil Court / District Court / Competent Civil Authority",

  eligibility:
      "Any legal heir, beneficiary, executor, administrator, or person claiming a lawful interest in the estate may institute or defend inheritance proceedings before the competent court.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC of the Applicant",
    "Death Certificate of the Deceased",
    "Family Registration Certificate (FRC)",
    "Succession Certificate, Probate, or Letter of Administration (where applicable)",
    "Property Ownership Documents",
    "Will (if applicable)",
    "Evidence Supporting the Claim",
    "Court Fee as Prescribed by Law",
  ],

  applicableLaws: [
    "Succession Act, 1925",
    "Civil Procedure Code, 1908",
    "Qanun-e-Shahadat Order, 1984",
    "Applicable Personal Laws of Inheritance",
  ],

  importantNotes: [
    "Court proceedings may involve documentary evidence, witness testimony, and expert evidence where required.",
    "Every interested legal heir should be properly impleaded in the proceedings.",
    "Attempting lawful settlement or mediation may reduce litigation time and expense.",
    "Court orders should be implemented promptly after becoming legally enforceable.",
  ],

  commonMistakes: [
    "Failing to include all necessary parties.",
    "Concealing material facts or estate assets.",
    "Submitting incomplete documentary evidence.",
    "Ignoring limitation periods or court directions.",
  ],

  estimatedFee:
      "Depends upon the applicable court fee laws and the nature of the dispute.",

  estimatedTime:
      "Varies according to the complexity of the dispute, evidence, and court proceedings.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Collect Relevant Documents",
      description:
          "Gather inheritance documents, ownership records, succession documents, wills (if any), and supporting evidence.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Seek Legal Advice",
      description:
          "Obtain legal advice to understand the applicable inheritance laws and available legal remedies.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Attempt Settlement",
      description:
          "Where appropriate, attempt an amicable settlement or mediation before initiating litigation.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "File Civil Suit",
      description:
          "File the appropriate inheritance suit before the competent civil court together with the required documents and court fee.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Court Proceedings",
      description:
          "The court records evidence, hears the parties, examines witnesses, and considers legal arguments.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Judgment",
      description:
          "The court decides the inheritance dispute in accordance with the applicable law and evidence presented.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Implementation of Judgment",
      description:
          "Carry out the court's judgment by updating records, transferring property, or taking other lawful steps.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Appeal (If Permitted)",
      description:
          "Where legally permissible, an aggrieved party may file an appeal before the competent appellate court within the prescribed limitation period.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Recovery of Inheritance Share
//-----------------------------------------------------------

ProcedureModel(
  id: "recovery_of_inheritance_share",

  categoryId: "inheritance",

  title: "Recovery of Inheritance Share",

  overview:
      "Recovery of Inheritance Share is the legal process through which a lawful heir seeks possession, restoration, or enforcement of his or her lawful inheritance rights when another person has unlawfully withheld, occupied, transferred, or denied the heir's share in the estate of a deceased person. Relief may be sought through the competent court and relevant revenue authorities, depending on the nature of the property and dispute.",

  governmentDepartment:
      "Civil Court / District Court / Revenue Department / Board of Revenue (where applicable)",

  eligibility:
      "Any lawful legal heir or beneficiary whose inheritance rights have been denied, withheld, or unlawfully interfered with may seek recovery through the competent legal forum.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC of the Applicant",
    "Death Certificate of the Deceased",
    "Family Registration Certificate (FRC)",
    "Succession Certificate, Probate, or Letter of Administration (where applicable)",
    "Inheritance Mutation Record (if available)",
    "Property Ownership Documents",
    "Revenue Records (Fard, Jamabandi, etc.)",
    "Evidence Supporting the Claim",
    "Court Fee as Prescribed by Law",
  ],

  applicableLaws: [
    "Succession Act, 1925",
    "Civil Procedure Code, 1908",
    "Specific Relief Act, 1877 (where applicable)",
    "Land Revenue Act (Applicable Province)",
    "Applicable Personal Laws of Inheritance",
  ],

  importantNotes: [
    "File the claim within the applicable limitation period.",
    "Maintain documentary evidence establishing inheritance rights.",
    "Revenue records should be updated after obtaining a favourable judgment.",
    "Court orders should be implemented promptly to avoid future disputes.",
  ],

  commonMistakes: [
    "Delaying legal action unnecessarily.",
    "Submitting incomplete documentary evidence.",
    "Ignoring limitation periods.",
    "Failing to include all necessary parties in the proceedings.",
  ],

  estimatedFee:
      "Depends upon the applicable court fee laws and the nature of the claim.",

  estimatedTime:
      "Varies according to the complexity of the dispute, availability of evidence, and court proceedings.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Collect Evidence",
      description:
          "Gather all inheritance documents, ownership records, revenue records, and evidence supporting the claim.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Obtain Legal Advice",
      description:
          "Consult a legal professional to assess the available remedies and documentation.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Attempt Settlement",
      description:
          "Where appropriate, attempt an amicable settlement with the other parties before litigation.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "File Legal Proceedings",
      description:
          "Institute the appropriate proceedings before the competent court seeking recovery of the inheritance share.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Court Hearing",
      description:
          "Present documentary evidence, witnesses, and legal arguments before the court.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Judgment",
      description:
          "The court determines the lawful inheritance rights of the parties and grants appropriate relief where justified.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Implementation",
      description:
          "Implement the court's decision by obtaining possession, updating revenue records, or completing other required legal formalities.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Maintain Updated Records",
      description:
          "Keep certified copies of the judgment, updated ownership records, and all related documents for future legal use.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Correction of Inheritance Record
//-----------------------------------------------------------

ProcedureModel(
  id: "correction_of_inheritance_record",

  categoryId: "inheritance",

  title: "Correction of Inheritance Record",

  overview:
      "Correction of Inheritance Record is the legal process through which errors, omissions, or incorrect entries in inheritance-related revenue or official records are rectified. Corrections may be required due to clerical mistakes, incorrect particulars of legal heirs, inaccurate property descriptions, or implementation of a court order. The competent authority examines the evidence before making any lawful correction.",

  governmentDepartment:
      "Board of Revenue / Land Revenue Department / Assistant Commissioner (AC) Office / Deputy Commissioner (DC) Office / Civil Court (where applicable)",

  eligibility:
      "Any lawful legal heir, beneficiary, or person having a legal interest in the inheritance record may apply for correction in accordance with the applicable law.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC of the Applicant",
    "Inheritance Mutation Record",
    "Death Certificate of the Deceased",
    "Family Registration Certificate (FRC)",
    "Property Ownership Documents",
    "Latest Fard / Record of Rights",
    "Supporting Documentary Evidence",
    "Court Order (where applicable)",
    "Government Prescribed Fee",
  ],

  applicableLaws: [
    "Land Revenue Act (Applicable Province)",
    "Board of Revenue Rules",
    "Succession Act, 1925",
    "Civil Procedure Code, 1908 (where applicable)",
    "Applicable Personal Laws of Inheritance",
  ],

  importantNotes: [
    "Provide accurate documentary evidence supporting the requested correction.",
    "Correction proceedings do not ordinarily create new ownership rights; they rectify official records.",
    "Where title is disputed, separate civil proceedings may be necessary.",
    "Retain certified copies of all corrected records for future transactions.",
  ],

  commonMistakes: [
    "Submitting insufficient documentary evidence.",
    "Requesting correction without supporting legal authority.",
    "Ignoring notices issued by the competent authority.",
    "Failing to verify the corrected record after approval.",
  ],

  estimatedFee:
      "As prescribed under the applicable revenue laws and administrative rules.",

  estimatedTime:
      "Depends upon verification of records, inquiry (where required), and approval by the competent authority.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Identify the Error",
      description:
          "Identify the incorrect entry, omission, or clerical mistake in the inheritance record.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Collect Supporting Documents",
      description:
          "Gather identity documents, inheritance records, property documents, and evidence supporting the requested correction.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Submit Correction Application",
      description:
          "Submit the prescribed application before the competent authority together with all supporting documents and the applicable fee.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Verification",
      description:
          "The authority verifies the documents, revenue records, and the factual basis of the requested correction.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Inquiry or Hearing",
      description:
          "Where necessary, the authority conducts an inquiry or hears the affected parties before making a decision.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Correction Order",
      description:
          "If satisfied, the competent authority passes an order directing correction of the inheritance record.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Update Official Records",
      description:
          "The corrected particulars are entered into the official revenue or inheritance records.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Receive Corrected Record",
      description:
          "Obtain certified copies of the corrected inheritance record for future legal and administrative purposes.",
    ),
  ],
),

];