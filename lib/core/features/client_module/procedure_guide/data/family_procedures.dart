import '../models/procedure_model.dart';
import '../models/procedure_step.dart';

  final List<ProcedureModel> familyProcedures = [

//-----------------------------------------------------------
//  Family Matters
//-----------------------------------------------------------

//-----------------------------------------------------------
// Procedure: Marriage Registration
//-----------------------------------------------------------

ProcedureModel(
  id: "marriage_registration",

  categoryId: "family",

  title: "Marriage Registration",

  overview:
      "Marriage Registration is the legal process of recording a marriage with the competent authority after a valid Nikah has been solemnized. Registration provides official legal evidence of the marriage and facilitates the exercise of legal rights by both spouses.",

  governmentDepartment:
      "Union Council / Cantonment Board / Local Government Authority",

  eligibility:
      "A marriage validly solemnized under the applicable law may be registered by the authorized Nikah Registrar in accordance with legal requirements.",

  requiredDocuments: [
    "Original CNIC of Bride",
    "Original CNIC of Groom",
    "CNIC of Witnesses",
    "Nikah Nama",
    "Passport-size Photographs (where required)",
    "Proof of Residence (where applicable)",
  ],

  applicableLaws: [
    "Muslim Family Laws Ordinance, 1961",
    "West Pakistan Muslim Family Rules, 1961",
    "Relevant Local Government Laws",
  ],

  importantNotes: [
    "Ensure that the Nikah Nama is completed accurately.",
    "Verify all personal details before registration.",
    "Obtain multiple certified copies of the registered Nikah Nama.",
    "Register the marriage promptly after solemnization.",
  ],

  commonMistakes: [
    "Incorrect CNIC numbers.",
    "Missing signatures of witnesses.",
    "Incomplete Nikah Nama.",
    "Delay in registration.",
  ],

  estimatedFee:
      "According to the applicable local government fee schedule.",

  estimatedTime:
      "Usually completed within 1–7 working days.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Perform Nikah",
      description:
          "The marriage is solemnized according to the applicable law.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Complete Nikah Nama",
      description:
          "The Nikah Registrar completes all required entries in the Nikah Nama.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Verify Identity",
      description:
          "The identities of the bride, groom and witnesses are verified.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Submit Registration",
      description:
          "The Nikah Registrar submits the marriage record to the concerned Union Council.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Official Verification",
      description:
          "The competent authority verifies the submitted record.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Marriage Registration",
      description:
          "The marriage is officially recorded in the government register.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Issue Certified Record",
      description:
          "Certified copies of the registered Nikah Nama are prepared.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Collect Registration Documents",
      description:
          "The registered marriage documents are collected for future legal use.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Divorce Procedure
//-----------------------------------------------------------

ProcedureModel(
  id: "divorce_procedure",

  categoryId: "family",

  title: "Divorce Procedure",

  overview:
      "Divorce is the legal process through which a marriage is dissolved in accordance with the applicable family laws. Under Pakistani law, a husband who pronounces Talaq must follow the prescribed legal procedure, including written notice to the Chairman of the Union Council and completion of the reconciliation process before the divorce becomes effective.",

  governmentDepartment:
      "Union Council / Arbitration Council",

  eligibility:
      "A husband who intends to dissolve a valid marriage in accordance with the applicable family laws may initiate the divorce procedure.",

  requiredDocuments: [
    "Original CNIC of Husband",
    "Copy of Wife's CNIC (if available)",
    "Original or Copy of Nikah Nama",
    "Written Divorce Notice",
    "Address of the Wife",
    "Supporting Documents (if applicable)",
  ],

  applicableLaws: [
    "Muslim Family Laws Ordinance, 1961",
    "West Pakistan Muslim Family Rules, 1961",
    "Family Courts Act, 1964 (where applicable)",
  ],

  importantNotes: [
    "Written notice must be sent to the Chairman of the Union Council.",
    "A copy of the notice must also be served upon the wife.",
    "Failure to give notice may have legal consequences.",
    "The divorce generally becomes effective after the statutory reconciliation period, subject to the applicable law.",
  ],

  commonMistakes: [
    "Failing to notify the Union Council.",
    "Not serving a copy of the notice on the wife.",
    "Providing incorrect personal details.",
    "Ignoring reconciliation proceedings.",
  ],

  estimatedFee:
      "Government fee, if any, according to the applicable local authority schedule.",

  estimatedTime:
      "Usually around 90 days, subject to completion of the statutory reconciliation process and applicable law.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Prepare Divorce Notice",
      description:
          "Prepare a written notice of divorce containing the required information.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Submit Notice",
      description:
          "Submit the written notice to the Chairman of the concerned Union Council.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Serve Notice",
      description:
          "Ensure that a copy of the divorce notice is served upon the wife.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Formation of Arbitration Council",
      description:
          "The Chairman constitutes an Arbitration Council in accordance with the law.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Reconciliation Proceedings",
      description:
          "The Arbitration Council attempts reconciliation between the spouses.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Completion of Statutory Period",
      description:
          "The prescribed statutory period is completed if reconciliation is unsuccessful.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Divorce Takes Effect",
      description:
          "The divorce becomes effective in accordance with the applicable legal provisions.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Obtain Official Record",
      description:
          "Obtain the relevant certificate or official record from the competent authority, where applicable.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Khula Procedure
//-----------------------------------------------------------

ProcedureModel(
  id: "khula_procedure",

  categoryId: "family",

  title: "Khula Procedure",

  overview:
      "Khula is the legal process through which a wife seeks dissolution of her marriage through the Family Court when reconciliation is not possible. Upon satisfaction of the legal requirements, the Family Court may pass a decree for dissolution of marriage, after which the prescribed legal formalities are completed.",

  governmentDepartment:
      "Family Court / Union Council",

  eligibility:
      "A wife who seeks dissolution of her marriage under the applicable family laws may file a suit for Khula before the competent Family Court.",

  requiredDocuments: [
    "Original CNIC of Wife",
    "Copy of Husband's CNIC (if available)",
    "Original or Copy of Nikah Nama",
    "Marriage Photographs (if available)",
    "Supporting Documents",
    "Court Fee (where applicable)",
  ],

  applicableLaws: [
    "Family Courts Act, 1964",
    "Muslim Family Laws Ordinance, 1961",
    "West Pakistan Muslim Family Rules, 1961",
  ],

  importantNotes: [
    "Khula is granted by the Family Court after legal proceedings.",
    "The Court normally attempts reconciliation before deciding the case.",
    "The wife may be required to return Haq Mehr or other benefits according to the applicable law and court order.",
    "Every case depends upon its own facts and evidence.",
  ],

  commonMistakes: [
    "Filing the case before the wrong court.",
    "Submitting incomplete documents.",
    "Missing court hearings.",
    "Not updating address or contact information.",
  ],

  estimatedFee:
      "Court fee and other expenses according to the applicable law.",

  estimatedTime:
      "Usually 2–6 months depending upon the facts of the case and court proceedings.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Consult a Lawyer",
      description:
          "Seek legal advice regarding the grounds and legal consequences of Khula.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Prepare the Suit",
      description:
          "Prepare and file the Khula suit before the competent Family Court.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Court Notice",
      description:
          "The Family Court issues notice to the husband.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Reconciliation Attempt",
      description:
          "The Court attempts reconciliation between the parties where required by law.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Court Proceedings",
      description:
          "Both parties present their evidence and arguments before the Court.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Khula Decree",
      description:
          "If the legal requirements are fulfilled, the Court passes a decree for dissolution of marriage.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Union Council Proceedings",
      description:
          "The decree is communicated to the concerned Union Council for completion of statutory formalities.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Obtain Certificate",
      description:
          "Obtain the relevant certificate or official record after completion of the legal process.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Child Custody
//-----------------------------------------------------------

ProcedureModel(
  id: "child_custody",

  categoryId: "family",

  title: "Child Custody",

  overview:
      "Child Custody is the legal process through which the Family Court determines with whom a minor child should reside and who should have responsibility for the child's care, welfare, and upbringing. The paramount consideration for the Court is the welfare and best interests of the child.",

  governmentDepartment:
      "Family Court",

  eligibility:
      "A parent, legal guardian, or any person legally entitled under the applicable law may file a child custody petition before the competent Family Court.",

  requiredDocuments: [
    "Original CNIC of Applicant",
    "Birth Certificate of Child",
    "B-Form (where applicable)",
    "Nikah Nama / Divorce Decree (if applicable)",
    "Supporting Evidence",
    "Court Fee (where applicable)",
  ],

  applicableLaws: [
    "Guardian and Wards Act, 1890",
    "Family Courts Act, 1964",
    "Relevant Personal Laws",
  ],

  importantNotes: [
    "The welfare of the child is the primary consideration.",
    "The Court may hear both parents before passing an order.",
    "Interim custody orders may be granted where necessary.",
    "Custody orders may be modified if circumstances change.",
  ],

  commonMistakes: [
    "Submitting insufficient evidence.",
    "Ignoring court notices.",
    "Missing court hearings.",
    "Providing incomplete child information.",
  ],

  estimatedFee:
      "Court fee according to the applicable law.",

  estimatedTime:
      "Usually 3–12 months depending upon the complexity of the case.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Prepare Custody Petition",
      description:
          "Prepare the custody petition with complete facts and supporting documents.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "File Before Family Court",
      description:
          "File the petition before the competent Family Court.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Issue Notice",
      description:
          "The Court issues notice to the respondent.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Submit Evidence",
      description:
          "Both parties submit evidence regarding the welfare of the child.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Court Hearings",
      description:
          "The Court records evidence and hears the parties.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Welfare Assessment",
      description:
          "The Court evaluates the best interests and welfare of the child.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Final Judgment",
      description:
          "The Family Court passes a custody order.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Implementation",
      description:
          "The custody order is implemented according to law.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Child Guardianship
//-----------------------------------------------------------

ProcedureModel(
  id: "child_guardianship",

  categoryId: "family",

  title: "Child Guardianship",

  overview:
      "Child Guardianship is the legal process through which the Family Court appoints or recognizes a person as the lawful guardian of a minor child for matters relating to the child's person, property, education, health, or financial affairs. The Court always considers the welfare and best interests of the child before granting guardianship.",

  governmentDepartment:
      "Family Court",

  eligibility:
      "A parent, close relative, legal guardian, or any person having a lawful interest in the welfare of the minor may apply for guardianship before the competent Family Court.",

  requiredDocuments: [
    "Original CNIC of Applicant",
    "Birth Certificate of Minor",
    "B-Form (where applicable)",
    "Death Certificate of Parent (where applicable)",
    "Relationship Proof",
    "Supporting Documents",
    "Court Fee (where applicable)",
  ],

  applicableLaws: [
    "Guardian and Wards Act, 1890",
    "Family Courts Act, 1964",
    "Relevant Personal Laws",
  ],

  importantNotes: [
    "The welfare of the minor is the primary consideration.",
    "The Court may require evidence regarding the applicant's suitability.",
    "Guardianship may relate to the person, property, or both.",
    "Court permission may be required for certain acts relating to the minor's property.",
  ],

  commonMistakes: [
    "Incomplete supporting documents.",
    "Failure to establish relationship with the minor.",
    "Ignoring court notices.",
    "Missing scheduled hearings.",
  ],

  estimatedFee:
      "Court fee according to the applicable law.",

  estimatedTime:
      "Usually 3–9 months depending upon the complexity of the proceedings.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Prepare Guardianship Petition",
      description:
          "Prepare the guardianship petition with complete facts and supporting documents.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "File Before Family Court",
      description:
          "File the petition before the competent Family Court.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Issue Notice",
      description:
          "The Court issues notice to all necessary parties.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Submit Evidence",
      description:
          "Present evidence establishing the applicant's suitability and the welfare of the child.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Court Hearings",
      description:
          "The Court hears the parties and records evidence.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Welfare Assessment",
      description:
          "The Court evaluates the best interests and welfare of the minor.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Guardianship Order",
      description:
          "The Court passes an order appointing or refusing to appoint the guardian.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Compliance with Court Order",
      description:
          "The appointed guardian performs duties in accordance with the Court's directions and applicable law.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Maintenance (Wife & Children)
//-----------------------------------------------------------

ProcedureModel(
  id: "maintenance_wife_children",

  categoryId: "family",

  title: "Maintenance (Wife & Children)",

  overview:
      "Maintenance is the legal process through which a wife, minor children, or other persons entitled under the applicable law seek financial support from a person legally bound to maintain them. The Family Court determines maintenance after considering the financial circumstances of the parties and the applicable law.",

  governmentDepartment:
      "Family Court",

  eligibility:
      "A wife, minor child, or any person legally entitled to maintenance under the applicable law may file a maintenance suit before the competent Family Court.",

  requiredDocuments: [
    "Original CNIC of Applicant",
    "Marriage Certificate / Nikah Nama (where applicable)",
    "Birth Certificates of Children",
    "B-Form (where applicable)",
    "Income Details (if available)",
    "Supporting Documents",
    "Court Fee (where applicable)",
  ],

  applicableLaws: [
    "Family Courts Act, 1964",
    "Muslim Family Laws Ordinance, 1961",
    "Guardian and Wards Act, 1890 (where applicable)",
  ],

  importantNotes: [
    "The Court considers the needs of the claimant and the financial capacity of the respondent.",
    "Interim maintenance may be granted during the proceedings.",
    "Maintenance may be revised if circumstances change.",
    "Accurate financial information should be provided.",
  ],

  commonMistakes: [
    "Submitting incomplete financial information.",
    "Missing court hearings.",
    "Failure to provide supporting evidence.",
    "Ignoring interim maintenance orders.",
  ],

  estimatedFee:
      "Court fee according to the applicable law.",

  estimatedTime:
      "Usually 3–9 months depending upon the complexity of the case.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Prepare Maintenance Suit",
      description:
          "Prepare the maintenance claim with complete facts and supporting documents.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "File Before Family Court",
      description:
          "File the maintenance suit before the competent Family Court.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Issue Notice",
      description:
          "The Court issues notice to the respondent.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Submit Evidence",
      description:
          "Both parties submit evidence regarding income, expenses and financial circumstances.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Interim Maintenance",
      description:
          "Where appropriate, the Court may grant interim maintenance during the proceedings.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Court Hearings",
      description:
          "The Court hears the parties and records evidence.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Final Judgment",
      description:
          "The Family Court determines the maintenance amount and passes the final order.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Execution of Order",
      description:
          "The maintenance order is implemented and enforced in accordance with the law.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Succession Certificate
//-----------------------------------------------------------

ProcedureModel(
  id: "succession_certificate",

  categoryId: "family",

  title: "Succession Certificate",

  overview:
      "A Succession Certificate is a legal document issued by the competent authority that authorizes the lawful legal heirs to collect, transfer, or receive the movable assets and financial interests of a deceased person, including bank accounts, pensions, shares, securities, and other movable property.",

  governmentDepartment:
      "National Database and Registration Authority (NADRA) / Competent Court (where applicable)",

  eligibility:
      "Any lawful legal heir of a deceased person may apply for a succession certificate in accordance with the applicable law.",

  requiredDocuments: [
    "Original CNIC of Applicant",
    "Death Certificate of Deceased",
    "Family Registration Certificate (FRC)",
    "Legal Heir Information",
    "Details of Movable Assets",
    "Supporting Documents",
  ],

  applicableLaws: [
    "Letters of Administration and Succession Certificates Act, 2020",
    "Relevant NADRA Rules",
    "Succession Act (where applicable)",
  ],

  importantNotes: [
    "Provide complete information about all legal heirs.",
    "Disclose all movable assets accurately.",
    "Incorrect information may delay the process.",
    "Keep certified copies of the issued certificate.",
  ],

  commonMistakes: [
    "Incomplete legal heir details.",
    "Failure to disclose all assets.",
    "Incorrect CNIC information.",
    "Missing supporting documents.",
  ],

  estimatedFee:
      "According to the applicable government fee schedule.",

  estimatedTime:
      "Usually 15–60 days depending upon verification and legal requirements.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Collect Required Documents",
      description:
          "Gather the death certificate, CNICs, FRC and supporting documents.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Prepare Application",
      description:
          "Complete the prescribed succession certificate application.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Submit Application",
      description:
          "Submit the application before the competent authority.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Verification",
      description:
          "The authority verifies the identity of the applicant and legal heirs.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Public Notice (Where Required)",
      description:
          "A public notice may be issued in accordance with the applicable law.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Decision",
      description:
          "The competent authority decides the application after completing the legal process.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Issue Certificate",
      description:
          "The Succession Certificate is issued to the lawful legal heirs.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Use the Certificate",
      description:
          "Present the certificate before banks and other institutions to claim the deceased's movable assets.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Guardianship Certificate
//-----------------------------------------------------------

ProcedureModel(
  id: "guardianship_certificate",

  categoryId: "family",

  title: "Guardianship Certificate",

  overview:
      "A Guardianship Certificate is a legal document issued by the competent Family Court appointing a person as the lawful guardian of a minor or a person legally requiring guardianship. The certificate authorizes the guardian to perform specified legal, educational, medical, financial, or administrative functions on behalf of the minor in accordance with the Court's order.",

  governmentDepartment:
      "Family Court",

  eligibility:
      "A parent, close relative, or any person having a lawful interest in the welfare of a minor may apply for a Guardianship Certificate before the competent Family Court.",

  requiredDocuments: [
    "Original CNIC of Applicant",
    "Birth Certificate of Minor",
    "B-Form (where applicable)",
    "Death Certificate of Parent (where applicable)",
    "Relationship Proof",
    "Passport-size Photographs",
    "Supporting Documents",
  ],

  applicableLaws: [
    "Guardian and Wards Act, 1890",
    "Family Courts Act, 1964",
    "Relevant Personal Laws",
  ],

  importantNotes: [
    "The welfare of the minor is the primary consideration.",
    "The Court may require documentary and oral evidence.",
    "The certificate only grants the authority specified in the Court's order.",
    "The guardian must always act in the best interests of the minor.",
  ],

  commonMistakes: [
    "Submitting incomplete documentation.",
    "Failure to prove relationship.",
    "Missing court hearings.",
    "Providing incorrect personal information.",
  ],

  estimatedFee:
      "Court fee according to the applicable law.",

  estimatedTime:
      "Usually 2–6 months depending upon the facts of the case.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Prepare Guardianship Petition",
      description:
          "Prepare the petition with complete facts and supporting documents.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "File Before Family Court",
      description:
          "Submit the petition before the competent Family Court.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Court Notice",
      description:
          "The Court issues notices to all necessary parties.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Evidence",
      description:
          "Present documentary and oral evidence supporting the application.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Court Hearing",
      description:
          "The Court hears the applicant and other interested parties.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Welfare Assessment",
      description:
          "The Court determines whether granting guardianship serves the best interests of the minor.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Issue Guardianship Certificate",
      description:
          "If satisfied, the Court issues the Guardianship Certificate.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Use Certificate",
      description:
          "Use the certificate wherever legal proof of guardianship is required.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Domestic Violence Complaint
//-----------------------------------------------------------

ProcedureModel(
  id: "domestic_violence_complaint",

  categoryId: "family",

  title: "Domestic Violence Complaint",

  overview:
      "A Domestic Violence Complaint is a legal remedy available to a person alleging domestic violence under the applicable law. Depending on the province and the nature of the allegations, the complainant may seek protection orders, residence orders, monetary relief, custody-related relief, or other remedies provided by law.",

  governmentDepartment:
      "Family Court / Magistrate / Protection Centre (as applicable under provincial law)",

  eligibility:
      "A person entitled to seek relief under the applicable domestic violence legislation may file a complaint before the competent authority.",

  requiredDocuments: [
    "Original CNIC of Applicant",
    "Medical Reports (if available)",
    "Police Report (if any)",
    "Photographs or Other Evidence (if available)",
    "Witness Details (if any)",
    "Supporting Documents",
  ],

  applicableLaws: [
    "Relevant Provincial Domestic Violence Law",
    "Family Courts Act, 1964 (where applicable)",
    "Pakistan Penal Code (where applicable)",
  ],

  importantNotes: [
    "Immediate protection may be available in appropriate cases.",
    "Keep all available evidence safely.",
    "Report incidents promptly where possible.",
    "Court procedures may vary according to the applicable provincial law.",
  ],

  commonMistakes: [
    "Delaying the complaint without preserving evidence.",
    "Submitting incomplete information.",
    "Failing to attend scheduled hearings.",
    "Not providing witness details where available.",
  ],

  estimatedFee:
      "Usually according to the applicable court or government fee schedule.",

  estimatedTime:
      "Depends upon the nature of proceedings and the relief sought.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Collect Evidence",
      description:
          "Gather all available documents, medical reports and supporting evidence.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Prepare Complaint",
      description:
          "Prepare the complaint with complete facts.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "File Before Competent Authority",
      description:
          "Submit the complaint before the competent court or authority.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Issue Notice",
      description:
          "The respondent is notified according to law.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Interim Relief",
      description:
          "Where permitted, the Court may grant interim protection or other temporary relief.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Hearings",
      description:
          "The parties present their evidence before the Court.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Final Order",
      description:
          "The Court passes an appropriate order in accordance with the law.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Implementation",
      description:
          "The order is implemented according to the applicable legal procedure.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Family Court Suit
//-----------------------------------------------------------

ProcedureModel(
  id: "family_court_suit",

  categoryId: "family",

  title: "Family Court Suit",

  overview:
      "A Family Court Suit is the legal process through which disputes relating to marriage, dissolution of marriage, dower, maintenance, custody, guardianship, visitation rights, and other family matters are adjudicated by the competent Family Court in accordance with the applicable law.",

  governmentDepartment:
      "Family Court",

  eligibility:
      "Any person having a legal right to seek relief under the Family Courts Act or other applicable family laws may institute a Family Court Suit before the competent Court.",

  requiredDocuments: [
    "Original CNIC of Plaintiff",
    "CNIC of Defendant (if available)",
    "Nikah Nama (where applicable)",
    "Birth Certificates of Children (where applicable)",
    "Supporting Documentary Evidence",
    "List of Witnesses (if any)",
    "Court Fee (where applicable)",
  ],

  applicableLaws: [
    "Family Courts Act, 1964",
    "Muslim Family Laws Ordinance, 1961",
    "Guardian and Wards Act, 1890 (where applicable)",
    "Relevant Personal Laws",
  ],

  importantNotes: [
    "File the suit before the Court having territorial jurisdiction.",
    "Provide complete and truthful facts.",
    "Keep original documents available for evidence.",
    "Attend every hearing fixed by the Court.",
  ],

  commonMistakes: [
    "Filing before the wrong Court.",
    "Incomplete pleadings.",
    "Failure to produce documentary evidence.",
    "Absence during court proceedings.",
  ],

  estimatedFee:
      "According to the applicable court fee schedule.",

  estimatedTime:
      "Usually 6–18 months depending upon the nature and complexity of the dispute.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Prepare Plaint",
      description:
          "Prepare the plaint containing complete facts and legal relief sought.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Attach Documents",
      description:
          "Attach all supporting documents and available evidence.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "File the Suit",
      description:
          "Present the suit before the competent Family Court.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Issue Summons",
      description:
          "The Court issues summons to the defendant.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Written Statement",
      description:
          "The defendant files a written statement and supporting documents.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Recording of Evidence",
      description:
          "The Court records evidence produced by both parties.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Final Arguments",
      description:
          "The parties present their final legal arguments before the Court.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Judgment",
      description:
          "The Family Court pronounces its judgment and grants appropriate relief.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Court Marriage
//-----------------------------------------------------------

ProcedureModel(
  id: "court_marriage",

  categoryId: "family",

  title: "Court Marriage",

  overview:
      "Court Marriage refers to the legal solemnization and documentation of a marriage where two legally competent adults marry of their free will in accordance with the applicable laws of Pakistan. After the Nikah is solemnized by an authorized Nikah Registrar, the marriage is registered with the competent authority.",

  governmentDepartment:
      "Union Council / Cantonment Board / Authorized Nikah Registrar",

  eligibility:
      "A man and a woman who are legally competent to marry under the applicable laws and who freely consent to the marriage.",

  requiredDocuments: [
    "Original CNIC of Bride",
    "Original CNIC of Groom",
    "CNIC of Two Adult Witnesses",
    "Passport-size Photographs",
    "Affidavit (where applicable)",
    "Divorce Certificate / Death Certificate of Former Spouse (if applicable)",
  ],

  applicableLaws: [
    "Muslim Family Laws Ordinance, 1961",
    "West Pakistan Muslim Family Rules, 1961",
    "Registration Act, 1908 (where applicable)",
  ],

  importantNotes: [
    "Both parties must freely consent to the marriage.",
    "The Nikah should be performed by an authorized Nikah Registrar.",
    "The Nikah Nama should be completed accurately.",
    "Keep certified copies of the registered Nikah Nama.",
  ],

  commonMistakes: [
    "Incomplete CNIC information.",
    "Incorrect witness details.",
    "Failure to register the marriage.",
    "Errors in the Nikah Nama.",
  ],

  estimatedFee:
      "According to the applicable government and Nikah Registrar fee schedule.",

  estimatedTime:
      "Usually completed within one working day if all documents are available.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Verify Eligibility",
      description:
          "Ensure both parties fulfill the legal requirements for marriage.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Collect Documents",
      description:
          "Gather CNICs, photographs and witness information.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Arrange Authorized Nikah Registrar",
      description:
          "Contact an authorized Nikah Registrar to solemnize the marriage.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Perform Nikah",
      description:
          "The marriage is solemnized according to the applicable law.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Complete Nikah Nama",
      description:
          "The Nikah Registrar completes and signs the Nikah Nama.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Marriage Registration",
      description:
          "The Nikah Registrar submits the marriage for official registration.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Verification",
      description:
          "The competent authority verifies the registration.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Receive Registered Documents",
      description:
          "Obtain certified copies of the registered Nikah Nama.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Nikah Nama Correction
//-----------------------------------------------------------

ProcedureModel(
  id: "nikah_nama_correction",

  categoryId: "family",

  title: "Nikah Nama Correction",

  overview:
      "Nikah Nama Correction is the legal process of correcting clerical, typographical, or factual errors in a registered Nikah Nama. Corrections are made by the competent authority after verification of the relevant record and supporting documents in accordance with the applicable law.",

  governmentDepartment:
      "Union Council / Cantonment Board / Authorized Nikah Registrar",

  eligibility:
      "Either spouse or a person legally authorized on their behalf may apply for correction of errors in a registered Nikah Nama where permitted by law.",

  requiredDocuments: [
    "Original CNIC of Applicant",
    "Original or Certified Copy of Nikah Nama",
    "CNIC of Both Spouses",
    "Supporting Documentary Evidence",
    "Application for Correction",
    "Passport-size Photographs (where required)",
  ],

  applicableLaws: [
    "Muslim Family Laws Ordinance, 1961",
    "West Pakistan Muslim Family Rules, 1961",
    "Relevant Local Government Rules",
  ],

  importantNotes: [
    "Only genuine errors should be corrected.",
    "Supporting evidence must accompany the application.",
    "Some corrections may require verification by the Nikah Registrar.",
    "Keep certified copies after correction.",
  ],

  commonMistakes: [
    "Submitting incomplete documents.",
    "Incorrect CNIC information.",
    "Failure to provide supporting evidence.",
    "Applying before the wrong authority.",
  ],

  estimatedFee:
      "According to the applicable local government fee schedule.",

  estimatedTime:
      "Usually completed within 7–30 working days depending upon verification.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Identify the Error",
      description:
          "Review the Nikah Nama and identify the information requiring correction.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Collect Supporting Documents",
      description:
          "Gather CNICs and documentary proof supporting the requested correction.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Prepare Application",
      description:
          "Complete the prescribed correction application.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Submit Application",
      description:
          "Submit the application before the competent authority.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Verification",
      description:
          "The authority verifies the original marriage record and supporting documents.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Approval",
      description:
          "If the correction is justified, the competent authority approves the request.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Update Record",
      description:
          "The official marriage record is corrected.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Receive Corrected Nikah Nama",
      description:
          "Collect the corrected and certified Nikah Nama.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Birth Registration
//-----------------------------------------------------------

ProcedureModel(
  id: "birth_registration",

  categoryId: "family",

  title: "Birth Registration",

  overview:
      "Birth Registration is the legal process of recording the birth of a child with the competent local authority. Upon successful registration, an official Birth Certificate is issued, serving as legal proof of the child's identity, age, parentage, and place of birth.",

  governmentDepartment:
      "Union Council / Cantonment Board / Local Government Authority",

  eligibility:
      "The parents, legal guardian, or any person authorized by law may apply for registration of a child's birth within the prescribed time under the applicable law.",

  requiredDocuments: [
    "Original CNIC of Parent or Guardian",
    "Hospital Birth Certificate (if available)",
    "Child's B-Form (if already issued, where applicable)",
    "Nikah Nama of Parents (where applicable)",
    "Proof of Residence",
    "Application Form",
  ],

  applicableLaws: [
    "Local Government Act (Relevant Province)",
    "Births, Deaths and Marriages Registration Laws",
    "NADRA Rules (where applicable)",
  ],

  importantNotes: [
    "Birth should be registered as early as possible.",
    "Ensure all personal information is accurate.",
    "Keep multiple certified copies of the Birth Certificate.",
    "Late registration may require additional verification or documentation.",
  ],

  commonMistakes: [
    "Incorrect spelling of names.",
    "Wrong date of birth.",
    "Incomplete parent information.",
    "Delay in registration.",
  ],

  estimatedFee:
      "According to the applicable local government fee schedule.",

  estimatedTime:
      "Usually completed within 1–15 working days.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Collect Required Documents",
      description:
          "Gather the hospital birth record and parents' identification documents.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Complete Application",
      description:
          "Fill out the prescribed birth registration application form.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Submit Application",
      description:
          "Submit the application to the concerned Union Council or competent authority.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Verification",
      description:
          "The authority verifies the information and supporting documents.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Record Entry",
      description:
          "The child's birth is entered into the official birth register.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Approval",
      description:
          "The competent authority approves the registration.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Issue Birth Certificate",
      description:
          "The official Birth Certificate is issued.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Preserve Certificate",
      description:
          "Keep certified copies of the Birth Certificate for future legal and administrative use.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Death Registration
//-----------------------------------------------------------

ProcedureModel(
  id: "death_registration",

  categoryId: "family",

  title: "Death Registration",

  overview:
      "Death Registration is the legal process of recording the death of a person with the competent local authority. After successful registration, an official Death Certificate is issued, which serves as legal proof of death for inheritance, succession, insurance, pension, banking, and other legal purposes.",

  governmentDepartment:
      "Union Council / Cantonment Board / Local Government Authority",

  eligibility:
      "A legal heir, close family member, guardian, or any person authorized by law may apply for registration of a person's death.",

  requiredDocuments: [
    "Original CNIC of Applicant",
    "CNIC of the Deceased (if available)",
    "Medical Death Certificate",
    "Hospital Death Report (if applicable)",
    "Proof of Residence",
    "Application Form",
  ],

  applicableLaws: [
    "Local Government Act (Relevant Province)",
    "Births, Deaths and Marriages Registration Laws",
    "NADRA Rules (where applicable)",
  ],

  importantNotes: [
    "Register the death as soon as possible.",
    "Ensure all information matches official records.",
    "Keep several certified copies of the Death Certificate.",
    "The certificate is required for inheritance, succession, banking and pension matters.",
  ],

  commonMistakes: [
    "Incorrect CNIC details.",
    "Incorrect date of death.",
    "Failure to attach the medical death certificate.",
    "Delay in registration.",
  ],

  estimatedFee:
      "According to the applicable local government fee schedule.",

  estimatedTime:
      "Usually completed within 1–15 working days.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Collect Required Documents",
      description:
          "Gather the medical death certificate and identification documents.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Complete Application",
      description:
          "Fill out the prescribed death registration application.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Submit Application",
      description:
          "Submit the application before the concerned Union Council or competent authority.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Verification",
      description:
          "The authority verifies the documents and death record.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Record Entry",
      description:
          "The death is entered into the official government register.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Approval",
      description:
          "The competent authority approves the registration.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Issue Death Certificate",
      description:
          "The official Death Certificate is issued.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Preserve Certificate",
      description:
          "Keep certified copies for inheritance, succession and other legal purposes.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Family Registration Certificate (FRC)
//-----------------------------------------------------------

ProcedureModel(
  id: "family_registration_certificate",

  categoryId: "family",

  title: "Family Registration Certificate (FRC)",

  overview:
      "A Family Registration Certificate (FRC) is an official document issued by NADRA that provides details of a person's registered family members based on the National Identity Database. It is commonly required for visa applications, inheritance matters, succession proceedings, immigration, educational purposes, banking requirements, and other legal or administrative processes.",

  governmentDepartment:
      "National Database and Registration Authority (NADRA)",

  eligibility:
      "Any Pakistani citizen having a valid Computerized National Identity Card (CNIC) or National Identity Card for Overseas Pakistanis (NICOP) may apply for a Family Registration Certificate relating to his or her registered family record.",

  requiredDocuments: [
    "Original CNIC / NICOP of Applicant",
    "Biometric Verification (where applicable)",
    "Supporting Family Information (if required)",
    "Application Form (where applicable)",
  ],

  applicableLaws: [
    "National Database and Registration Authority Ordinance, 2000",
    "Relevant NADRA Rules and Regulations",
  ],

  importantNotes: [
    "The FRC is generated from NADRA's existing family database.",
    "Review all family information carefully before using the certificate.",
    "Incorrect NADRA records should be corrected before requesting an FRC.",
    "Different FRC categories may apply depending on the relationship claimed.",
  ],

  commonMistakes: [
    "Assuming the FRC creates legal family rights.",
    "Using outdated CNIC information.",
    "Ignoring incorrect family records in NADRA.",
    "Submitting incomplete identity information.",
  ],

  estimatedFee:
      "According to the latest NADRA fee schedule.",

  estimatedTime:
      "Usually issued on the same day or within a few working days depending on the service selected.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Verify Identity",
      description:
          "Ensure your CNIC or NICOP information is accurate and up to date.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Visit NADRA or Apply Online",
      description:
          "Submit the request through the appropriate NADRA service channel.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Biometric Verification",
      description:
          "Complete biometric verification where required.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Review Family Record",
      description:
          "Verify the family members appearing in the NADRA database.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Pay Applicable Fee",
      description:
          "Pay the prescribed government fee for the selected service.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Processing",
      description:
          "NADRA processes the request and verifies the information.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Issue FRC",
      description:
          "The Family Registration Certificate is generated and issued.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Use Certificate",
      description:
          "Use the FRC wherever official proof of registered family information is required.",
    ),
  ],
),

];