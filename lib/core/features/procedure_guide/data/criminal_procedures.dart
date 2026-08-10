import '../models/procedure_model.dart';
import '../models/procedure_step.dart';

final List<ProcedureModel> criminalProcedures = [

  //-----------------------------------------------------------
// Procedure: FIR Registration
//-----------------------------------------------------------

ProcedureModel(
  id: "fir_registration",

  categoryId: "criminal",

  title: "FIR Registration",

  overview:
      "A First Information Report (FIR) is the earliest information recorded by the police regarding the commission of a cognizable offence. It initiates the criminal justice process and enables the police to investigate the alleged offence in accordance with the law.",

  governmentDepartment:
      "Police Department",

  eligibility:
      "Any person having knowledge of the commission of a cognizable offence may report the matter to the police for registration of an FIR in accordance with the law.",

  requiredDocuments: [
    "Original CNIC (if available)",
    "Written Complaint (optional but recommended)",
    "Supporting Documents or Evidence (if any)",
    "Names of Witnesses (if available)",
    "Photographs or Videos (if available)",
  ],

  applicableLaws: [
    "Code of Criminal Procedure, 1898",
    "Pakistan Penal Code, 1860 (where applicable)",
    "Police Order, 2002 (where applicable)",
  ],

  importantNotes: [
    "An FIR should be reported as soon as reasonably possible.",
    "Provide complete and accurate facts.",
    "Do not exaggerate or conceal material facts.",
    "Obtain a copy of the registered FIR.",
  ],

  commonMistakes: [
    "Providing incomplete facts.",
    "Delay without explanation.",
    "Giving incorrect personal information.",
    "Not preserving available evidence.",
  ],

  estimatedFee:
      "No government fee is generally charged for registration of an FIR.",

  estimatedTime:
      "Registration is generally completed on the same day, subject to the facts and applicable law.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Visit Police Station",
      description:
          "Approach the police station having territorial jurisdiction over the place of occurrence.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Provide Information",
      description:
          "Provide complete facts relating to the alleged cognizable offence.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Recording of FIR",
      description:
          "The police record the information in the prescribed FIR register.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Read the FIR",
      description:
          "Carefully review the contents before signing or confirming the report.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Registration",
      description:
          "The FIR is assigned an official number and registered.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Receive Copy",
      description:
          "Obtain a free copy of the registered FIR where applicable.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Police Investigation",
      description:
          "The Investigating Officer begins the investigation according to law.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Follow-Up",
      description:
          "Cooperate with the Investigating Officer and provide additional evidence if required.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Police Complaint
//-----------------------------------------------------------

ProcedureModel(
  id: "police_complaint",

  categoryId: "criminal",

  title: "Police Complaint",

  overview:
      "A Police Complaint is a written or oral report submitted to the police regarding a grievance, non-cognizable offence, suspicious activity, missing property, public nuisance, or any matter requiring police attention. Depending upon the nature of the complaint, the police may conduct an inquiry, take preventive measures, or proceed in accordance with the applicable law.",

  governmentDepartment:
      "Police Department",

  eligibility:
      "Any person affected by or having knowledge of an incident requiring police intervention may submit a complaint.",

  requiredDocuments: [
    "Original CNIC (if available)",
    "Written Complaint",
    "Supporting Documents (if any)",
    "Photographs or Videos (if available)",
    "Names of Witnesses (if available)",
  ],

  applicableLaws: [
    "Code of Criminal Procedure, 1898",
    "Police Order, 2002 (where applicable)",
    "Relevant Special Laws",
  ],

  importantNotes: [
    "State the facts accurately.",
    "Preserve all available evidence.",
    "Obtain a receiving copy of the complaint where possible.",
    "Cooperate during any inquiry.",
  ],

  commonMistakes: [
    "Submitting incomplete facts.",
    "Providing incorrect contact details.",
    "Failing to attach supporting evidence.",
    "Making vague allegations.",
  ],

  estimatedFee:
      "No government fee is generally required.",

  estimatedTime:
      "Acknowledgement is generally immediate. Further action depends upon the nature of the complaint.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Prepare Complaint",
      description:
          "Prepare a clear written complaint describing the incident.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Collect Evidence",
      description:
          "Attach supporting documents, photographs, videos or witness details if available.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Visit Police Station",
      description:
          "Approach the police station having jurisdiction.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Submit Complaint",
      description:
          "Submit the complaint to the duty officer or designated official.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Receive Acknowledgement",
      description:
          "Obtain a receiving copy or complaint reference number where available.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Police Inquiry",
      description:
          "The police examine the complaint and determine the appropriate legal course.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Necessary Action",
      description:
          "The police take action according to the applicable law, which may include inquiry, preventive measures or registration of an FIR where legally justified.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Follow-Up",
      description:
          "Stay in contact with the concerned police officer regarding the status of the complaint.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Arrest Procedure
//-----------------------------------------------------------

ProcedureModel(
  id: "arrest_procedure",

  categoryId: "criminal",

  title: "Arrest Procedure",

  overview:
      "An arrest is the lawful apprehension of a person by a police officer or other authorized authority in accordance with the law. After arrest, the accused is processed, informed of the allegations, and produced before the competent court within the time prescribed by law.",

  governmentDepartment:
      "Police Department",

  eligibility:
      "An arrest may be made by the police or other authorized authority where permitted under the applicable law.",

  requiredDocuments: [
    "Original CNIC (if available)",
    "Arrest Memo",
    "FIR Copy (where applicable)",
    "Case Diary (where applicable)",
    "Supporting Investigation Record",
  ],

  applicableLaws: [
    "Code of Criminal Procedure, 1898",
    "Pakistan Penal Code, 1860",
    "Relevant Special Criminal Laws",
  ],

  importantNotes: [
    "Only lawful arrests should be made.",
    "Maintain proper arrest documentation.",
    "Produce the arrested person before the competent court within the time prescribed by law.",
    "Maintain proper chain of custody for evidence.",
  ],

  commonMistakes: [
    "Incomplete arrest documentation.",
    "Failure to maintain investigation records.",
    "Incorrect identity details.",
    "Failure to follow procedural requirements.",
  ],

  estimatedFee:
      "No government fee is applicable.",

  estimatedTime:
      "The arrest process is completed immediately, followed by investigation and court proceedings according to law.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Grounds for Arrest",
      description:
          "The police determine whether legal grounds exist for arrest.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Arrest of Accused",
      description:
          "The accused is lawfully taken into custody.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Preparation of Arrest Memo",
      description:
          "The arrest memo and other required documents are prepared.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Personal Search",
      description:
          "A lawful personal search is conducted and relevant articles are documented.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Police Station Record",
      description:
          "The arrest is entered into the official police record.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Investigation",
      description:
          "The Investigating Officer continues the investigation according to law.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Production Before Court",
      description:
          "The arrested person is produced before the competent court within the legally prescribed period.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Further Legal Proceedings",
      description:
          "The case proceeds according to the orders of the competent court.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Pre-Arrest Bail
//-----------------------------------------------------------

ProcedureModel(
  id: "pre_arrest_bail",

  categoryId: "criminal",

  title: "Pre-Arrest Bail",

  overview:
      "Pre-Arrest Bail (also known as Protective or Anticipatory Bail) is an extraordinary legal remedy granted by the competent court to protect a person from arrest where it is alleged that the intended arrest is unlawful, mala fide, or intended to harass. The relief is discretionary and is granted only in appropriate circumstances in accordance with the applicable law.",

  governmentDepartment:
      "Sessions Court / High Court",

  eligibility:
      "A person apprehending arrest in a non-bailable offence may apply for pre-arrest bail before the competent court where permitted by law.",

  requiredDocuments: [
    "Original CNIC of Applicant",
    "Copy of FIR (if registered)",
    "Copy of Complaint (if applicable)",
    "Supporting Documents",
    "Affidavit",
    "Vakalatnama",
  ],

  applicableLaws: [
    "Code of Criminal Procedure, 1898",
    "Relevant Judicial Precedents",
  ],

  importantNotes: [
    "Pre-arrest bail is an extraordinary discretionary relief.",
    "Appear before the court on every hearing.",
    "Provide complete and truthful facts.",
    "Comply with all conditions imposed by the court.",
  ],

  commonMistakes: [
    "Concealing material facts.",
    "Submitting incomplete documents.",
    "Failure to appear before the court.",
    "Violation of bail conditions.",
  ],

  estimatedFee:
      "Court fee according to the applicable rules.",

  estimatedTime:
      "Urgent applications may be heard on the same day depending upon the circumstances.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Consult Legal Counsel",
      description:
          "Prepare the bail application with complete facts and supporting documents.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "File Bail Petition",
      description:
          "File the pre-arrest bail petition before the competent court.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Fixation of Hearing",
      description:
          "The court fixes the matter for hearing.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Notice to Prosecutor",
      description:
          "Notice may be issued to the prosecution where required.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Arguments",
      description:
          "Both parties present legal arguments before the court.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Interim Relief",
      description:
          "The court may grant interim protective relief where appropriate.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Final Decision",
      description:
          "The court confirms or dismisses the pre-arrest bail application.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Compliance",
      description:
          "The applicant complies with all terms and conditions imposed by the court.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Post-Arrest Bail
//-----------------------------------------------------------

ProcedureModel(
  id: "post_arrest_bail",

  categoryId: "criminal",

  title: "Post-Arrest Bail",

  overview:
      "Post-Arrest Bail is the legal process through which a person who has already been arrested seeks release from custody by filing a bail application before the competent court. The court considers the nature of the offence, available evidence, statutory provisions, and other relevant circumstances before deciding the application.",

  governmentDepartment:
      "Judicial Magistrate / Sessions Court / High Court",

  eligibility:
      "Any person arrested in connection with a criminal case may apply for post-arrest bail where permitted under the applicable law.",

  requiredDocuments: [
    "Original CNIC of Applicant",
    "Copy of FIR",
    "Arrest Memo",
    "Case Documents (if available)",
    "Affidavit",
    "Vakalatnama",
  ],

  applicableLaws: [
    "Code of Criminal Procedure, 1898",
    "Relevant Judicial Precedents",
    "Special Criminal Laws (where applicable)",
  ],

  importantNotes: [
    "Attend every hearing after release on bail.",
    "Comply with all bail conditions.",
    "Do not influence witnesses or tamper with evidence.",
    "Inform the court of any change in address or contact information.",
  ],

  commonMistakes: [
    "Violation of bail conditions.",
    "Failure to appear before the court.",
    "Submitting incomplete documents.",
    "Concealing relevant facts.",
  ],

  estimatedFee:
      "Court fee according to the applicable rules.",

  estimatedTime:
      "The application may be heard urgently depending upon the nature of the offence and the court's schedule.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Consult Legal Counsel",
      description:
          "Prepare the post-arrest bail application with all necessary documents.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "File Bail Petition",
      description:
          "Submit the bail application before the competent court.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Fixation of Hearing",
      description:
          "The court fixes the matter for hearing.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Notice to Prosecution",
      description:
          "The prosecution is heard where required by law.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Arguments",
      description:
          "Both parties present their legal arguments before the court.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Court Decision",
      description:
          "The court allows or dismisses the bail application according to law.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Execution of Bail Bonds",
      description:
          "Where bail is granted, the required surety and bail bonds are furnished.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Release from Custody",
      description:
          "Upon completion of all legal formalities, the accused is released subject to the conditions imposed by the court.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Criminal Trial
//-----------------------------------------------------------

ProcedureModel(
  id: "criminal_trial",

  categoryId: "criminal",

  title: "Criminal Trial",

  overview:
      "A Criminal Trial is the judicial process through which a criminal court determines whether an accused person is guilty or innocent after examining the evidence, hearing witnesses, and considering the applicable law. The trial is conducted in accordance with the Code of Criminal Procedure and other applicable laws.",

  governmentDepartment:
      "Judicial Magistrate / Sessions Court / Special Court",

  eligibility:
      "A criminal trial commences after submission of the police report (Challan) or upon taking cognizance by the competent criminal court in accordance with the law.",

  requiredDocuments: [
    "Copy of FIR",
    "Police Report (Challan)",
    "Witness Statements",
    "Documentary Evidence",
    "Forensic Reports (if applicable)",
    "Case Record",
  ],

  applicableLaws: [
    "Code of Criminal Procedure, 1898",
    "Pakistan Penal Code, 1860",
    "Qanun-e-Shahadat Order, 1984",
    "Relevant Special Laws",
  ],

  importantNotes: [
    "Attend every court hearing.",
    "Produce witnesses on the scheduled dates.",
    "Preserve documentary and electronic evidence.",
    "Follow all court directions.",
  ],

  commonMistakes: [
    "Non-appearance before the court.",
    "Failure to produce witnesses.",
    "Late submission of evidence.",
    "Ignoring court orders.",
  ],

  estimatedFee:
      "Court fee according to the applicable rules.",

  estimatedTime:
      "The duration varies depending upon the nature and complexity of the case.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Institution of Case",
      description:
          "The criminal court receives the police report or complaint and takes cognizance where appropriate.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Appearance of Accused",
      description:
          "The accused appears before the competent court.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Framing of Charge",
      description:
          "The court frames the charge where legally required.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Prosecution Evidence",
      description:
          "The prosecution produces witnesses and documentary evidence.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Statement of Accused",
      description:
          "The accused is examined in accordance with the applicable law.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Defence Evidence",
      description:
          "The defence may produce evidence and witnesses, where applicable.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Final Arguments",
      description:
          "Both parties present their final legal arguments before the court.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Judgment",
      description:
          "The court pronounces its judgment in accordance with the law.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Private Complaint Before Magistrate
//-----------------------------------------------------------

ProcedureModel(
  id: "private_complaint_magistrate",

  categoryId: "criminal",

  title: "Private Complaint Before Magistrate",

  overview:
      "A Private Complaint is a complaint filed directly before a Judicial Magistrate when a person alleges the commission of an offence and seeks judicial action. The Magistrate may examine the complainant, record preliminary evidence, order an inquiry where appropriate, and proceed in accordance with the applicable law.",

  governmentDepartment:
      "Judicial Magistrate Court",

  eligibility:
      "Any person having knowledge of the commission of an offence may file a private complaint before the competent Magistrate where permitted under the applicable law.",

  requiredDocuments: [
    "Original CNIC of Complainant",
    "Written Complaint",
    "Supporting Documents",
    "List of Witnesses",
    "Photographs, Videos or Other Evidence (if available)",
    "Vakalatnama (where represented by counsel)",
  ],

  applicableLaws: [
    "Code of Criminal Procedure, 1898",
    "Qanun-e-Shahadat Order, 1984",
    "Pakistan Penal Code, 1860 (where applicable)",
  ],

  importantNotes: [
    "Clearly state all relevant facts.",
    "Attach all available supporting evidence.",
    "Appear before the court on every hearing.",
    "Ensure witness details are accurate.",
  ],

  commonMistakes: [
    "Submitting an incomplete complaint.",
    "Failure to produce witnesses.",
    "Providing insufficient supporting evidence.",
    "Non-appearance before the court.",
  ],

  estimatedFee:
      "Court fee according to the applicable rules.",

  estimatedTime:
      "The duration depends upon the nature of the complaint and the court's schedule.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Prepare Complaint",
      description:
          "Prepare a detailed written complaint containing complete facts and allegations.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Collect Evidence",
      description:
          "Gather all relevant documents, photographs, videos and witness details.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "File Complaint",
      description:
          "Submit the complaint before the competent Judicial Magistrate.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Preliminary Examination",
      description:
          "The Magistrate examines the complainant on oath where required by law.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Recording of Preliminary Evidence",
      description:
          "The complainant may produce preliminary witnesses and supporting evidence.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Judicial Consideration",
      description:
          "The Magistrate considers the complaint and available material according to law.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Issuance of Process",
      description:
          "Where sufficient grounds exist, the court issues process against the accused or passes another appropriate order.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Further Proceedings",
      description:
          "The complaint proceeds before the competent court according to the applicable law.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Police Investigation
//-----------------------------------------------------------

ProcedureModel(
  id: "police_investigation",

  categoryId: "criminal",

  title: "Police Investigation",

  overview:
      "Police Investigation is the legal process conducted by the Investigating Officer after registration of an FIR or as otherwise permitted by law. During the investigation, evidence is collected, witnesses are examined, relevant documents are obtained, and the facts of the case are assessed to determine whether sufficient material exists to proceed before the competent court.",

  governmentDepartment:
      "Police Department",

  eligibility:
      "An investigation is conducted after registration of an FIR or under the applicable provisions of criminal law.",

  requiredDocuments: [
    "Copy of FIR",
    "Complaint (if applicable)",
    "Statements of Witnesses",
    "Documentary Evidence",
    "Forensic Reports (if applicable)",
    "Investigation Record",
  ],

  applicableLaws: [
    "Code of Criminal Procedure, 1898",
    "Police Order, 2002 (where applicable)",
    "Qanun-e-Shahadat Order, 1984",
    "Relevant Special Laws",
  ],

  importantNotes: [
    "Cooperate with the Investigating Officer.",
    "Preserve all physical and electronic evidence.",
    "Provide truthful statements.",
    "Keep copies of all documents submitted.",
  ],

  commonMistakes: [
    "Failure to produce evidence.",
    "Providing inconsistent statements.",
    "Ignoring investigation notices.",
    "Tampering with evidence.",
  ],

  estimatedFee:
      "No government fee is generally applicable.",

  estimatedTime:
      "The duration depends upon the complexity of the case and applicable legal requirements.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Assignment of Investigating Officer",
      description:
          "The competent police authority assigns the case to an Investigating Officer.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Inspection of Crime Scene",
      description:
          "The Investigating Officer visits and examines the place of occurrence where necessary.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Collection of Evidence",
      description:
          "Relevant documentary, physical and electronic evidence is collected.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Recording Statements",
      description:
          "Statements of witnesses and other relevant persons are recorded.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Forensic Examination",
      description:
          "Forensic analysis is conducted where required.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Evaluation of Evidence",
      description:
          "The Investigating Officer evaluates all collected material.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Preparation of Investigation Report",
      description:
          "The investigation record is finalized in accordance with law.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Submission for Challan",
      description:
          "After completion of the investigation, the case proceeds for submission of the police report (Challan) before the competent court where appropriate.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Challan Submission
//-----------------------------------------------------------

ProcedureModel(
  id: "challan_submission",

  categoryId: "criminal",

  title: "Challan Submission",

  overview:
      "A Challan (Police Report) is the final investigation report submitted by the Investigating Officer before the competent criminal court after completion of the investigation. The report contains the facts of the case, evidence collected, witness details, expert reports, and the opinion of the Investigating Officer regarding prosecution of the accused.",

  governmentDepartment:
      "Police Department / Prosecution Department",

  eligibility:
      "A Challan is submitted after completion of the investigation in accordance with the applicable provisions of criminal law.",

  requiredDocuments: [
    "Copy of FIR",
    "Investigation Report",
    "Statements of Witnesses",
    "Forensic Reports (if applicable)",
    "Recovery Memos",
    "Site Plan",
    "Medical Reports (if applicable)",
    "Documentary Evidence",
  ],

  applicableLaws: [
    "Code of Criminal Procedure, 1898",
    "Police Rules",
    "Relevant Special Criminal Laws",
  ],

  importantNotes: [
    "Ensure the investigation is complete before submission.",
    "Attach all documentary and forensic evidence.",
    "Verify witness details carefully.",
    "Submit the report within the legally prescribed period where applicable.",
  ],

  commonMistakes: [
    "Incomplete investigation record.",
    "Missing witness statements.",
    "Failure to attach expert reports.",
    "Errors in accused or complainant particulars.",
  ],

  estimatedFee:
      "No government fee is applicable.",

  estimatedTime:
      "Submission depends upon completion of investigation and legal requirements.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Complete Investigation",
      description:
          "Ensure that all investigation proceedings have been completed.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Review Evidence",
      description:
          "Review documentary, physical and electronic evidence collected during the investigation.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Prepare Police Report",
      description:
          "Prepare the Challan in the prescribed legal format.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Attach Supporting Documents",
      description:
          "Attach witness statements, forensic reports, medical reports and other supporting documents.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Legal Scrutiny",
      description:
          "The investigation record is reviewed by the competent supervisory authority where required.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Forward to Prosecution",
      description:
          "The case file is forwarded for prosecution processing where applicable.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Submit Before Court",
      description:
          "The Challan is submitted before the competent criminal court.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Trial Proceedings Begin",
      description:
          "The court proceeds further according to the applicable criminal procedure.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Criminal Revision
//-----------------------------------------------------------

ProcedureModel(
  id: "criminal_revision",

  categoryId: "criminal",

  title: "Criminal Revision",

  overview:
      "A Criminal Revision is a legal remedy through which the High Court or Sessions Court examines the legality, correctness, or propriety of an order passed by a subordinate criminal court. It is a supervisory jurisdiction intended to correct jurisdictional errors, material irregularities, or illegalities where no appeal lies or where revision is otherwise maintainable under the law.",

  governmentDepartment:
      "Sessions Court / High Court",

  eligibility:
      "Any person aggrieved by an order of a subordinate criminal court may file a criminal revision before the competent court where permitted by law.",

  requiredDocuments: [
    "Certified Copy of the Impugned Order",
    "Revision Petition",
    "Copy of FIR (if applicable)",
    "Relevant Court Record",
    "Supporting Documents",
    "Affidavit",
    "Vakalatnama",
  ],

  applicableLaws: [
    "Code of Criminal Procedure, 1898",
    "Relevant Judicial Precedents",
  ],

  importantNotes: [
    "File the revision within the prescribed limitation period.",
    "Clearly identify the legal error in the impugned order.",
    "Attach certified copies of all relevant documents.",
    "Attend all court hearings.",
  ],

  commonMistakes: [
    "Delay in filing the revision.",
    "Failure to attach certified copies.",
    "Raising factual disputes instead of legal issues.",
    "Submitting an incomplete court record.",
  ],

  estimatedFee:
      "Court fee according to the applicable rules.",

  estimatedTime:
      "The duration depends upon the court's schedule and the complexity of the matter.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Obtain Certified Copy",
      description:
          "Obtain a certified copy of the order intended to be challenged.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Consult Legal Counsel",
      description:
          "Prepare the criminal revision petition with relevant legal grounds.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Draft Revision Petition",
      description:
          "Draft the petition highlighting jurisdictional errors, illegality or material irregularity.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Attach Supporting Documents",
      description:
          "Attach certified copies and all supporting documents.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "File Before Competent Court",
      description:
          "Submit the revision petition before the Sessions Court or High Court, as applicable.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Notice to Respondents",
      description:
          "The court may issue notice to the respondents and call for the record.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Hearing",
      description:
          "The parties present their legal arguments before the court.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Final Order",
      description:
          "The court decides the revision petition in accordance with the law.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Criminal Appeal
//-----------------------------------------------------------

ProcedureModel(
  id: "criminal_appeal",

  categoryId: "criminal",

  title: "Criminal Appeal",

  overview:
      "A Criminal Appeal is a statutory legal remedy through which an aggrieved person challenges a judgment, conviction, acquittal, sentence, or other appealable order before a higher court. The appellate court re-examines the record, hears the parties, and decides the appeal in accordance with the applicable law.",

  governmentDepartment:
      "Sessions Court / High Court / Supreme Court of Pakistan",

  eligibility:
      "Any person aggrieved by an appealable judgment, conviction, acquittal, sentence, or order may file a criminal appeal before the competent appellate court in accordance with the applicable law.",

  requiredDocuments: [
    "Certified Copy of Judgment",
    "Certified Copy of Sentence or Order",
    "Memorandum of Appeal",
    "Supporting Documents",
    "Court Record (where applicable)",
    "Affidavit",
    "Vakalatnama",
  ],

  applicableLaws: [
    "Code of Criminal Procedure, 1898",
    "Relevant Special Criminal Laws",
    "Applicable Judicial Precedents",
  ],

  importantNotes: [
    "File the appeal within the prescribed limitation period.",
    "Obtain certified copies before filing.",
    "Clearly state the grounds of appeal.",
    "Appear before the appellate court on every hearing.",
  ],

  commonMistakes: [
    "Delay in filing the appeal.",
    "Incomplete grounds of appeal.",
    "Failure to attach certified copies.",
    "Incorrect court jurisdiction.",
  ],

  estimatedFee:
      "Court fee according to the applicable rules.",

  estimatedTime:
      "Depends upon the appellate court's schedule and complexity of the case.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Obtain Certified Copies",
      description:
          "Obtain certified copies of the judgment and all relevant orders.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Consult Legal Counsel",
      description:
          "Review the judgment and prepare the grounds of appeal.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Draft Memorandum of Appeal",
      description:
          "Prepare the appeal in the prescribed legal format.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Attach Supporting Documents",
      description:
          "Attach certified copies and all supporting documents.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "File Appeal",
      description:
          "Submit the appeal before the competent appellate court.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Notice to Respondent",
      description:
          "The appellate court issues notice and calls for the trial court record where necessary.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Arguments",
      description:
          "Both parties present their legal arguments before the appellate court.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Appellate Judgment",
      description:
          "The appellate court decides the appeal in accordance with the law.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Acquittal Proceedings
//-----------------------------------------------------------

ProcedureModel(
  id: "acquittal_proceedings",

  categoryId: "criminal",

  title: "Acquittal Proceedings",

  overview:
      "Acquittal Proceedings refer to the judicial process through which a criminal court determines that the prosecution has failed to establish the guilt of the accused in accordance with the applicable law. Upon acquittal, the accused is discharged from criminal liability in that case, subject to any appeal or other legal remedy available under the law.",

  governmentDepartment:
      "Judicial Magistrate / Sessions Court / Special Court",

  eligibility:
      "An accused person facing a criminal trial may be acquitted by the competent court where the prosecution fails to prove the case in accordance with the applicable law.",

  requiredDocuments: [
    "Copy of FIR",
    "Police Report (Challan)",
    "Witness Statements",
    "Documentary Evidence",
    "Forensic Reports (if applicable)",
    "Judgment Record",
  ],

  applicableLaws: [
    "Code of Criminal Procedure, 1898",
    "Qanun-e-Shahadat Order, 1984",
    "Pakistan Penal Code, 1860",
    "Relevant Special Laws",
  ],

  importantNotes: [
    "Attend every court hearing.",
    "Preserve all defence evidence.",
    "Produce defence witnesses where necessary.",
    "Comply with all court directions.",
  ],

  commonMistakes: [
    "Failure to appear before the court.",
    "Late production of defence evidence.",
    "Ignoring court directions.",
    "Incomplete documentation.",
  ],

  estimatedFee:
      "Court fee according to the applicable rules.",

  estimatedTime:
      "Depends upon the duration of the criminal trial and court proceedings.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Completion of Trial",
      description:
          "The prosecution and defence conclude their evidence.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Final Arguments",
      description:
          "Both parties present final legal arguments before the court.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Evaluation of Evidence",
      description:
          "The court evaluates all oral, documentary and forensic evidence.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Application of Law",
      description:
          "The court applies the relevant legal provisions to the facts of the case.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Pronouncement of Judgment",
      description:
          "The court pronounces its judgment.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Order of Acquittal",
      description:
          "Where the prosecution fails to prove the case, the accused is acquitted.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Release of Accused",
      description:
          "If the accused is in custody and no other legal impediment exists, release orders are issued.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Further Legal Remedy",
      description:
          "The aggrieved party may pursue any remedy available under the applicable law.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Probation
//-----------------------------------------------------------

ProcedureModel(
  id: "probation",

  categoryId: "criminal",

  title: "Probation",

  overview:
      "Probation is a legal measure through which a convicted offender is released under specified conditions instead of serving imprisonment, where permitted by law. The court considers the nature of the offence, the character of the offender, surrounding circumstances, and other relevant factors before granting the benefit of probation.",

  governmentDepartment:
      "Judicial Magistrate / Sessions Court / Probation & Parole Department",

  eligibility:
      "A convicted person may be considered for probation where the applicable law empowers the court to grant such relief.",

  requiredDocuments: [
    "Judgment of Conviction",
    "Sentence Order",
    "Probation Application (where applicable)",
    "Character Documents (if required)",
    "Supporting Documents",
    "Vakalatnama",
  ],

  applicableLaws: [
    "Probation of Offenders Ordinance, 1960",
    "Code of Criminal Procedure, 1898",
    "Relevant Judicial Precedents",
  ],

  importantNotes: [
    "Probation is granted at the discretion of the court.",
    "The offender must comply with all probation conditions.",
    "Violation of probation conditions may result in cancellation of probation.",
    "Maintain regular contact with the Probation Officer where required.",
  ],

  commonMistakes: [
    "Violation of probation conditions.",
    "Failure to appear before the Probation Officer.",
    "Providing incorrect information.",
    "Committing another offence during probation.",
  ],

  estimatedFee:
      "Court fee according to the applicable rules.",

  estimatedTime:
      "Depends upon the court proceedings and preparation of the probation assessment report.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Conviction by Court",
      description:
          "The accused is convicted by the competent criminal court.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Assessment for Probation",
      description:
          "The court considers whether the case is suitable for probation.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Probation Report",
      description:
          "A report may be obtained from the Probation Officer where required.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Hearing",
      description:
          "The court hears the parties regarding the request for probation.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Court Decision",
      description:
          "The court decides whether probation should be granted.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Execution of Bond",
      description:
          "The offender executes the required bond and accepts the probation conditions.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Supervision",
      description:
          "The offender remains under supervision for the period specified by the court.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Successful Completion",
      description:
          "Upon successful completion of the probation period, the offender is discharged in accordance with the law.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Mercy Petition
//-----------------------------------------------------------

ProcedureModel(
  id: "mercy_petition",

  categoryId: "criminal",

  title: "Mercy Petition",

  overview:
      "A Mercy Petition is a constitutional remedy through which a convicted person requests the competent constitutional authority to grant pardon, reprieve, respite, remission, suspension, or commutation of a sentence in accordance with the Constitution and applicable law. The authority considers the petition on humanitarian, legal, and public interest grounds.",

  governmentDepartment:
      "President of Pakistan / Provincial Governor (as applicable)",

  eligibility:
      "A convicted person, or a person acting on the convict's behalf where permissible, may submit a mercy petition after exhaustion of the available judicial remedies or in accordance with the applicable law.",

  requiredDocuments: [
    "Copy of Conviction Judgment",
    "Copy of Sentence Order",
    "Copies of Appellate Judgments (if any)",
    "Mercy Petition",
    "Supporting Documents",
    "Medical Documents (where applicable)",
    "Character Certificates (if applicable)",
  ],

  applicableLaws: [
    "Constitution of the Islamic Republic of Pakistan, 1973",
    "Code of Criminal Procedure, 1898",
    "Relevant Prison Rules",
  ],

  importantNotes: [
    "A mercy petition is not a judicial appeal.",
    "Clearly state humanitarian or exceptional grounds.",
    "Attach all relevant judgments and supporting documents.",
    "Submission of a mercy petition does not automatically suspend the sentence unless ordered by the competent authority.",
  ],

  commonMistakes: [
    "Submitting an incomplete petition.",
    "Failure to attach court judgments.",
    "Omitting relevant humanitarian grounds.",
    "Providing incorrect personal information.",
  ],

  estimatedFee:
      "No government fee is generally applicable.",

  estimatedTime:
      "The time required varies depending upon the administrative process and the competent authority.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Complete Judicial Remedies",
      description:
          "Ensure that all available judicial remedies have been exhausted where required.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Prepare Mercy Petition",
      description:
          "Draft a mercy petition setting out all relevant legal and humanitarian grounds.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Collect Supporting Documents",
      description:
          "Attach judgments, medical records and other supporting documents.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Submit Petition",
      description:
          "Submit the petition through the prescribed legal or administrative channel.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Administrative Processing",
      description:
          "The petition is processed and relevant reports may be obtained.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Review by Competent Authority",
      description:
          "The competent constitutional authority examines the petition.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Decision",
      description:
          "The petition is accepted, rejected, or otherwise decided according to law.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Implementation",
      description:
          "Any order granting pardon, remission, commutation or other relief is implemented in accordance with the applicable law.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Criminal Record Correction
//-----------------------------------------------------------

ProcedureModel(
  id: "criminal_record_correction",

  categoryId: "criminal",

  title: "Criminal Record Correction",

  overview:
      "Criminal Record Correction is the legal process through which an individual seeks correction of inaccurate, incomplete, or erroneous information contained in official criminal records maintained by the competent authority. Depending upon the nature of the error, the request may involve administrative correction or an order from the competent court.",

  governmentDepartment:
      "Police Department / Criminal Record Office / Competent Court",

  eligibility:
      "Any person whose criminal record contains incorrect or incomplete information may apply for correction in accordance with the applicable law.",

  requiredDocuments: [
    "Original CNIC",
    "Certified Copy of Relevant Court Order (if applicable)",
    "Copy of Judgment or Acquittal Order",
    "Application for Record Correction",
    "Supporting Documentary Evidence",
    "Affidavit (where required)",
  ],

  applicableLaws: [
    "Code of Criminal Procedure, 1898",
    "Police Rules",
    "Relevant Provincial Police Laws",
    "Applicable Judicial Precedents",
  ],

  importantNotes: [
    "Verify all personal information before submission.",
    "Attach certified copies of court orders where applicable.",
    "Keep copies of all submitted documents.",
    "Follow up with the concerned authority until the correction is completed.",
  ],

  commonMistakes: [
    "Submitting uncertified documents.",
    "Providing incomplete personal information.",
    "Failure to attach the relevant court order.",
    "Applying before the wrong authority.",
  ],

  estimatedFee:
      "According to the applicable departmental rules, if any.",

  estimatedTime:
      "Generally depends upon verification by the concerned authority and the nature of the correction requested.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Identify the Error",
      description:
          "Review the criminal record and identify the incorrect or incomplete information.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Collect Supporting Documents",
      description:
          "Gather court orders, judgments and all supporting documents.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Prepare Application",
      description:
          "Prepare the application requesting correction of the criminal record.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Submit Application",
      description:
          "Submit the application before the competent police authority or other competent authority.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Verification",
      description:
          "The authority verifies the documents and the official record.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Decision",
      description:
          "The competent authority decides whether the requested correction should be allowed.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Update Record",
      description:
          "Where approved, the official criminal record is corrected accordingly.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Obtain Updated Record",
      description:
          "Obtain confirmation or an updated record showing the correction.",
    ),
  ],
),

];