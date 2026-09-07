import '../models/procedure_model.dart';
import '../models/procedure_step.dart';

final List<ProcedureModel> labourProcedures = [

  //-----------------------------------------------------------
// Procedure: Employment Contract
//-----------------------------------------------------------

ProcedureModel(
  id: "employment_contract",

  categoryId: "labour",

  title: "Employment Contract",

  overview:
      "An Employment Contract is a legally binding agreement between an employer and an employee that sets out the terms and conditions of employment, including duties, salary, working hours, leave, benefits, probation, termination, confidentiality, and other rights and obligations. A written employment contract helps prevent disputes and ensures clarity regarding the employment relationship.",

  governmentDepartment:
      "Employer / Human Resources Department / Labour Department (where applicable)",

  eligibility:
      "Any employer and employee entering into a lawful employment relationship may execute an employment contract in accordance with applicable labour laws.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC of Employee",
    "Employee Photographs (where required)",
    "Educational or Professional Certificates (where applicable)",
    "Employment Offer Letter (if issued)",
    "Employer Identification Documents (where applicable)",
    "Any additional documents required by the employer",
  ],

  applicableLaws: [
    "Industrial Relations Act",
    "Provincial Labour Laws",
    "Minimum Wages Legislation",
    "Applicable Employment Regulations",
  ],

  importantNotes: [
    "Read all contract terms before signing.",
    "Ensure salary, working hours, leave, and benefits are clearly stated.",
    "Both parties should retain signed copies of the contract.",
    "Any amendments should be made in writing and agreed upon by both parties.",
  ],

  commonMistakes: [
    "Signing without reading the contract.",
    "Accepting unclear employment terms.",
    "Not obtaining a signed copy.",
    "Ignoring probation or termination clauses.",
  ],

  estimatedFee:
      "Generally no government fee. Drafting or legal consultation charges may apply if professional assistance is obtained.",

  estimatedTime:
      "Usually completed immediately after both parties agree to the employment terms.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Negotiate Employment Terms",
      description:
          "Employer and employee agree on salary, duties, working hours, benefits, leave, and other employment conditions.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Prepare Employment Contract",
      description:
          "Draft the employment contract containing all agreed terms and conditions.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Review the Contract",
      description:
          "Both parties carefully review the contract before signing.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Provide Required Documents",
      description:
          "Submit identity and employment-related documents required by the employer.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Execute the Contract",
      description:
          "Both employer and employee sign the employment contract.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Employer Record",
      description:
          "The employer maintains the executed contract in the employee's record.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Employee Copy",
      description:
          "Provide a signed copy of the employment contract to the employee.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Commencement of Employment",
      description:
          "Employment begins according to the agreed commencement date and contractual terms.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Salary Dispute
//-----------------------------------------------------------

ProcedureModel(
  id: "salary_dispute",

  categoryId: "labour",

  title: "Salary Dispute",

  overview:
      "A Salary Dispute arises when an employee claims that salary, wages, allowances, bonuses, incentives, or other employment-related payments have not been paid correctly, have been unlawfully deducted, or have been delayed by the employer. Such disputes may be resolved through internal grievance procedures, labour authorities, conciliation, or the competent Labour Court in accordance with applicable labour laws.",

  governmentDepartment:
      "Employer / Labour Department / Labour Court (where applicable)",

  eligibility:
      "Any employee or worker claiming unpaid salary, unlawful deductions, delayed wages, or other salary-related disputes may seek relief through the applicable legal procedure.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC",
    "Employment Contract or Appointment Letter",
    "Salary Slips (if available)",
    "Bank Statements or Payment Records",
    "Attendance Record (where applicable)",
    "Employer Correspondence",
    "Written Complaint or Application",
    "Supporting Documents or Evidence",
  ],

  applicableLaws: [
    "Provincial Labour Laws",
    "Industrial Relations Act",
    "Payment of Wages Legislation",
    "Applicable Employment Regulations",
  ],

  importantNotes: [
    "Maintain copies of salary slips and payment records.",
    "Attempt to resolve the dispute with the employer before initiating formal proceedings where appropriate.",
    "Submit accurate calculations of the claimed amount.",
    "Keep copies of all correspondence and evidence.",
  ],

  commonMistakes: [
    "Failing to preserve salary records.",
    "Submitting unsupported financial claims.",
    "Ignoring applicable limitation periods.",
    "Not maintaining written communication with the employer.",
  ],

  estimatedFee:
      "Internal complaints are generally free. Court or legal representation expenses may apply where proceedings are initiated.",

  estimatedTime:
      "Depends upon negotiations, departmental proceedings, conciliation, or adjudication by the competent authority.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Collect Employment Records",
      description:
          "Gather employment contracts, salary slips, attendance records, bank statements, and other supporting documents.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Calculate Outstanding Amount",
      description:
          "Prepare an accurate calculation of unpaid salary, deductions, or other disputed payments.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Raise the Matter with the Employer",
      description:
          "Request payment or clarification through the employer's grievance or human resources process where available.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Submit Formal Complaint",
      description:
          "If the dispute remains unresolved, submit a complaint before the appropriate labour authority or other competent forum.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Verification Process",
      description:
          "The authority examines employment records, payment history, and supporting evidence.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Hearing or Conciliation",
      description:
          "The parties may participate in conciliation proceedings or hearings as required.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Decision",
      description:
          "The competent authority or Labour Court issues its decision according to the applicable law and evidence.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Compliance",
      description:
          "The parties comply with the final order, settlement, or judgment in accordance with the applicable legal procedure.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Wrongful Termination
//-----------------------------------------------------------

ProcedureModel(
  id: "wrongful_termination",

  categoryId: "labour",

  title: "Wrongful Termination",

  overview:
      "Wrongful Termination is the legal process through which an employee challenges an unlawful dismissal, termination, removal, or discharge from employment. An employee who believes that termination was carried out in violation of the employment contract or applicable labour laws may seek reinstatement, compensation, unpaid wages, benefits, or other lawful remedies through the appropriate authority or Labour Court.",

  governmentDepartment:
      "Employer / Labour Department / Labour Court",

  eligibility:
      "Any employee who believes that their employment has been unlawfully terminated or dismissed in violation of applicable labour laws or contractual terms may initiate the appropriate legal procedure.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC",
    "Employment Contract or Appointment Letter",
    "Termination Letter or Notice (if available)",
    "Salary Slips",
    "Attendance Records",
    "Employer Correspondence",
    "Written Complaint or Application",
    "Supporting Documents or Evidence",
  ],

  applicableLaws: [
    "Provincial Labour Laws",
    "Industrial Relations Act",
    "Standing Orders Legislation",
    "Applicable Employment Regulations",
  ],

  importantNotes: [
    "Preserve all employment and termination records.",
    "Review the employment contract before initiating legal proceedings.",
    "Observe applicable limitation periods for filing claims.",
    "Maintain copies of all correspondence and evidence.",
  ],

  commonMistakes: [
    "Discarding employment records.",
    "Failing to obtain a copy of the termination notice.",
    "Waiting too long before filing a complaint.",
    "Submitting incomplete supporting evidence.",
  ],

  estimatedFee:
      "Employer grievance procedures are generally free. Court fees or legal representation costs may apply where legal proceedings are initiated.",

  estimatedTime:
      "Depends upon internal grievance procedures, conciliation, and adjudication before the competent authority or Labour Court.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Review Termination",
      description:
          "Review the termination letter, employment contract, and circumstances surrounding the dismissal.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Collect Evidence",
      description:
          "Gather employment records, salary slips, attendance records, correspondence, and other supporting documents.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Raise the Matter with Employer",
      description:
          "Request clarification or reconsideration through the employer's grievance procedure where available.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Submit Formal Complaint",
      description:
          "If the dispute remains unresolved, file a complaint before the appropriate labour authority or Labour Court.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Verification",
      description:
          "The competent authority reviews employment records, termination documents, and other evidence.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Hearing or Conciliation",
      description:
          "The parties participate in hearings or conciliation proceedings as required.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Decision",
      description:
          "The competent authority or Labour Court issues its decision according to the applicable law and evidence.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Implementation",
      description:
          "The parties comply with the final order, settlement, or judgment, including reinstatement, compensation, or other lawful relief where ordered.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Resignation Procedure
//-----------------------------------------------------------

ProcedureModel(
  id: "resignation_procedure",

  categoryId: "labour",

  title: "Resignation Procedure",

  overview:
      "A Resignation Procedure is the formal process through which an employee voluntarily terminates the employment relationship by giving notice to the employer in accordance with the employment contract and applicable labour laws. The process includes submission of a resignation, completion of notice period requirements where applicable, settlement of dues, and issuance of employment-related documents.",

  governmentDepartment:
      "Employer / Human Resources Department",

  eligibility:
      "Any employee wishing to voluntarily leave employment may resign in accordance with the terms of the employment contract and applicable labour laws.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC",
    "Written Resignation Letter",
    "Employment Contract or Appointment Letter",
    "Employee Identification Card (where applicable)",
    "Company Property Return Checklist (where applicable)",
    "Clearance Form (if required)",
  ],

  applicableLaws: [
    "Provincial Labour Laws",
    "Industrial Relations Act",
    "Standing Orders Legislation",
    "Applicable Employment Regulations",
    "Employment Contract",
  ],

  importantNotes: [
    "Review the notice period specified in the employment contract.",
    "Submit the resignation in writing and retain a copy.",
    "Return all company property before leaving employment.",
    "Ensure settlement of salary, leave encashment, and other employment benefits.",
  ],

  commonMistakes: [
    "Leaving employment without serving the required notice period.",
    "Failing to submit a written resignation.",
    "Not obtaining resignation acceptance or clearance records.",
    "Failing to return company property.",
  ],

  estimatedFee:
      "No government fee is applicable.",

  estimatedTime:
      "Depends upon the contractual notice period and completion of employer clearance procedures.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Review Employment Contract",
      description:
          "Review the notice period, resignation requirements, and other contractual obligations.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Prepare Resignation Letter",
      description:
          "Prepare and sign a written resignation stating the intended last working day.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Submit Resignation",
      description:
          "Submit the resignation letter to the employer or Human Resources Department.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Serve Notice Period",
      description:
          "Complete the contractual or legally required notice period unless waived by the employer.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Complete Handover",
      description:
          "Transfer work responsibilities and hand over official records, files, and company assets.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Clearance Process",
      description:
          "Complete departmental clearance and return all company property where required.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Settlement of Dues",
      description:
          "Receive final salary, benefits, leave encashment, and other lawful employment dues.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Receive Employment Documents",
      description:
          "Obtain the experience certificate, relieving letter, and any other employment-related documents where applicable.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Experience Certificate
//-----------------------------------------------------------

ProcedureModel(
  id: "experience_certificate",

  categoryId: "labour",

  title: "Experience Certificate",

  overview:
      "An Experience Certificate is an official document issued by an employer confirming an employee's period of service, job title, duties performed, and employment history. It is commonly required for future employment, immigration, higher education, professional licensing, or other official purposes.",

  governmentDepartment:
      "Employer / Human Resources Department",

  eligibility:
      "Any current or former employee who has worked with an employer may request an Experience Certificate in accordance with the employer's policies and applicable labour laws.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC",
    "Employee ID or Employment Number (where applicable)",
    "Written Application or Request",
    "Resignation Acceptance or Relieving Letter (where applicable)",
    "Departmental Clearance Certificate (if required)",
  ],

  applicableLaws: [
    "Provincial Labour Laws",
    "Industrial Relations Act",
    "Standing Orders Legislation",
    "Applicable Employment Regulations",
  ],

  importantNotes: [
    "Request the certificate after completing all clearance formalities where applicable.",
    "Verify that the certificate contains accurate employment details.",
    "Keep the original certificate in a safe place.",
    "Request corrections immediately if any information is inaccurate.",
  ],

  commonMistakes: [
    "Submitting an incomplete request.",
    "Requesting the certificate before completing the employer's clearance process.",
    "Failing to verify the accuracy of employment dates or designation.",
    "Misplacing the original certificate.",
  ],

  estimatedFee:
      "Generally no government fee. Most employers issue the certificate without charge, subject to company policy.",

  estimatedTime:
      "Usually issued within a few working days after verification and completion of clearance requirements.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Complete Employment Formalities",
      description:
          "Complete resignation, retirement, or other employment formalities and departmental clearance where required.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Prepare Written Request",
      description:
          "Submit a written request to the Human Resources Department or the authorized employer representative.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Submit Supporting Documents",
      description:
          "Provide identification and any documents required by the employer.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Employer Verification",
      description:
          "The employer verifies the employee's service record and employment details.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Preparation of Certificate",
      description:
          "The employer prepares the Experience Certificate containing the employee's service information.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Review Certificate",
      description:
          "Review the certificate to ensure all information is accurate.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Collection",
      description:
          "Collect the signed Experience Certificate from the employer or receive it through an authorized delivery method.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Preserve the Certificate",
      description:
          "Keep the original certificate securely for future employment and official use.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Minimum Wage Complaint
//-----------------------------------------------------------

ProcedureModel(
  id: "minimum_wage_complaint",

  categoryId: "labour",

  title: "Minimum Wage Complaint",

  overview:
      "A Minimum Wage Complaint is the process through which a worker reports that an employer has paid wages below the minimum wage prescribed under the applicable law. An eligible worker may seek payment of the wage difference, recovery of unpaid amounts, and other remedies through the appropriate labour authority or Labour Court.",

  governmentDepartment:
      "Labour Department / Labour Court",

  eligibility:
      "Any worker or employee receiving wages below the legally prescribed minimum wage may submit a complaint in accordance with the applicable labour laws.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC",
    "Employment Contract or Appointment Letter (if available)",
    "Salary Slips or Wage Records",
    "Bank Statements or Payment Evidence",
    "Attendance Records (where available)",
    "Written Complaint or Application",
    "Supporting Documents or Evidence",
  ],

  applicableLaws: [
    "Minimum Wages Legislation",
    "Provincial Labour Laws",
    "Industrial Relations Act",
    "Applicable Employment Regulations",
  ],

  importantNotes: [
    "Preserve salary records and payment evidence.",
    "Verify the applicable minimum wage before filing a complaint.",
    "Maintain copies of all complaint documents.",
    "Submit accurate details regarding wages and employment.",
  ],

  commonMistakes: [
    "Failing to maintain salary records.",
    "Claiming incorrect wage calculations.",
    "Submitting incomplete supporting documents.",
    "Delaying the complaint unnecessarily.",
  ],

  estimatedFee:
      "Generally no government fee for submitting the complaint. Legal representation expenses may apply if required.",

  estimatedTime:
      "Depends upon investigation, conciliation proceedings, and adjudication by the competent authority.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Verify Applicable Minimum Wage",
      description:
          "Confirm the legally prescribed minimum wage applicable to your employment.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Collect Employment Records",
      description:
          "Gather salary slips, attendance records, bank statements, and employment documents.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Calculate Wage Difference",
      description:
          "Calculate the difference between the wages received and the applicable minimum wage.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Submit Complaint",
      description:
          "File a written complaint before the appropriate Labour Department or other competent authority.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Verification",
      description:
          "The authority verifies employment records, wage payments, and supporting evidence.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Hearing or Conciliation",
      description:
          "The parties may participate in conciliation proceedings or hearings as required.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Decision",
      description:
          "The competent authority issues its decision according to the applicable law and evidence.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Compliance",
      description:
          "The employer complies with the final order regarding payment of wages or other lawful relief.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Overtime Wage Claim
//-----------------------------------------------------------

ProcedureModel(
  id: "overtime_wage_claim",

  categoryId: "labour",

  title: "Overtime Wage Claim",

  overview:
      "An Overtime Wage Claim is the process through which an employee or worker seeks payment for overtime work performed beyond the normal working hours in accordance with applicable labour laws, employment contracts, collective bargaining agreements, or company policies. If overtime wages remain unpaid, the worker may pursue relief through the Labour Department or the competent Labour Court.",

  governmentDepartment:
      "Labour Department / Labour Court",

  eligibility:
      "Any employee or worker who has performed authorized overtime work but has not received the overtime wages or benefits due under the applicable law or employment contract may file a claim.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC",
    "Employment Contract or Appointment Letter",
    "Attendance Records",
    "Duty Roster or Shift Schedule",
    "Salary Slips",
    "Bank Statements or Payment Records",
    "Employer Correspondence",
    "Written Complaint or Application",
    "Supporting Evidence",
  ],

  applicableLaws: [
    "Provincial Labour Laws",
    "Factories Act",
    "Shops and Establishments Laws",
    "Industrial Relations Act",
    "Applicable Employment Regulations",
  ],

  importantNotes: [
    "Maintain accurate attendance and overtime records.",
    "Keep copies of salary slips and payment records.",
    "Calculate overtime according to the applicable law or employment contract.",
    "Retain all written communication with the employer.",
  ],

  commonMistakes: [
    "Failing to preserve attendance records.",
    "Submitting incorrect overtime calculations.",
    "Ignoring limitation periods.",
    "Providing insufficient supporting evidence.",
  ],

  estimatedFee:
      "Generally no government fee for filing the claim. Legal representation costs may apply if required.",

  estimatedTime:
      "Depends upon investigation, conciliation, and adjudication by the competent authority.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Collect Employment Records",
      description:
          "Gather attendance records, overtime registers, salary slips, bank statements, and employment documents.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Calculate Overtime",
      description:
          "Calculate the overtime wages payable according to the applicable law or employment agreement.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Raise the Matter with Employer",
      description:
          "Request payment through the employer's grievance process where available.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Submit Complaint",
      description:
          "If unresolved, file a complaint before the Labour Department or the competent authority.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Verification",
      description:
          "The authority verifies attendance records, wage payments, and supporting evidence.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Hearing or Conciliation",
      description:
          "The parties participate in hearings or conciliation proceedings as required.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Decision",
      description:
          "The competent authority issues its decision based on the applicable law and evidence.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Payment of Overtime",
      description:
          "The employer complies with the final order by paying overtime wages or other lawful relief, where directed.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Workplace Harassment Complaint
//-----------------------------------------------------------

ProcedureModel(
  id: "workplace_harassment_complaint",

  categoryId: "labour",

  title: "Workplace Harassment Complaint",

  overview:
      "A Workplace Harassment Complaint is the process through which an employee reports harassment, discrimination, bullying, intimidation, retaliation, or sexual harassment occurring in the workplace. Complaints should ordinarily be submitted through the employer's internal complaint mechanism where available, and may be pursued before the competent authority in accordance with applicable labour laws.",

  governmentDepartment:
      "Employer's Inquiry Committee / Labour Department / Competent Authority",

  eligibility:
      "Any employee or worker who has experienced workplace harassment or unlawful discriminatory conduct may submit a complaint in accordance with the applicable law.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC",
    "Employment Contract or Appointment Letter",
    "Written Complaint",
    "Details of the Incident(s)",
    "Names of Witnesses (if any)",
    "Supporting Documents or Evidence",
    "Electronic Communications or Messages (if applicable)",
  ],

  applicableLaws: [
    "Protection Against Harassment of Women at the Workplace Act, 2010 (as amended, where applicable)",
    "Provincial Labour Laws",
    "Industrial Relations Act",
    "Employer's Workplace Harassment Policy",
  ],

  importantNotes: [
    "Report the incident as soon as reasonably possible.",
    "Preserve all available evidence and communications.",
    "Maintain confidentiality during the complaint process.",
    "Cooperate with the inquiry proceedings.",
  ],

  commonMistakes: [
    "Delaying the submission of the complaint.",
    "Deleting messages or other electronic evidence.",
    "Failing to identify available witnesses.",
    "Providing incomplete factual information.",
  ],

  estimatedFee:
      "Generally no government fee is charged for submitting the complaint.",

  estimatedTime:
      "Depends upon the inquiry process, investigation, and applicable legal proceedings.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Record the Incident",
      description:
          "Document the relevant facts, dates, locations, persons involved, and preserve available evidence.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Prepare Written Complaint",
      description:
          "Prepare a clear written complaint describing the incidents and the relief sought.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Submit Complaint",
      description:
          "Submit the complaint to the employer's designated authority or other competent forum in accordance with the applicable procedure.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Acknowledgement",
      description:
          "Obtain acknowledgement or a complaint reference for future follow-up.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Inquiry or Investigation",
      description:
          "The competent authority conducts an inquiry, records statements, and reviews the evidence.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Hearing",
      description:
          "The concerned parties may be given an opportunity to present their respective cases.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Decision",
      description:
          "The competent authority issues its findings and any appropriate recommendations or orders in accordance with the applicable law.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Implementation",
      description:
          "The employer or competent authority implements the final decision or any corrective measures required.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: EOBI Registration
//-----------------------------------------------------------

ProcedureModel(
  id: "eobi_registration",

  categoryId: "labour",

  title: "EOBI Registration",

  overview:
      "EOBI Registration is the process through which eligible employees and employers are registered under the Employees' Old-Age Benefits Institution (EOBI). Registration enables eligible workers to receive old-age pension, survivor's pension, invalidity pension, old-age grant, and other benefits in accordance with the applicable law.",

  governmentDepartment:
      "Employees' Old-Age Benefits Institution (EOBI)",

  eligibility:
      "Employers and employees who fall within the scope of the applicable EOBI laws and regulations are required or entitled to register, subject to eligibility criteria prescribed by law.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC",
    "Employer Registration Documents",
    "Employment Records",
    "Appointment Letter or Employment Contract",
    "Salary Records",
    "Business Registration Documents (where applicable)",
    "Any forms or supporting documents required by EOBI",
  ],

  applicableLaws: [
    "Employees' Old-Age Benefits Act, 1976",
    "Employees' Old-Age Benefits Institution Rules",
    "Applicable Labour Laws",
  ],

  importantNotes: [
    "Ensure registration is completed promptly where legally required.",
    "Maintain accurate employment and contribution records.",
    "Keep copies of all submitted documents.",
    "Notify EOBI of any required changes in employment information.",
  ],

  commonMistakes: [
    "Delaying mandatory registration.",
    "Providing inaccurate employee information.",
    "Failing to maintain contribution records.",
    "Submitting incomplete documentation.",
  ],

  estimatedFee:
      "Registration is generally subject to the applicable statutory contribution requirements rather than a registration fee.",

  estimatedTime:
      "Depends upon verification of documents and completion of the registration process by EOBI.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Confirm Eligibility",
      description:
          "Determine whether the employer and employee are covered under the applicable EOBI law.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Collect Required Documents",
      description:
          "Gather employment records, employer registration documents, and employee identification documents.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Complete Registration Forms",
      description:
          "Fill in the prescribed registration forms accurately and completely.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Submit Application",
      description:
          "Submit the registration application together with all supporting documents to the appropriate EOBI office or authorized channel.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Verification",
      description:
          "EOBI verifies the submitted information and supporting documents.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Employer Registration",
      description:
          "Where applicable, the employer is registered under the EOBI system.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Employee Registration",
      description:
          "Eligible employees are enrolled under the employer's EOBI registration.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Maintain Compliance",
      description:
          "Continue submitting contributions and maintaining employment records in accordance with the applicable law.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Social Security Registration
//-----------------------------------------------------------

ProcedureModel(
  id: "social_security_registration",

  categoryId: "labour",

  title: "Social Security Registration",

  overview:
      "Social Security Registration is the process through which eligible employers and employees are registered under the applicable Provincial Employees' Social Security Institution to enable workers to receive statutory social security benefits, including medical care, employment injury benefits, maternity benefits, disability benefits, and other benefits provided under the applicable law.",

  governmentDepartment:
      "Provincial Employees' Social Security Institution",

  eligibility:
      "Employers and employees covered under the applicable Provincial Employees' Social Security laws are required or entitled to register in accordance with the prescribed eligibility criteria.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC",
    "Employer Registration Documents",
    "Employment Records",
    "Appointment Letter or Employment Contract",
    "Salary Records",
    "Business Registration Documents (where applicable)",
    "Prescribed Registration Forms",
    "Supporting Documents required by the Social Security Institution",
  ],

  applicableLaws: [
    "Provincial Employees' Social Security Ordinance / Act",
    "Applicable Provincial Social Security Rules",
    "Provincial Labour Laws",
  ],

  importantNotes: [
    "Complete registration promptly where legally required.",
    "Maintain accurate employee and contribution records.",
    "Report changes in employment information without unnecessary delay.",
    "Retain copies of all submitted documents and acknowledgements.",
  ],

  commonMistakes: [
    "Failing to register eligible employees.",
    "Submitting incomplete documentation.",
    "Providing inaccurate employee information.",
    "Failing to maintain contribution records.",
  ],

  estimatedFee:
      "Registration is generally subject to statutory contribution requirements rather than a registration fee.",

  estimatedTime:
      "Depends upon verification of documents and completion of the registration process by the Provincial Social Security Institution.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Confirm Eligibility",
      description:
          "Determine whether the employer and employees fall within the scope of the applicable social security law.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Collect Required Documents",
      description:
          "Gather employer registration documents, employee records, and supporting documents.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Complete Registration Forms",
      description:
          "Fill in the prescribed registration forms accurately and completely.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Submit Registration",
      description:
          "Submit the application along with the required documents to the competent Provincial Social Security Institution.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Verification",
      description:
          "The authority verifies the submitted information and supporting documents.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Employer Enrollment",
      description:
          "The employer is registered under the applicable social security system where required.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Employee Enrollment",
      description:
          "Eligible employees are enrolled and become entitled to applicable social security benefits subject to the law.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Ongoing Compliance",
      description:
          "Continue maintaining records and making statutory contributions in accordance with the applicable legal requirements.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Labour Court Complaint
//-----------------------------------------------------------

ProcedureModel(
  id: "labour_court_complaint",

  categoryId: "labour",

  title: "Labour Court Complaint",

  overview:
      "A Labour Court Complaint is the legal process through which an employee, worker, employer, or other eligible party seeks adjudication of a labour-related dispute before the competent Labour Court. Matters may include wrongful termination, unpaid wages, service benefits, disciplinary actions, industrial disputes, employment rights, and other issues arising under applicable labour laws.",

  governmentDepartment:
      "Labour Court / Labour Department",

  eligibility:
      "Any person entitled under the applicable labour laws to seek relief before the competent Labour Court may file a complaint or application in accordance with the prescribed legal procedure.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC",
    "Employment Contract or Appointment Letter",
    "Termination Letter (if applicable)",
    "Salary Slips or Wage Records",
    "Written Complaint or Claim",
    "Supporting Documents",
    "Witness Information (if available)",
    "Any other documents required by the Labour Court",
  ],

  applicableLaws: [
    "Industrial Relations Act",
    "Provincial Labour Laws",
    "Standing Orders Legislation",
    "Applicable Labour Court Rules",
  ],

  importantNotes: [
    "File the complaint within the applicable limitation period.",
    "Preserve all employment records and evidence.",
    "Clearly specify the relief sought.",
    "Attend all hearings as directed by the Court.",
  ],

  commonMistakes: [
    "Submitting incomplete documents.",
    "Missing limitation periods.",
    "Failing to preserve employment records.",
    "Ignoring Court notices.",
  ],

  estimatedFee:
      "Court fee or other charges may apply according to the applicable law and court rules.",

  estimatedTime:
      "Depends upon the complexity of the dispute, evidence, and Labour Court proceedings.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Prepare the Claim",
      description:
          "Prepare the complaint clearly stating the facts, legal grounds, and relief sought.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Collect Supporting Evidence",
      description:
          "Gather employment records, correspondence, salary documents, and other supporting evidence.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "File Before Labour Court",
      description:
          "Submit the complaint before the competent Labour Court together with all required documents.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Court Scrutiny",
      description:
          "The Court examines the complaint for compliance with the applicable legal requirements.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Notice to Respondent",
      description:
          "The Court issues notice to the employer or other respondent to submit a reply.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Hearings & Evidence",
      description:
          "The parties present evidence, witnesses, and legal submissions before the Court.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Judgment",
      description:
          "The Labour Court decides the dispute according to the applicable law and evidence.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Execution of Order",
      description:
          "The parties comply with or enforce the Labour Court's final order in accordance with the law.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Workers Compensation Claim
//-----------------------------------------------------------

ProcedureModel(
  id: "workers_compensation_claim",

  categoryId: "labour",

  title: "Workers Compensation Claim",

  overview:
      "A Workers Compensation Claim is the legal process through which an employee or the employee's legal heirs seek compensation for an employment-related injury, occupational disease, permanent disability, temporary disability, or death arising out of and in the course of employment. Claims are processed in accordance with the applicable labour laws before the competent authority or Labour Court where required.",

  governmentDepartment:
      "Labour Department / Labour Court / Competent Authority",

  eligibility:
      "Any eligible employee, worker, or lawful dependent who has suffered a work-related injury, occupational illness, disability, or death may submit a claim in accordance with the applicable labour laws.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC",
    "Employment Contract or Appointment Letter",
    "Medical Reports and Treatment Records",
    "Accident or Incident Report",
    "Hospital Documents",
    "Salary or Wage Records",
    "Employer's Report (if available)",
    "Death Certificate (where applicable)",
    "Legal Heir Documents (where applicable)",
    "Supporting Documents or Evidence",
  ],

  applicableLaws: [
    "Employees' Compensation Act, 1923 (or other applicable compensation law)",
    "Provincial Labour Laws",
    "Industrial Relations Act",
    "Applicable Labour Court Rules",
  ],

  importantNotes: [
    "Report workplace accidents immediately.",
    "Preserve all medical records and treatment documents.",
    "Keep copies of accident reports and employer correspondence.",
    "Submit the claim within the applicable legal limitation period.",
  ],

  commonMistakes: [
    "Delaying the reporting of workplace accidents.",
    "Failing to obtain medical documentation.",
    "Submitting incomplete evidence.",
    "Ignoring legal deadlines for filing the claim.",
  ],

  estimatedFee:
      "Government filing requirements depend upon the applicable law. Legal representation expenses may apply where required.",

  estimatedTime:
      "Depends upon medical evidence, investigation, hearings, and adjudication by the competent authority.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Report the Incident",
      description:
          "Immediately report the workplace accident or occupational injury to the employer.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Obtain Medical Treatment",
      description:
          "Seek medical treatment and obtain all relevant medical reports and certificates.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Collect Supporting Documents",
      description:
          "Gather employment records, accident reports, salary documents, medical evidence, and other supporting documents.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Prepare Compensation Claim",
      description:
          "Prepare the compensation claim describing the accident, injury, and relief sought.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Submit Claim",
      description:
          "File the claim before the competent authority or Labour Court together with all supporting documents.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Investigation & Hearings",
      description:
          "The authority investigates the matter and conducts hearings where necessary.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Decision",
      description:
          "The competent authority determines entitlement to compensation in accordance with the applicable law.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Payment of Compensation",
      description:
          "Compensation is paid or otherwise enforced according to the final order or settlement.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Industrial Dispute
//-----------------------------------------------------------

ProcedureModel(
  id: "industrial_dispute",

  categoryId: "labour",

  title: "Industrial Dispute",

  overview:
      "An Industrial Dispute is the legal process through which disputes between employers, employees, workers, trade unions, or management concerning employment, working conditions, wages, benefits, service matters, or industrial relations are resolved through conciliation, arbitration, or adjudication under the applicable labour laws.",

  governmentDepartment:
      "Labour Department / Conciliation Officer / Labour Court / Industrial Relations Commission (where applicable)",

  eligibility:
      "Any employer, employee, worker, trade union, or other eligible party involved in an industrial dispute may seek resolution in accordance with the applicable labour laws.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC",
    "Employment Records",
    "Employment Contract or Appointment Letter",
    "Written Statement of Dispute",
    "Collective Bargaining Agreement (if applicable)",
    "Trade Union Documents (if applicable)",
    "Supporting Documents and Evidence",
    "Correspondence between the Parties",
  ],

  applicableLaws: [
    "Industrial Relations Act",
    "Provincial Industrial Relations Laws",
    "Provincial Labour Laws",
    "Applicable Labour Court Rules",
  ],

  importantNotes: [
    "Attempt settlement through negotiation or conciliation where available.",
    "Maintain complete employment and correspondence records.",
    "Clearly identify the issues in dispute.",
    "Attend all proceedings before the competent authority.",
  ],

  commonMistakes: [
    "Submitting incomplete dispute details.",
    "Ignoring conciliation proceedings.",
    "Failing to preserve documentary evidence.",
    "Missing legal deadlines.",
  ],

  estimatedFee:
      "Government fees depend upon the applicable legal procedure. Legal representation expenses may apply.",

  estimatedTime:
      "Depends upon conciliation, mediation, arbitration, or Labour Court proceedings.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Identify the Dispute",
      description:
          "Clearly identify the employment or industrial issue requiring resolution.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Collect Supporting Records",
      description:
          "Gather employment records, agreements, correspondence, and other relevant documents.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Attempt Conciliation",
      description:
          "Participate in conciliation or negotiation proceedings where required by law.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Submit Formal Dispute",
      description:
          "File the industrial dispute before the competent authority where settlement is not achieved.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Proceedings",
      description:
          "The competent authority conducts hearings, receives evidence, and hears the parties.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Evidence",
      description:
          "Both parties present documentary evidence, witnesses, and legal submissions.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Decision",
      description:
          "The competent authority issues its decision in accordance with the applicable law.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Implementation",
      description:
          "The parties comply with or enforce the final decision, award, or settlement.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Trade Union Registration
//-----------------------------------------------------------

ProcedureModel(
  id: "trade_union_registration",

  categoryId: "labour",

  title: "Trade Union Registration",

  overview:
      "Trade Union Registration is the legal process through which workers establish and register a trade union to represent their collective interests relating to employment, working conditions, wages, occupational safety, welfare, and industrial relations. Registration is carried out in accordance with the applicable industrial relations laws and enables the trade union to function as a recognized legal entity.",

  governmentDepartment:
      "Registrar of Trade Unions / Labour Department / Industrial Relations Commission (where applicable)",

  eligibility:
      "Workers who satisfy the legal requirements prescribed under the applicable industrial relations laws may establish and apply for registration of a trade union.",

  requiredDocuments: [
    "Application for Registration",
    "Original CNIC or Smart CNIC of Office Bearers",
    "Constitution or Bye-Laws of the Trade Union",
    "List of Members",
    "Minutes of the Founding Meeting",
    "Office Bearers' Details",
    "Employer Information",
    "Any additional documents required by the Registrar",
  ],

  applicableLaws: [
    "Industrial Relations Act",
    "Provincial Industrial Relations Laws",
    "Trade Union Registration Rules",
    "Applicable Labour Laws",
  ],

  importantNotes: [
    "Ensure compliance with the minimum membership requirements prescribed by law.",
    "Prepare a constitution that complies with the applicable legal requirements.",
    "Maintain accurate membership records.",
    "Submit complete and accurate documentation.",
  ],

  commonMistakes: [
    "Submitting incomplete membership records.",
    "Failing to comply with statutory registration requirements.",
    "Providing inaccurate information in the application.",
    "Ignoring requests for additional information from the Registrar.",
  ],

  estimatedFee:
      "Subject to the applicable government fee schedule, if any.",

  estimatedTime:
      "Depends upon verification of documents and approval by the Registrar of Trade Unions.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Organize Founding Members",
      description:
          "Ensure that the minimum number of eligible workers required by law agree to establish the trade union.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Adopt Constitution",
      description:
          "Prepare and adopt the trade union constitution or bye-laws in accordance with legal requirements.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Elect Office Bearers",
      description:
          "Elect the office bearers of the trade union as required by the constitution.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Prepare Registration Application",
      description:
          "Complete the prescribed registration forms and compile all supporting documents.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Submit Application",
      description:
          "Submit the application to the Registrar of Trade Unions or other competent authority.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Verification",
      description:
          "The authority verifies the membership, constitution, and supporting documents.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Registration Decision",
      description:
          "The Registrar approves or otherwise decides the registration application in accordance with the applicable law.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Receive Registration Certificate",
      description:
          "Upon approval, the trade union receives its registration certificate and may operate in accordance with the applicable law.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Child Labour Complaint
//-----------------------------------------------------------

ProcedureModel(
  id: "child_labour_complaint",

  categoryId: "labour",

  title: "Child Labour Complaint",

  overview:
      "A Child Labour Complaint is the legal process through which any person reports the unlawful employment, exploitation, hazardous work, forced labour, or other prohibited labour involving a child. The complaint enables the competent authorities to investigate the matter, rescue affected children where necessary, initiate legal proceedings against responsible persons, and ensure compliance with applicable child labour laws.",

  governmentDepartment:
      "Labour Department / Child Protection Authority / Police (where applicable)",

  eligibility:
      "Any person, including a worker, parent, guardian, citizen, organization, or government authority, may report suspected child labour or unlawful employment of a child in accordance with the applicable law.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC of Complainant (where required)",
    "Written Complaint or Application",
    "Details of the Child (if known)",
    "Employer or Workplace Information",
    "Photographs or Videos (if lawfully obtained)",
    "Names of Witnesses (if available)",
    "Any Supporting Documents or Evidence",
  ],

  applicableLaws: [
    "Employment of Children Act, 1991 (as applicable)",
    "Provincial Child Labour Laws",
    "Punjab Restriction on Employment of Children Act, 2016 (where applicable)",
    "Pakistan Penal Code (where applicable)",
    "Applicable Labour Laws",
  ],

  importantNotes: [
    "Report suspected child labour immediately.",
    "Provide accurate information to assist the investigation.",
    "Avoid placing the child at additional risk while collecting information.",
    "Cooperate with investigating authorities when requested.",
  ],

  commonMistakes: [
    "Providing incomplete location details.",
    "Submitting false or misleading information.",
    "Delaying the complaint despite knowledge of the violation.",
    "Interfering with the official investigation.",
  ],

  estimatedFee:
      "No government fee is charged for submitting a child labour complaint.",

  estimatedTime:
      "Depends upon the urgency of the matter, investigation, rescue operations (where required), and legal proceedings.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Identify the Violation",
      description:
          "Record the location, employer details, nature of work, and any other relevant information regarding the suspected child labour.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Collect Available Evidence",
      description:
          "Gather any lawfully obtained photographs, videos, witness details, or other supporting information where available.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Submit Complaint",
      description:
          "Submit the complaint to the Labour Department, Child Protection Authority, Police, or other competent authority.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Registration of Complaint",
      description:
          "The competent authority registers the complaint and initiates the appropriate action.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Investigation",
      description:
          "The authority investigates the allegations, records evidence, and conducts inspections where necessary.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Protective Measures",
      description:
          "Where required, the child may be removed from unlawful employment and provided protection in accordance with the law.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Legal Proceedings",
      description:
          "Appropriate legal action is initiated against responsible persons where violations are established.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Case Closure",
      description:
          "The matter is concluded after completion of enforcement measures and any required legal proceedings.",
    ),
  ],
),

];