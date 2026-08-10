import '../models/procedure_model.dart';
import '../models/procedure_step.dart';

final List<ProcedureModel> civilProcedures = [

  //-----------------------------------------------------------
// Procedure: Civil Suit Filing
//-----------------------------------------------------------

ProcedureModel(
  id: "civil_suit_filing",

  categoryId: "civil",

  title: "Civil Suit Filing",

  overview:
      "A Civil Suit is a legal proceeding instituted before a competent civil court to enforce or protect civil rights relating to property, contracts, recovery of money, declarations, injunctions, damages, or other civil matters. The suit is initiated by filing a plaint in accordance with the applicable law.",

  governmentDepartment:
      "Civil Court",

  eligibility:
      "Any person whose civil or legal rights have been violated or require judicial determination may institute a civil suit before the competent court having jurisdiction.",

  requiredDocuments: [
    "Original CNIC of Plaintiff",
    "Plaint",
    "Supporting Documents",
    "Relevant Agreements or Contracts (if applicable)",
    "Property Documents (if applicable)",
    "List of Witnesses",
    "Vakalatnama",
  ],

  applicableLaws: [
    "Code of Civil Procedure, 1908",
    "Qanun-e-Shahadat Order, 1984",
    "Specific Relief Act, 1877 (where applicable)",
    "Relevant Special Laws",
  ],

  importantNotes: [
    "File the suit before the court having proper territorial and pecuniary jurisdiction.",
    "Clearly state all material facts.",
    "Attach all supporting documents.",
    "Pay the prescribed court fee.",
  ],

  commonMistakes: [
    "Filing before the wrong court.",
    "Insufficient court fee.",
    "Incomplete plaint.",
    "Failure to attach supporting documents.",
  ],

  estimatedFee:
      "Court fee according to the Court Fees Act and applicable provincial rules.",

  estimatedTime:
      "Varies depending upon the nature of the suit and the workload of the court.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Consult Legal Counsel",
      description:
          "Determine the appropriate legal remedy and prepare the case.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Collect Documents",
      description:
          "Gather all relevant documents and evidence supporting the claim.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Draft Plaint",
      description:
          "Prepare the plaint containing all material facts, relief sought, and legal grounds.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Determine Jurisdiction",
      description:
          "Identify the competent court having territorial and pecuniary jurisdiction.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Pay Court Fee",
      description:
          "Calculate and deposit the prescribed court fee.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "File the Suit",
      description:
          "Submit the plaint and supporting documents before the competent civil court.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Issuance of Summons",
      description:
          "The court scrutinizes the plaint and issues summons to the defendant where appropriate.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Commencement of Proceedings",
      description:
          "The civil suit proceeds in accordance with the Code of Civil Procedure.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Temporary Injunction
//-----------------------------------------------------------

ProcedureModel(
  id: "temporary_injunction",

  categoryId: "civil",

  title: "Temporary Injunction",

  overview:
      "A Temporary Injunction is an interim relief granted by a competent civil court to preserve the existing state of affairs and prevent irreparable loss or injury until the final decision of the suit. The court considers whether there is a prima facie case, balance of convenience, and likelihood of irreparable harm before granting the injunction.",

  governmentDepartment:
      "Civil Court",

  eligibility:
      "A party to a civil dispute may seek a temporary injunction where immediate protection of legal rights or property is necessary pending the final disposal of the suit.",

  requiredDocuments: [
    "Original CNIC of Applicant",
    "Plaint",
    "Application for Temporary Injunction",
    "Supporting Documents",
    "Property Documents (if applicable)",
    "Affidavit",
    "Vakalatnama",
  ],

  applicableLaws: [
    "Code of Civil Procedure, 1908",
    "Specific Relief Act, 1877",
    "Relevant Judicial Precedents",
  ],

  importantNotes: [
    "File the injunction application along with or during the civil suit.",
    "Clearly establish a prima facie case.",
    "Demonstrate irreparable loss if relief is denied.",
    "Provide all relevant supporting documents.",
  ],

  commonMistakes: [
    "Failure to establish urgency.",
    "Insufficient documentary evidence.",
    "Filing before the wrong court.",
    "Incomplete application.",
  ],

  estimatedFee:
      "Court fee according to the applicable rules.",

  estimatedTime:
      "Urgent applications may be heard on the same day or within a few days depending on the court.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Prepare Application",
      description:
          "Prepare an application for temporary injunction with supporting facts and legal grounds.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Collect Evidence",
      description:
          "Gather documents proving ownership, possession or the threatened violation of rights.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "File Before Court",
      description:
          "Submit the application before the competent civil court along with the plaint or during the proceedings.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Urgent Hearing",
      description:
          "The court may hear the application urgently where circumstances justify immediate relief.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Notice to Opposite Party",
      description:
          "The court may issue notice to the opposite party or pass an interim order where legally permissible.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Arguments",
      description:
          "Both parties present arguments regarding the grant or refusal of the injunction.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Court Decision",
      description:
          "The court decides the application after considering the applicable legal principles.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Compliance",
      description:
          "All parties must comply with the injunction order until it is modified, vacated, or the suit is finally decided.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Permanent Injunction
//-----------------------------------------------------------

ProcedureModel(
  id: "permanent_injunction",

  categoryId: "civil",

  title: "Permanent Injunction",

  overview:
      "A Permanent Injunction is a final decree issued by a competent civil court permanently restraining a person from committing a specific act that infringes or threatens the legal rights of another. It is granted after full trial and adjudication of the rights of the parties.",

  governmentDepartment:
      "Civil Court",

  eligibility:
      "Any person whose legal or civil rights are being violated or are under continuous threat may seek a permanent injunction before the competent civil court.",

  requiredDocuments: [
    "Original CNIC of Plaintiff",
    "Plaint",
    "Supporting Documents",
    "Property Documents (if applicable)",
    "Photographs or Other Evidence (if applicable)",
    "List of Witnesses",
    "Vakalatnama",
  ],

  applicableLaws: [
    "Specific Relief Act, 1877",
    "Code of Civil Procedure, 1908",
    "Qanun-e-Shahadat Order, 1984",
  ],

  importantNotes: [
    "A permanent injunction is granted only after final adjudication.",
    "The plaintiff must establish a legal right requiring protection.",
    "Maintain all documentary evidence throughout the proceedings.",
    "Comply with every court direction during the trial.",
  ],

  commonMistakes: [
    "Failure to prove legal rights.",
    "Insufficient documentary evidence.",
    "Non-appearance of witnesses.",
    "Filing before a court lacking jurisdiction.",
  ],

  estimatedFee:
      "Court fee according to the applicable rules.",

  estimatedTime:
      "Depends upon completion of the civil trial and the court's workload.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Prepare the Suit",
      description:
          "Prepare the plaint seeking a decree of permanent injunction.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Collect Evidence",
      description:
          "Gather ownership documents, agreements, photographs and all supporting evidence.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "File the Civil Suit",
      description:
          "Institute the suit before the competent civil court.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Proceedings Before Court",
      description:
          "The defendant files a written statement and the suit proceeds according to law.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Recording of Evidence",
      description:
          "Both parties produce documentary and oral evidence before the court.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Final Arguments",
      description:
          "The parties present final legal arguments before the court.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Judgment",
      description:
          "The court determines the rights of the parties and decides whether a permanent injunction should be granted.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Permanent Decree",
      description:
          "Where allowed, the court issues a permanent injunction restraining the prohibited act.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Recovery Suit
//-----------------------------------------------------------

ProcedureModel(
  id: "recovery_suit",

  categoryId: "civil",

  title: "Recovery Suit",

  overview:
      "A Recovery Suit is a civil action filed before a competent court to recover money, debts, contractual payments, damages, or other financial claims legally due from another person or entity. The plaintiff must establish the legal basis of the claim through documentary and oral evidence.",

  governmentDepartment:
      "Civil Court",

  eligibility:
      "Any person, company, or organization having a legally enforceable monetary claim may institute a recovery suit before the competent civil court.",

  requiredDocuments: [
    "Original CNIC of Plaintiff",
    "Plaint",
    "Agreements or Contracts",
    "Invoices or Bills (if applicable)",
    "Receipts or Payment Records",
    "Bank Statements (where applicable)",
    "Legal Notice (if served)",
    "Supporting Documents",
    "Vakalatnama",
  ],

  applicableLaws: [
    "Code of Civil Procedure, 1908",
    "Contract Act, 1872",
    "Qanun-e-Shahadat Order, 1984",
    "Relevant Special Laws",
  ],

  importantNotes: [
    "Maintain complete documentary evidence of the claim.",
    "Clearly calculate the amount being claimed.",
    "File the suit within the prescribed limitation period.",
    "Institute the suit before the court having proper jurisdiction.",
  ],

  commonMistakes: [
    "Incorrect calculation of the claimed amount.",
    "Failure to attach documentary proof.",
    "Filing after expiry of limitation.",
    "Filing before the wrong court.",
  ],

  estimatedFee:
      "Court fee according to the Court Fees Act and applicable provincial rules.",

  estimatedTime:
      "Depends upon the complexity of the dispute and the court's workload.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Collect Financial Records",
      description:
          "Gather contracts, invoices, receipts, bank records and all supporting documents.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Prepare the Plaint",
      description:
          "Draft the recovery suit specifying the amount claimed and the legal basis of the claim.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Determine Jurisdiction",
      description:
          "Identify the competent civil court having territorial and pecuniary jurisdiction.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Pay Court Fee",
      description:
          "Deposit the prescribed court fee before filing the suit.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "File the Suit",
      description:
          "Submit the plaint with all supporting documents before the competent court.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Service of Summons",
      description:
          "The court issues summons to the defendant to appear and file a written statement.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Trial Proceedings",
      description:
          "Both parties produce evidence, examine witnesses and present legal arguments.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Judgment",
      description:
          "The court decides whether the plaintiff is entitled to recover the claimed amount.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Declaration Suit
//-----------------------------------------------------------

ProcedureModel(
  id: "declaration_suit",

  categoryId: "civil",

  title: "Declaration Suit",

  overview:
      "A Declaration Suit is a civil action through which a person seeks a judicial declaration regarding a legal status, right, title, ownership, or legal character. The court determines the existence or non-existence of such legal right in accordance with the applicable law.",

  governmentDepartment:
      "Civil Court",

  eligibility:
      "Any person entitled to a legal character or any right relating to property or any civil right may institute a declaration suit before the competent civil court.",

  requiredDocuments: [
    "Original CNIC of Plaintiff",
    "Plaint",
    "Property Documents (if applicable)",
    "Revenue Record (where applicable)",
    "Agreements or Contracts (if applicable)",
    "Supporting Documentary Evidence",
    "List of Witnesses",
    "Vakalatnama",
  ],

  applicableLaws: [
    "Specific Relief Act, 1877",
    "Code of Civil Procedure, 1908",
    "Qanun-e-Shahadat Order, 1984",
  ],

  importantNotes: [
    "Clearly identify the legal right requiring declaration.",
    "Attach all ownership and supporting documents.",
    "File before the competent court having jurisdiction.",
    "Ensure all necessary parties are impleaded.",
  ],

  commonMistakes: [
    "Failure to implead necessary parties.",
    "Insufficient documentary evidence.",
    "Incorrect court jurisdiction.",
    "Incomplete pleadings.",
  ],

  estimatedFee:
      "Court fee according to the applicable rules.",

  estimatedTime:
      "Depends upon the complexity of the dispute and the court's workload.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Identify Legal Right",
      description:
          "Determine the legal status or right for which judicial declaration is required.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Collect Supporting Documents",
      description:
          "Gather title documents, revenue records, agreements and other supporting evidence.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Draft the Plaint",
      description:
          "Prepare the plaint clearly stating the declaration sought and its legal basis.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Determine Jurisdiction",
      description:
          "Identify the competent civil court having territorial and pecuniary jurisdiction.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Pay Court Fee",
      description:
          "Deposit the prescribed court fee before filing the suit.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "File the Suit",
      description:
          "Submit the plaint and supporting documents before the competent civil court.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Court Proceedings",
      description:
          "The defendants are summoned and the suit proceeds according to the Code of Civil Procedure.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Declaration by Court",
      description:
          "The court determines the legal rights of the parties and passes an appropriate declaratory decree.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Written Statement
//-----------------------------------------------------------

ProcedureModel(
  id: "written_statement",

  categoryId: "civil",

  title: "Written Statement",

  overview:
      "A Written Statement is the formal reply filed by the defendant in response to the plaint submitted by the plaintiff. It contains admissions, denials, legal objections, and the defendant's version of the facts. The written statement enables the court to identify the disputed questions requiring adjudication.",

  governmentDepartment:
      "Civil Court",

  eligibility:
      "Any defendant who has been served with summons in a civil suit may file a written statement before the competent civil court within the prescribed time or such extended time as permitted by law.",

  requiredDocuments: [
    "Copy of Plaint",
    "Copy of Summons",
    "Original CNIC of Defendant",
    "Supporting Documents",
    "Property Documents (if applicable)",
    "Relevant Agreements (if applicable)",
    "List of Witnesses",
    "Vakalatnama",
  ],

  applicableLaws: [
    "Code of Civil Procedure, 1908",
    "Qanun-e-Shahadat Order, 1984",
    "Relevant Special Laws",
  ],

  importantNotes: [
    "Respond to every material allegation made in the plaint.",
    "Raise all legal objections at the earliest opportunity.",
    "Attach all supporting documents.",
    "File the written statement within the prescribed limitation period.",
  ],

  commonMistakes: [
    "General denial without specific response.",
    "Failure to raise legal objections.",
    "Late filing without sufficient cause.",
    "Not attaching relevant documents.",
  ],

  estimatedFee:
      "Generally, no separate court fee is required for filing the written statement.",

  estimatedTime:
      "Usually filed within the statutory period after service of summons, subject to the court's directions.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Receive Summons",
      description:
          "The defendant receives summons along with a copy of the plaint.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Review the Plaint",
      description:
          "Examine each allegation and identify the factual and legal issues.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Collect Supporting Documents",
      description:
          "Gather documents and evidence supporting the defence.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Prepare Written Statement",
      description:
          "Draft the written statement with admissions, denials and legal objections.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Attach Evidence",
      description:
          "Attach all relevant documents relied upon by the defendant.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "File Before Court",
      description:
          "Submit the written statement before the competent civil court.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Serve Other Party",
      description:
          "Provide a copy to the plaintiff or comply with the court's procedure for service.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Proceed to Framing of Issues",
      description:
          "After completion of pleadings, the court proceeds to frame the issues for trial.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Framing of Issues
//-----------------------------------------------------------

ProcedureModel(
  id: "framing_of_issues",

  categoryId: "civil",

  title: "Framing of Issues",

  overview:
      "Framing of Issues is the stage of a civil suit where the court identifies the disputed questions of fact and law arising from the pleadings of the parties. These issues determine the scope of the trial and indicate which party bears the burden of proving each disputed matter.",

  governmentDepartment:
      "Civil Court",

  eligibility:
      "The court frames issues after the plaint and written statement have been filed and the pleadings are complete.",

  requiredDocuments: [
    "Plaint",
    "Written Statement",
    "Replication (if any)",
    "Supporting Documents",
    "Relevant Court Record",
  ],

  applicableLaws: [
    "Code of Civil Procedure, 1908",
    "Qanun-e-Shahadat Order, 1984",
    "Relevant Judicial Precedents",
  ],

  importantNotes: [
    "Issues define the scope of the entire trial.",
    "Every material dispute should be covered by an issue.",
    "Incorrectly framed issues may affect the outcome of the case.",
    "The burden of proof is determined for each issue.",
  ],

  commonMistakes: [
    "Failure to identify all disputed questions.",
    "Ignoring material facts in the pleadings.",
    "Confusing questions of law with questions of fact.",
    "Not raising objections before issues are finalized.",
  ],

  estimatedFee:
      "No separate court fee is generally applicable.",

  estimatedTime:
      "Usually completed after pleadings are finalized, subject to the court's schedule.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Completion of Pleadings",
      description:
          "The plaint and written statement are examined after completion of pleadings.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Examination of Claims",
      description:
          "The court identifies admitted and disputed facts.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Identification of Legal Questions",
      description:
          "Questions of law requiring determination are identified.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Identification of Factual Questions",
      description:
          "Questions of fact requiring evidence are identified.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Burden of Proof",
      description:
          "The court determines which party bears the burden of proving each issue.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Formal Framing of Issues",
      description:
          "The court formally frames the issues for trial.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Opportunity for Objections",
      description:
          "The parties may raise objections or request modification where legally permissible.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Proceed to Evidence",
      description:
          "The case proceeds to the recording of evidence on the framed issues.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Recording of Evidence
//-----------------------------------------------------------

ProcedureModel(
  id: "recording_of_evidence",

  categoryId: "civil",

  title: "Recording of Evidence",

  overview:
      "Recording of Evidence is the stage of a civil trial during which the parties produce oral and documentary evidence to establish the facts in support of their respective claims and defenses. Witnesses are examined, cross-examined, and re-examined where necessary, enabling the court to determine the disputed issues on the basis of admissible evidence.",

  governmentDepartment:
      "Civil Court",

  eligibility:
      "The recording of evidence begins after the court frames the issues for determination.",

  requiredDocuments: [
    "Plaint",
    "Written Statement",
    "Framed Issues",
    "Original Documents",
    "Affidavits (where applicable)",
    "List of Witnesses",
    "Exhibits",
  ],

  applicableLaws: [
    "Code of Civil Procedure, 1908",
    "Qanun-e-Shahadat Order, 1984",
    "Relevant Judicial Precedents",
  ],

  importantNotes: [
    "Produce original documents whenever required.",
    "Ensure witnesses are present on the scheduled dates.",
    "Evidence should relate directly to the framed issues.",
    "Maintain consistency between pleadings and evidence.",
  ],

  commonMistakes: [
    "Failure to produce witnesses.",
    "Submitting inadmissible evidence.",
    "Contradictory witness statements.",
    "Failure to exhibit important documents.",
  ],

  estimatedFee:
      "No separate court fee is generally applicable.",

  estimatedTime:
      "Depends upon the number of witnesses, documentary evidence, and the court's schedule.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Plaintiff's Evidence",
      description:
          "The plaintiff begins by producing documentary evidence and examining witnesses.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Cross-Examination",
      description:
          "The defendant cross-examines the plaintiff's witnesses.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Re-Examination",
      description:
          "Witnesses may be re-examined where necessary to clarify matters arising during cross-examination.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Defendant's Evidence",
      description:
          "The defendant produces documentary evidence and examines defence witnesses.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Cross-Examination of Defence Witnesses",
      description:
          "The plaintiff cross-examines the defendant's witnesses.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Marking of Exhibits",
      description:
          "Documents admitted into evidence are marked as exhibits in accordance with court procedure.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Closure of Evidence",
      description:
          "After both parties complete their evidence, the court formally closes the evidence stage.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Proceed to Final Arguments",
      description:
          "The case is fixed for final arguments before judgment.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Final Arguments
//-----------------------------------------------------------

ProcedureModel(
  id: "final_arguments",

  categoryId: "civil",

  title: "Final Arguments",

  overview:
      "Final Arguments are the concluding oral or written submissions presented by the parties after the completion of evidence. During this stage, each party explains how the evidence, applicable law, and judicial precedents support its case. The court considers these submissions before pronouncing the final judgment.",

  governmentDepartment:
      "Civil Court",

  eligibility:
      "Final arguments are heard after both parties have completed the recording of evidence and the court has formally closed the evidence stage.",

  requiredDocuments: [
    "Plaint",
    "Written Statement",
    "Evidence Record",
    "Exhibits",
    "Relevant Case Law (if relied upon)",
    "Written Arguments (where permitted)",
  ],

  applicableLaws: [
    "Code of Civil Procedure, 1908",
    "Qanun-e-Shahadat Order, 1984",
    "Relevant Judicial Precedents",
  ],

  importantNotes: [
    "Arguments should focus on the framed issues.",
    "Refer to documentary and oral evidence accurately.",
    "Cite relevant statutory provisions and precedents.",
    "Avoid introducing new facts not supported by the record.",
  ],

  commonMistakes: [
    "Raising issues not pleaded in the suit.",
    "Ignoring important documentary evidence.",
    "Misquoting legal provisions.",
    "Lengthy arguments without addressing the framed issues.",
  ],

  estimatedFee:
      "No separate court fee is generally applicable.",

  estimatedTime:
      "Depends upon the complexity of the case and the number of issues involved.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Closure of Evidence",
      description:
          "The court formally closes the evidence of both parties.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Preparation of Arguments",
      description:
          "The parties organize legal submissions based on the pleadings, evidence and applicable law.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Reference to Evidence",
      description:
          "Relevant oral and documentary evidence is highlighted before the court.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Legal Submissions",
      description:
          "Applicable statutes and judicial precedents are presented to support the case.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Reply by Opposing Party",
      description:
          "The opposite party responds to the legal and factual submissions.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Clarifications by Court",
      description:
          "The court may seek clarification on disputed legal or factual issues.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Arguments Concluded",
      description:
          "After hearing both sides, the court concludes the arguments.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Case Reserved for Judgment",
      description:
          "The matter is reserved for pronouncement of judgment or fixed for judgment.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Civil Judgment & Decree
//-----------------------------------------------------------

ProcedureModel(
  id: "civil_judgment_decree",

  categoryId: "civil",

  title: "Civil Judgment & Decree",

  overview:
      "A Civil Judgment is the formal decision of the court determining the rights and liabilities of the parties after considering the pleadings, evidence, and legal arguments. Based on the judgment, the court prepares a Decree which formally records the adjudication and becomes enforceable in accordance with the law.",

  governmentDepartment:
      "Civil Court",

  eligibility:
      "The court pronounces judgment after completion of pleadings, recording of evidence, and hearing of final arguments.",

  requiredDocuments: [
    "Complete Court Record",
    "Plaint",
    "Written Statement",
    "Evidence Record",
    "Exhibits",
    "Written Arguments (if any)",
  ],

  applicableLaws: [
    "Code of Civil Procedure, 1908",
    "Qanun-e-Shahadat Order, 1984",
    "Relevant Judicial Precedents",
  ],

  importantNotes: [
    "The judgment must address every framed issue.",
    "The decree must accurately reflect the judgment.",
    "Obtain a certified copy for future proceedings.",
    "Appeal or execution proceedings may follow depending upon the outcome.",
  ],

  commonMistakes: [
    "Delay in obtaining certified copies.",
    "Misunderstanding the contents of the decree.",
    "Failure to comply with court directions after judgment.",
    "Not filing appeal or execution within the prescribed limitation period.",
  ],

  estimatedFee:
      "Certified copy fee according to applicable court rules.",

  estimatedTime:
      "Judgment is pronounced according to the court's schedule after conclusion of arguments.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Conclusion of Final Arguments",
      description:
          "The court hears final arguments from both parties.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Judicial Examination",
      description:
          "The court examines the pleadings, evidence and applicable law.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Decision on Issues",
      description:
          "Each framed issue is decided with reasons.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Pronouncement of Judgment",
      description:
          "The court pronounces its judgment in open court.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Preparation of Decree",
      description:
          "The decree is drawn in accordance with the judgment.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Certified Copies",
      description:
          "The parties may obtain certified copies of the judgment and decree.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Compliance or Challenge",
      description:
          "The parties may comply with the decree or seek an available legal remedy.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Execution or Appeal",
      description:
          "The successful party may initiate execution proceedings, while the aggrieved party may file an appeal where permitted by law.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Execution of Decree
//-----------------------------------------------------------

ProcedureModel(
  id: "execution_of_decree",

  categoryId: "civil",

  title: "Execution of Decree",

  overview:
      "Execution of Decree is the legal process through which a successful party (Decree Holder) enforces a civil court decree against the Judgment Debtor. If the judgment debtor fails to comply voluntarily, the court may adopt lawful measures to enforce the decree, including attachment and sale of property, delivery of possession, arrest where permitted by law, or any other mode of execution provided under the Code of Civil Procedure.",

  governmentDepartment:
      "Civil Court",

  eligibility:
      "Any decree holder in whose favour a valid and enforceable civil decree has been passed may file an execution application before the competent court.",

  requiredDocuments: [
    "Certified Copy of Judgment",
    "Certified Copy of Decree",
    "Execution Application",
    "CNIC of Decree Holder",
    "Details of Judgment Debtor",
    "Details of Property or Assets (if applicable)",
    "Supporting Documents",
    "Vakalatnama",
  ],

  applicableLaws: [
    "Code of Civil Procedure, 1908",
    "Relevant High Court Rules",
    "Applicable Judicial Precedents",
  ],

  importantNotes: [
    "Ensure the decree has become executable.",
    "Provide complete details of the judgment debtor.",
    "Identify attachable assets where possible.",
    "Follow limitation requirements for execution proceedings.",
  ],

  commonMistakes: [
    "Filing execution before the decree becomes executable.",
    "Providing incomplete details of the judgment debtor.",
    "Failure to identify executable property.",
    "Delay in initiating execution proceedings.",
  ],

  estimatedFee:
      "Court fee according to applicable execution rules, where required.",

  estimatedTime:
      "Depends upon the nature of the decree, execution method and compliance by the judgment debtor.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Obtain Certified Decree",
      description:
          "Obtain certified copies of the judgment and decree from the court.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Prepare Execution Application",
      description:
          "Prepare the execution petition specifying the relief sought and the proposed mode of execution.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "File Before Competent Court",
      description:
          "Submit the execution application before the court having jurisdiction.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Notice to Judgment Debtor",
      description:
          "The court issues notice where required under the law.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Execution Proceedings",
      description:
          "The court considers objections and proceeds with lawful execution measures.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Attachment or Enforcement",
      description:
          "Property may be attached, possession delivered, or other lawful execution methods adopted where applicable.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Compliance",
      description:
          "The judgment debtor complies with the decree or the court enforces compliance.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Execution Completed",
      description:
          "After satisfaction of the decree, the execution proceedings are concluded.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Civil Appeal
//-----------------------------------------------------------

ProcedureModel(
  id: "civil_appeal",

  categoryId: "civil",

  title: "Civil Appeal",

  overview:
      "A Civil Appeal is a statutory remedy through which an aggrieved party requests a higher court to review the judgment or decree passed by a subordinate court. The appellate court examines whether any error of law, fact, or procedure affected the decision and may affirm, modify, reverse, or remand the case in accordance with the law.",

  governmentDepartment:
      "Appellate Civil Court",

  eligibility:
      "Any person aggrieved by a decree or appealable order passed by a competent civil court may file a civil appeal within the prescribed limitation period.",

  requiredDocuments: [
    "Certified Copy of Judgment",
    "Certified Copy of Decree or Order",
    "Memorandum of Appeal",
    "CNIC of Appellant",
    "Supporting Documents",
    "Grounds of Appeal",
    "Court Fee",
    "Vakalatnama",
  ],

  applicableLaws: [
    "Code of Civil Procedure, 1908",
    "Limitation Act, 1908",
    "Relevant High Court Rules",
    "Applicable Judicial Precedents",
  ],

  importantNotes: [
    "File the appeal within the prescribed limitation period.",
    "Clearly state every legal and factual ground of appeal.",
    "Attach certified copies of the impugned judgment and decree.",
    "Ensure the appellate court has proper jurisdiction.",
  ],

  commonMistakes: [
    "Late filing without sufficient cause.",
    "Incomplete grounds of appeal.",
    "Failure to attach certified copies.",
    "Filing before the wrong appellate court.",
  ],

  estimatedFee:
      "Court fee according to applicable appellate court rules.",

  estimatedTime:
      "Depends upon the nature of the appeal and the workload of the appellate court.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Obtain Certified Copies",
      description:
          "Obtain certified copies of the judgment and decree or order.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Review the Judgment",
      description:
          "Identify legal or factual errors forming the basis of the appeal.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Draft Memorandum of Appeal",
      description:
          "Prepare the memorandum stating the grounds of appeal and the relief sought.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Pay Court Fee",
      description:
          "Deposit the prescribed court fee before filing the appeal.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "File the Appeal",
      description:
          "Submit the appeal before the competent appellate court.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Notice to Respondent",
      description:
          "The appellate court issues notice to the respondent where required.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Appellate Hearing",
      description:
          "Both parties present legal arguments before the appellate court.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Appellate Decision",
      description:
          "The appellate court may affirm, modify, reverse, or remand the case in accordance with law.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Civil Revision
//-----------------------------------------------------------

ProcedureModel(
  id: "civil_revision",

  categoryId: "civil",

  title: "Civil Revision",

  overview:
      "A Civil Revision is a supervisory remedy through which the High Court examines the legality, jurisdiction, or procedural correctness of an order passed by a subordinate civil court where no appeal lies or where revision is otherwise maintainable under the law. The High Court generally does not re-evaluate evidence but ensures that the subordinate court has exercised its jurisdiction lawfully.",

  governmentDepartment:
      "High Court",

  eligibility:
      "Any person aggrieved by an order of a subordinate civil court, where revision is maintainable under law, may file a civil revision before the competent High Court.",

  requiredDocuments: [
    "Certified Copy of Impugned Order",
    "Revision Petition",
    "CNIC of Petitioner",
    "Supporting Documents",
    "Grounds of Revision",
    "Relevant Court Record",
    "Court Fee",
    "Vakalatnama",
  ],

  applicableLaws: [
    "Code of Civil Procedure, 1908",
    "High Court Rules",
    "Limitation Act, 1908",
    "Applicable Judicial Precedents",
  ],

  importantNotes: [
    "Revision is not a substitute for an appeal.",
    "Clearly identify jurisdictional or legal errors.",
    "File within the prescribed limitation period.",
    "Attach certified copies of the impugned order.",
  ],

  commonMistakes: [
    "Treating revision as a regular appeal.",
    "Failure to identify jurisdictional errors.",
    "Late filing without sufficient cause.",
    "Incomplete supporting documents.",
  ],

  estimatedFee:
      "Court fee according to the applicable High Court rules.",

  estimatedTime:
      "Depends upon the complexity of the case and the workload of the High Court.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Obtain Certified Copy",
      description:
          "Obtain a certified copy of the impugned order.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Examine Legal Errors",
      description:
          "Identify jurisdictional, procedural or legal defects in the order.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Draft Revision Petition",
      description:
          "Prepare the revision petition stating all legal grounds.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Attach Supporting Documents",
      description:
          "Attach certified copies and all relevant supporting documents.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Pay Court Fee",
      description:
          "Deposit the prescribed court fee.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "File Before High Court",
      description:
          "Submit the revision petition before the competent High Court.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Hearing",
      description:
          "The High Court hears the parties on the legal questions raised.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Revision Order",
      description:
          "The High Court may dismiss, modify, or set aside the impugned order in accordance with law.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Review Petition
//-----------------------------------------------------------

ProcedureModel(
  id: "review_petition",

  categoryId: "civil",

  title: "Review Petition",

  overview:
      "A Review Petition is an application filed before the same court that passed a judgment or order, requesting the court to reconsider its decision on limited grounds permitted by law, such as an apparent error on the face of the record, discovery of new and important evidence, or other sufficient reasons recognized by law.",

  governmentDepartment:
      "Civil Court / High Court (as applicable)",

  eligibility:
      "Any person aggrieved by a judgment or order may file a review petition before the same court where review is maintainable under the applicable law.",

  requiredDocuments: [
    "Certified Copy of Judgment or Order",
    "Review Petition",
    "CNIC of Applicant",
    "Supporting Documents",
    "New Evidence (if applicable)",
    "Grounds for Review",
    "Court Fee",
    "Vakalatnama",
  ],

  applicableLaws: [
    "Code of Civil Procedure, 1908",
    "Limitation Act, 1908",
    "Relevant High Court Rules",
    "Applicable Judicial Precedents",
  ],

  importantNotes: [
    "A review is not a substitute for an appeal.",
    "Clearly specify the statutory grounds for review.",
    "Attach all supporting documents.",
    "File within the prescribed limitation period.",
  ],

  commonMistakes: [
    "Using review as a second appeal.",
    "Failure to establish valid grounds for review.",
    "Late filing without sufficient cause.",
    "Incomplete supporting documents.",
  ],

  estimatedFee:
      "Court fee according to the applicable court rules.",

  estimatedTime:
      "Depends upon the court's schedule and the complexity of the review application.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Study the Judgment",
      description:
          "Carefully examine the judgment to identify any reviewable error or other legally recognized ground.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Collect Supporting Material",
      description:
          "Gather certified copies, newly discovered evidence (if any), and all supporting documents.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Prepare Review Petition",
      description:
          "Draft the review petition clearly stating the legal grounds for review.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Pay Court Fee",
      description:
          "Deposit the prescribed court fee where applicable.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "File Before the Same Court",
      description:
          "Submit the review petition before the court that passed the original judgment or order.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Notice to Opposite Party",
      description:
          "The court may issue notice to the opposite party where required.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Hearing",
      description:
          "The court hears the parties on the maintainability and merits of the review petition.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Review Decision",
      description:
          "The court may allow or dismiss the review petition in accordance with law.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Restoration Application
//-----------------------------------------------------------

ProcedureModel(
  id: "restoration_application",

  categoryId: "civil",

  title: "Restoration Application",

  overview:
      "A Restoration Application is filed to request the court to restore a civil suit, appeal, application, or other proceeding that has been dismissed for non-prosecution, default of appearance, or other reasons permitted by law. The applicant must satisfy the court that there was sufficient cause for the default and that the matter deserves restoration.",

  governmentDepartment:
      "Civil Court / Appellate Court",

  eligibility:
      "Any party whose civil suit, appeal, or application has been dismissed for default or non-prosecution may file a restoration application where permitted by the applicable law.",

  requiredDocuments: [
    "Certified Copy of Dismissal Order",
    "Restoration Application",
    "Affidavit",
    "CNIC of Applicant",
    "Supporting Documents",
    "Evidence Explaining the Default",
    "Court Fee (where applicable)",
    "Vakalatnama",
  ],

  applicableLaws: [
    "Code of Civil Procedure, 1908",
    "Limitation Act, 1908",
    "Relevant High Court Rules",
    "Applicable Judicial Precedents",
  ],

  importantNotes: [
    "File the application within the prescribed limitation period.",
    "Clearly explain the sufficient cause for absence or default.",
    "Attach all supporting documents.",
    "Support factual assertions through an affidavit where required.",
  ],

  commonMistakes: [
    "Failure to explain the delay properly.",
    "Late filing without seeking condonation where applicable.",
    "Incomplete supporting documents.",
    "Not attaching the dismissal order.",
  ],

  estimatedFee:
      "Court fee according to the applicable court rules.",

  estimatedTime:
      "Depends upon the court's schedule and the circumstances of the case.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Obtain Dismissal Order",
      description:
          "Obtain a certified copy of the order dismissing the case.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Prepare Restoration Application",
      description:
          "Draft the restoration application clearly explaining the sufficient cause for default.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Collect Supporting Evidence",
      description:
          "Gather documents supporting the reasons for absence or default.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Prepare Affidavit",
      description:
          "Prepare an affidavit verifying the facts stated in the application where required.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "File Before the Competent Court",
      description:
          "Submit the restoration application before the court that dismissed the matter.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Notice to Opposite Party",
      description:
          "The court may issue notice to the opposite party before deciding the application.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Hearing",
      description:
          "The court hears both parties regarding restoration of the proceedings.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Restoration Order",
      description:
          "If satisfied, the court restores the case and fixes it for further proceedings in accordance with law.",
    ),
  ],
),



];