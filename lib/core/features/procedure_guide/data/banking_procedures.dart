import '../models/procedure_model.dart';
import '../models/procedure_step.dart';

final List<ProcedureModel> bankingProcedures = [

  //-----------------------------------------------------------
// Procedure: Bank Account Opening
//-----------------------------------------------------------

ProcedureModel(
  id: "bank_account_opening",

  categoryId: "banking",

  title: "Bank Account Opening",

  overview:
      "A Bank Account Opening procedure enables an eligible individual or organization to establish a banking relationship with a licensed financial institution. A bank account allows customers to securely deposit funds, withdraw money, receive payments, transfer funds, access digital banking services, and conduct financial transactions in accordance with applicable banking laws and regulations.",

  governmentDepartment:
      "Scheduled Bank / Islamic Bank / Microfinance Bank",

  eligibility:
      "Any eligible individual, sole proprietor, partnership, company, association, or organization fulfilling the bank's account opening requirements and regulatory obligations may apply.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC",
    "Copy of CNIC",
    "Recent Passport-size Photograph",
    "Proof of Income (where applicable)",
    "Proof of Address",
    "Source of Income Declaration",
    "Completed Account Opening Form",
    "Any additional documents required by the bank",
  ],

  applicableLaws: [
    "Banking Companies Ordinance, 1962",
    "State Bank of Pakistan Regulations",
    "Anti-Money Laundering Act",
    "Applicable Prudential Regulations",
  ],

  importantNotes: [
    "Provide accurate personal information.",
    "Banks must complete Know Your Customer (KYC) verification.",
    "Choose the account type according to your financial needs.",
    "Read all account terms and conditions before signing.",
  ],

  commonMistakes: [
    "Submitting incomplete documentation.",
    "Providing incorrect contact information.",
    "Failure to disclose the source of income.",
    "Signing forms without reviewing the account terms.",
  ],

  estimatedFee:
      "Most basic account opening services are free; minimum deposit requirements may vary by bank.",

  estimatedTime:
      "Usually completed on the same day or within a few working days after verification.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Select the Bank and Account Type",
      description:
          "Choose a suitable bank and the type of account you wish to open.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Collect Required Documents",
      description:
          "Gather your CNIC, photographs and all required supporting documents.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Complete Account Opening Form",
      description:
          "Fill out the prescribed account opening form accurately.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Submit Application",
      description:
          "Submit the completed application and supporting documents to the bank.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "KYC Verification",
      description:
          "The bank conducts identity verification and regulatory compliance checks.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Deposit Initial Amount",
      description:
          "Deposit the initial amount if required under the selected account type.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Account Approval",
      description:
          "The bank reviews and approves the account after successful verification.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Receive Account Details",
      description:
          "Receive your account number and related banking information. Debit card, cheque book, and digital banking credentials may be issued separately according to the bank's procedures.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Joint Bank Account
//-----------------------------------------------------------

ProcedureModel(
  id: "joint_bank_account",

  categoryId: "banking",

  title: "Joint Bank Account",

  overview:
      "A Joint Bank Account is a bank account opened in the names of two or more individuals, allowing them to operate the account according to the operating instructions agreed upon at the time of account opening. Joint accounts are commonly used by spouses, business partners, family members, and other persons wishing to manage funds collectively.",

  governmentDepartment:
      "Scheduled Bank / Islamic Bank / Microfinance Bank",

  eligibility:
      "Two or more eligible individuals who satisfy the bank's account opening requirements and regulatory obligations may jointly apply for a Joint Bank Account.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC of All Applicants",
    "Copies of CNICs",
    "Recent Passport-size Photographs of All Applicants",
    "Proof of Address (where applicable)",
    "Source of Income Declaration",
    "Completed Joint Account Opening Form",
    "Any additional documents required by the bank",
  ],

  applicableLaws: [
    "Banking Companies Ordinance, 1962",
    "State Bank of Pakistan Regulations",
    "Anti-Money Laundering Act",
    "Applicable Prudential Regulations",
  ],

  importantNotes: [
    "Clearly decide the account operating instructions (Either or Survivor, Jointly, Anyone, etc.).",
    "All account holders must complete KYC verification.",
    "Read all account terms carefully before signing.",
    "Each account holder has responsibilities under the account agreement.",
  ],

  commonMistakes: [
    "Choosing incorrect operating instructions.",
    "Submitting incomplete documents for one or more applicants.",
    "Providing inconsistent personal information.",
    "Not understanding withdrawal and signing authority.",
  ],

  estimatedFee:
      "Generally free, subject to the bank's account opening policy.",

  estimatedTime:
      "Usually completed within the same day or a few working days after verification.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Select the Bank",
      description:
          "Choose the bank and suitable joint account type.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Collect Required Documents",
      description:
          "Gather CNICs, photographs and supporting documents of all applicants.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Complete Joint Account Form",
      description:
          "Fill in the joint account application form and specify account operating instructions.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Submit Application",
      description:
          "Submit the completed application with all supporting documents.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "KYC Verification",
      description:
          "The bank verifies the identity and compliance requirements of all applicants.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Deposit Initial Amount",
      description:
          "Deposit the minimum amount if required by the selected account type.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Account Approval",
      description:
          "The bank reviews and approves the joint account after successful verification.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Receive Account Details",
      description:
          "Receive the joint account number and related banking facilities according to the bank's procedures.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Cheque Book Request
//-----------------------------------------------------------

ProcedureModel(
  id: "cheque_book_request",

  categoryId: "banking",

  title: "Cheque Book Request",

  overview:
      "A Cheque Book Request is the process through which an account holder requests the issuance of a new cheque book for an existing bank account. Cheques enable customers to make payments, settle financial obligations, and conduct authorized banking transactions in accordance with applicable banking regulations.",

  governmentDepartment:
      "Scheduled Bank / Islamic Bank / Microfinance Bank",

  eligibility:
      "Any account holder with an active bank account eligible for cheque book facilities may apply for a new cheque book in accordance with the bank's policies.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC",
    "Account Number",
    "Completed Cheque Book Request Form (where applicable)",
    "Existing Cheque Book (where required)",
    "Any additional documents required by the bank",
  ],

  applicableLaws: [
    "Banking Companies Ordinance, 1962",
    "Negotiable Instruments Act, 1881",
    "State Bank of Pakistan Regulations",
    "Applicable Prudential Regulations",
  ],

  importantNotes: [
    "Ensure your account is active before requesting a cheque book.",
    "Some banks allow requests through online or mobile banking.",
    "Keep issued cheque books in a secure place.",
    "Report any lost cheque book immediately to the bank.",
  ],

  commonMistakes: [
    "Providing an incorrect account number.",
    "Failure to update contact information.",
    "Leaving signed blank cheques unsecured.",
    "Not reporting lost or stolen cheque books promptly.",
  ],

  estimatedFee:
      "According to the bank's schedule of charges.",

  estimatedTime:
      "Usually issued within a few working days depending on the bank's policy.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Choose Request Method",
      description:
          "Request a cheque book through a branch, ATM, internet banking, mobile banking, or any other facility provided by the bank.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Complete Request",
      description:
          "Fill out the cheque book request form or submit the request through the available banking channel.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Identity Verification",
      description:
          "Complete identity verification where required.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Application Verification",
      description:
          "The bank verifies the account status and request details.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Pay Applicable Charges",
      description:
          "Pay the prescribed cheque book charges if applicable.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Processing of Request",
      description:
          "The bank processes the cheque book request.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Collection or Delivery",
      description:
          "Collect the cheque book from the branch or receive it through the selected delivery method.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Verify Cheque Book",
      description:
          "Verify the account details and cheque leaf sequence before using the cheque book.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: ATM / Debit Card Application
//-----------------------------------------------------------

ProcedureModel(
  id: "atm_debit_card_application",

  categoryId: "banking",

  title: "ATM / Debit Card Application",

  overview:
      "An ATM / Debit Card Application is the process through which an eligible bank account holder requests the issuance of an ATM or Debit Card linked to their bank account. The card enables cash withdrawals, balance inquiries, fund transfers, point-of-sale (POS) purchases, online transactions where permitted, and other banking services in accordance with the bank's policies.",

  governmentDepartment:
      "Scheduled Bank / Islamic Bank / Microfinance Bank",

  eligibility:
      "Any eligible account holder maintaining an active bank account may apply for an ATM or Debit Card in accordance with the bank's policies.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC",
    "Copy of CNIC",
    "Active Bank Account Number",
    "Completed ATM / Debit Card Application Form (where applicable)",
    "Any additional documents required by the bank",
  ],

  applicableLaws: [
    "Banking Companies Ordinance, 1962",
    "State Bank of Pakistan Regulations",
    "Applicable Prudential Regulations",
    "Bank's Terms and Conditions",
  ],

  importantNotes: [
    "Keep your PIN confidential.",
    "Activate the card according to the bank's instructions before first use.",
    "Immediately report a lost or stolen card to the bank.",
    "Review applicable transaction limits and service charges.",
  ],

  commonMistakes: [
    "Sharing the ATM PIN with others.",
    "Writing the PIN on the card.",
    "Providing an incorrect delivery address.",
    "Failing to activate the card after issuance.",
  ],

  estimatedFee:
      "According to the bank's schedule of charges.",

  estimatedTime:
      "Usually issued within a few working days depending on the bank's procedures.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Verify Eligibility",
      description:
          "Ensure your bank account is active and eligible for ATM or Debit Card facilities.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Complete Application",
      description:
          "Fill out the ATM / Debit Card application form or submit the request through the available banking channel.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Submit Required Documents",
      description:
          "Provide your CNIC and any additional documents required by the bank.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Identity Verification",
      description:
          "The bank verifies your identity and account details.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Pay Applicable Charges",
      description:
          "Pay the prescribed card issuance fee if applicable.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Card Processing",
      description:
          "The bank processes the request and prepares the ATM / Debit Card.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Receive Card",
      description:
          "Collect the ATM / Debit Card from the branch or receive it through the selected delivery method.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Activate the Card",
      description:
          "Activate the card according to the bank's instructions and securely set or change your PIN before use.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: ATM / Debit Card Replacement
//-----------------------------------------------------------

ProcedureModel(
  id: "atm_debit_card_replacement",

  categoryId: "banking",

  title: "ATM / Debit Card Replacement",

  overview:
      "ATM / Debit Card Replacement is the process through which an account holder requests a replacement card when the existing ATM or Debit Card is lost, stolen, damaged, expired, retained by an ATM, or otherwise unusable. The replacement card allows the customer to continue accessing banking services securely.",

  governmentDepartment:
      "Scheduled Bank / Islamic Bank / Microfinance Bank",

  eligibility:
      "Any account holder whose ATM or Debit Card has been lost, stolen, damaged, expired, blocked, or retained by an ATM may apply for a replacement card in accordance with the bank's policies.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC",
    "Copy of CNIC",
    "Bank Account Number",
    "ATM / Debit Card Replacement Request Form (where applicable)",
    "Damaged or Expired Card (if available)",
    "Police Report (where required for lost or stolen cards)",
    "Any additional documents required by the bank",
  ],

  applicableLaws: [
    "Banking Companies Ordinance, 1962",
    "State Bank of Pakistan Regulations",
    "Applicable Prudential Regulations",
    "Bank's Terms and Conditions",
  ],

  importantNotes: [
    "Immediately block a lost or stolen card.",
    "Report unauthorized transactions without delay.",
    "Keep your replacement card and PIN secure.",
    "Update recurring payment details if your card number changes.",
  ],

  commonMistakes: [
    "Delaying the reporting of a lost or stolen card.",
    "Sharing card or PIN details with others.",
    "Not checking account transactions after card loss.",
    "Providing an incorrect delivery address.",
  ],

  estimatedFee:
      "According to the bank's schedule of charges.",

  estimatedTime:
      "Usually issued within a few working days depending upon the bank's procedures.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Block Existing Card",
      description:
          "Immediately inform the bank to block the lost, stolen or compromised card.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Submit Replacement Request",
      description:
          "Complete the replacement request through the branch, helpline, internet banking, mobile banking or any authorized banking channel.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Provide Required Documents",
      description:
          "Submit your CNIC and any supporting documents required by the bank.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Identity Verification",
      description:
          "The bank verifies your identity and account information.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Pay Applicable Charges",
      description:
          "Pay the prescribed replacement fee if applicable.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Card Processing",
      description:
          "The bank prepares and issues the replacement card.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Receive Replacement Card",
      description:
          "Collect the replacement card from the branch or receive it through the selected delivery method.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Activate Replacement Card",
      description:
          "Activate the replacement card and securely set or change your PIN before using it.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Bank Statement Request
//-----------------------------------------------------------

ProcedureModel(
  id: "bank_statement_request",

  categoryId: "banking",

  title: "Bank Statement Request",

  overview:
      "A Bank Statement Request is the process through which an account holder obtains an official statement of account showing account transactions, balances, deposits, withdrawals, transfers, charges, and other financial activities for a specified period. Bank statements are commonly required for visa applications, income verification, audits, taxation, loan applications, court proceedings, and personal financial record keeping.",

  governmentDepartment:
      "Scheduled Bank / Islamic Bank / Microfinance Bank",

  eligibility:
      "Any account holder or an authorized representative may request a bank statement for an eligible account in accordance with the bank's policies.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC",
    "Bank Account Number",
    "Completed Bank Statement Request Form (where applicable)",
    "Authorization Letter (if submitted by an authorized representative)",
    "Any additional documents required by the bank",
  ],

  applicableLaws: [
    "Banking Companies Ordinance, 1962",
    "State Bank of Pakistan Regulations",
    "Applicable Prudential Regulations",
    "Bank's Terms and Conditions",
  ],

  importantNotes: [
    "Specify the required statement period clearly.",
    "Electronic statements may be available through internet or mobile banking.",
    "Keep bank statements confidential.",
    "Some banks charge fees for older or certified statements.",
  ],

  commonMistakes: [
    "Providing an incorrect account number.",
    "Requesting an incorrect statement period.",
    "Failure to provide identity verification.",
    "Not checking the statement for completeness after issuance.",
  ],

  estimatedFee:
      "According to the bank's schedule of charges. Recent electronic statements may be provided free of cost by some banks.",

  estimatedTime:
      "Usually issued immediately or within one working day depending upon the request method.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Choose Request Method",
      description:
          "Request the statement through a branch, internet banking, mobile banking, ATM or any authorized banking channel.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Specify Statement Period",
      description:
          "Mention the period for which the statement is required.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Identity Verification",
      description:
          "Complete identity verification where required.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Submit Request",
      description:
          "Submit the request together with any required supporting documents.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Pay Applicable Charges",
      description:
          "Pay the prescribed charges if applicable.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Processing of Request",
      description:
          "The bank prepares the requested account statement.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Receive Statement",
      description:
          "Receive the statement in printed or electronic form.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Verify Statement",
      description:
          "Review the statement to ensure the requested period and transaction details are correct.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Account Closure
//-----------------------------------------------------------

ProcedureModel(
  id: "account_closure",

  categoryId: "banking",

  title: "Account Closure",

  overview:
      "Account Closure is the process through which an account holder permanently closes an existing bank account after fulfilling all financial obligations and completing the bank's prescribed requirements. Once the account is closed, banking facilities associated with the account are discontinued.",

  governmentDepartment:
      "Scheduled Bank / Islamic Bank / Microfinance Bank",

  eligibility:
      "Any account holder or an authorized representative, where permitted by law and the bank's policies, may apply for closure of an eligible bank account.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC",
    "Completed Account Closure Form",
    "Cheque Book (if issued)",
    "ATM / Debit Card",
    "Passbook (where applicable)",
    "Any additional documents required by the bank",
  ],

  applicableLaws: [
    "Banking Companies Ordinance, 1962",
    "State Bank of Pakistan Regulations",
    "Applicable Prudential Regulations",
    "Bank's Terms and Conditions",
  ],

  importantNotes: [
    "Ensure all outstanding loans, charges and liabilities are cleared.",
    "Cancel automatic payments linked to the account before closure.",
    "Withdraw or transfer the remaining account balance.",
    "Obtain written confirmation after the account is closed.",
  ],

  commonMistakes: [
    "Leaving a remaining balance in the account.",
    "Failing to surrender cheque books or debit cards where required.",
    "Ignoring pending transactions before account closure.",
    "Not obtaining proof of account closure.",
  ],

  estimatedFee:
      "Generally free, subject to the bank's schedule of charges and account terms.",

  estimatedTime:
      "Usually completed within the same day or a few working days after verification.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Review Account Status",
      description:
          "Ensure there are no pending liabilities, disputes or transactions.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Withdraw or Transfer Balance",
      description:
          "Transfer or withdraw the remaining balance from the account.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Complete Closure Form",
      description:
          "Fill in the prescribed account closure application form.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Submit Required Items",
      description:
          "Submit the form together with your CNIC, cheque book, debit card and other required items.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Identity Verification",
      description:
          "The bank verifies your identity and account ownership.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Account Verification",
      description:
          "The bank confirms that all obligations have been fulfilled.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Account Closure Processing",
      description:
          "The bank processes and closes the account after successful verification.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Receive Closure Confirmation",
      description:
          "Obtain written or electronic confirmation that the account has been successfully closed.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Dormant Account Reactivation
//-----------------------------------------------------------

ProcedureModel(
  id: "dormant_account_reactivation",

  categoryId: "banking",

  title: "Dormant Account Reactivation",

  overview:
      "Dormant Account Reactivation is the process through which an account holder restores an inactive or dormant bank account to active status. Banks classify accounts as inactive or dormant after a specified period without customer-initiated transactions, subject to applicable regulations and the bank's internal policies.",

  governmentDepartment:
      "Scheduled Bank / Islamic Bank / Microfinance Bank",

  eligibility:
      "The account holder or an authorized representative, where permitted by law and the bank's policies, may apply for reactivation of an inactive or dormant account after completing the required verification process.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC",
    "Copy of CNIC",
    "Account Number",
    "Dormant Account Reactivation Form",
    "Updated Customer Information (where applicable)",
    "Any additional documents required by the bank",
  ],

  applicableLaws: [
    "Banking Companies Ordinance, 1962",
    "State Bank of Pakistan Regulations",
    "Applicable Prudential Regulations",
    "Bank's Terms and Conditions",
  ],

  importantNotes: [
    "Personal appearance at the branch may be required.",
    "The bank may request updated KYC information.",
    "Identity verification is mandatory before reactivation.",
    "Keep your contact information updated to avoid future account inactivity.",
  ],

  commonMistakes: [
    "Providing outdated contact information.",
    "Failure to complete KYC requirements.",
    "Submitting incomplete application forms.",
    "Ignoring bank requests for additional documents.",
  ],

  estimatedFee:
      "Generally free, subject to the bank's schedule of charges.",

  estimatedTime:
      "Usually completed within the same day or a few working days after successful verification.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Visit the Branch",
      description:
          "Visit the branch where your account is maintained or another authorized branch if permitted.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Complete Reactivation Form",
      description:
          "Fill in the prescribed dormant account reactivation form accurately.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Submit Required Documents",
      description:
          "Provide your CNIC and any additional documents required by the bank.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Identity Verification",
      description:
          "The bank verifies your identity and account ownership.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "KYC Update",
      description:
          "Update customer information and complete Know Your Customer (KYC) requirements where necessary.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Application Review",
      description:
          "The bank reviews the application and supporting documents.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Account Reactivation",
      description:
          "Upon successful verification, the bank restores the account to active status.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Confirmation",
      description:
          "Receive confirmation that the account has been reactivated and is ready for normal banking transactions.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Bank Locker Facility
//-----------------------------------------------------------

ProcedureModel(
  id: "bank_locker_facility",

  categoryId: "banking",

  title: "Bank Locker Facility",

  overview:
      "A Bank Locker Facility allows customers to rent a secure locker from a bank for storing valuable documents, jewelry, financial instruments, wills, property papers, and other important belongings. The facility is provided under a locker agreement subject to the bank's policies, availability, and applicable banking regulations.",

  governmentDepartment:
      "Scheduled Bank / Islamic Bank",

  eligibility:
      "Any eligible customer maintaining the required banking relationship with the bank and fulfilling its locker eligibility criteria may apply for a locker facility.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC",
    "Copy of CNIC",
    "Active Bank Account Details",
    "Completed Locker Application Form",
    "Passport-size Photograph (where required)",
    "Locker Agreement",
    "Security Deposit (if applicable)",
    "Nominee Details (where applicable)",
  ],

  applicableLaws: [
    "Banking Companies Ordinance, 1962",
    "State Bank of Pakistan Regulations",
    "Applicable Prudential Regulations",
    "Bank Locker Agreement",
  ],

  importantNotes: [
    "Locker allotment is subject to availability.",
    "Nomination of a legal heir is strongly recommended.",
    "Do not store prohibited or illegal items in the locker.",
    "Pay locker rent on time to avoid penalties or cancellation.",
  ],

  commonMistakes: [
    "Failing to nominate a legal heir.",
    "Not renewing the locker agreement when required.",
    "Missing annual locker rent payments.",
    "Losing locker keys without informing the bank immediately.",
  ],

  estimatedFee:
      "According to the bank's locker rent schedule, security deposit, and applicable charges.",

  estimatedTime:
      "Usually completed on the same day if lockers are available and verification is successfully completed.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Check Locker Availability",
      description:
          "Contact the bank to confirm the availability of the desired locker size.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Complete Locker Application",
      description:
          "Fill out the prescribed locker application form accurately.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Submit Required Documents",
      description:
          "Provide your CNIC, account details and other required documents.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Identity Verification",
      description:
          "The bank verifies your identity and account relationship.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Execute Locker Agreement",
      description:
          "Sign the locker agreement after reading all terms and conditions.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Pay Charges",
      description:
          "Pay the locker rent, security deposit and any other applicable charges.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Locker Allocation",
      description:
          "The bank allocates the locker and provides access instructions.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Receive Locker Keys",
      description:
          "Receive the locker keys or access credentials and keep them securely.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Internet / Mobile Banking Registration
//-----------------------------------------------------------

ProcedureModel(
  id: "internet_mobile_banking_registration",

  categoryId: "banking",

  title: "Internet / Mobile Banking Registration",

  overview:
      "Internet / Mobile Banking Registration is the process through which an eligible account holder enrolls for digital banking services provided by a bank. These services enable customers to securely access their accounts, transfer funds, pay utility bills, manage beneficiaries, view account statements, and perform various banking transactions electronically.",

  governmentDepartment:
      "Scheduled Bank / Islamic Bank / Microfinance Bank",

  eligibility:
      "Any eligible account holder maintaining an active bank account may register for Internet Banking, Mobile Banking, or both, subject to the bank's policies and verification requirements.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC",
    "Active Bank Account Number",
    "Registered Mobile Number",
    "Active Email Address",
    "Completed Registration Form (where applicable)",
    "ATM / Debit Card (where required)",
    "Any additional documents required by the bank",
  ],

  applicableLaws: [
    "Banking Companies Ordinance, 1962",
    "State Bank of Pakistan Regulations",
    "Electronic Transactions Ordinance, 2002",
    "Applicable Prudential Regulations",
    "Bank's Digital Banking Terms and Conditions",
  ],

  importantNotes: [
    "Keep your login credentials confidential.",
    "Enable two-factor authentication whenever available.",
    "Never share your OTP, password, or PIN with anyone.",
    "Regularly update your registered contact information.",
  ],

  commonMistakes: [
    "Using weak passwords.",
    "Sharing login credentials or OTPs.",
    "Ignoring security alerts from the bank.",
    "Logging in through unsecured public networks.",
  ],

  estimatedFee:
      "Generally free, subject to the bank's schedule of charges.",

  estimatedTime:
      "Usually activated immediately or within one working day after successful verification.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Verify Eligibility",
      description:
          "Ensure your bank account and registered mobile number are eligible for digital banking services.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Choose Registration Method",
      description:
          "Register through the bank branch, official website, mobile application, ATM, or any other authorized banking channel.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Complete Registration",
      description:
          "Provide the required account information and complete the registration process.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Identity Verification",
      description:
          "Complete the identity verification required by the bank.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Create Login Credentials",
      description:
          "Set a secure username, password, and any additional authentication credentials required by the bank.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Activate Digital Banking",
      description:
          "Activate Internet Banking or Mobile Banking according to the bank's instructions.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Security Setup",
      description:
          "Enable two-factor authentication, transaction alerts, and other available security features.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Access Digital Banking Services",
      description:
          "Log in to your Internet Banking or Mobile Banking account and verify that all services are functioning correctly.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Personal Loan Application
//-----------------------------------------------------------

ProcedureModel(
  id: "personal_loan_application",

  categoryId: "banking",

  title: "Personal Loan Application",

  overview:
      "A Personal Loan Application is the process through which an eligible individual applies for unsecured or secured financing from a bank or financial institution for personal needs such as education, medical expenses, home improvement, travel, marriage, or other lawful purposes. Loan approval is subject to the bank's credit assessment, repayment capacity, and applicable regulatory requirements.",

  governmentDepartment:
      "Scheduled Bank / Islamic Bank / Microfinance Bank",

  eligibility:
      "Any eligible individual meeting the bank's age, income, employment, creditworthiness, and financing criteria may apply for a personal loan.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC",
    "Copy of CNIC",
    "Recent Passport-size Photographs",
    "Salary Slip or Income Proof",
    "Bank Statements",
    "Employment Certificate (where applicable)",
    "Tax Documents (where applicable)",
    "Completed Loan Application Form",
    "Supporting Documents required by the bank",
  ],

  applicableLaws: [
    "Banking Companies Ordinance, 1962",
    "State Bank of Pakistan Regulations",
    "Applicable Prudential Regulations",
    "Bank's Financing Policies",
  ],

  importantNotes: [
    "Compare financing options before applying.",
    "Understand the markup/profit rate, repayment schedule, and total financing cost.",
    "Borrow only what you can comfortably repay.",
    "Read the financing agreement carefully before signing.",
  ],

  commonMistakes: [
    "Applying without reviewing eligibility requirements.",
    "Providing incomplete income information.",
    "Ignoring repayment obligations.",
    "Signing financing documents without understanding the terms.",
  ],

  estimatedFee:
      "According to the bank's schedule of charges and applicable processing fees.",

  estimatedTime:
      "Depends upon document verification, credit assessment, and financing approval.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Review Eligibility",
      description:
          "Confirm that you satisfy the bank's financing requirements.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Collect Required Documents",
      description:
          "Gather income documents, CNIC, bank statements and all supporting records.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Complete Loan Application",
      description:
          "Fill in the prescribed personal loan application form accurately.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Submit Application",
      description:
          "Submit the application together with all required documents.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Credit & Income Assessment",
      description:
          "The bank evaluates your repayment capacity and credit profile.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Verification Process",
      description:
          "The bank verifies employment, income, identity and other required information.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Financing Decision",
      description:
          "The bank approves or declines the financing request according to its policies.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Loan Disbursement",
      description:
          "Upon approval and execution of the financing agreement, the approved amount is disbursed according to the agreed terms.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Home Finance / Mortgage
//-----------------------------------------------------------

ProcedureModel(
  id: "home_finance_mortgage",

  categoryId: "banking",

  title: "Home Finance / Mortgage",

  overview:
      "Home Finance or Mortgage is the process through which an eligible individual obtains financing from a bank or financial institution for the purchase, construction, renovation, or extension of a residential property. Financing is granted subject to the applicant's repayment capacity, property evaluation, legal verification, and the bank's financing policies.",

  governmentDepartment:
      "Scheduled Bank / Islamic Bank / Microfinance Bank",

  eligibility:
      "Any eligible individual meeting the bank's age, income, repayment capacity, and financing requirements may apply for Home Finance or Mortgage.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC",
    "Copy of CNIC",
    "Recent Passport-size Photographs",
    "Salary Slip or Income Proof",
    "Bank Statements",
    "Employment Certificate or Business Proof",
    "Property Ownership Documents",
    "Sale Agreement or Allotment Letter (where applicable)",
    "Property Valuation Documents",
    "Completed Home Finance Application Form",
    "Additional documents required by the bank",
  ],

  applicableLaws: [
    "Banking Companies Ordinance, 1962",
    "State Bank of Pakistan Regulations",
    "Transfer of Property Act",
    "Registration Act, 1908",
    "Applicable Prudential Regulations",
  ],

  importantNotes: [
    "Carefully review the financing tenure and markup/profit rate.",
    "The property must successfully pass legal and technical verification.",
    "Understand the total financing cost before signing the agreement.",
    "Maintain timely installment payments to avoid default.",
  ],

  commonMistakes: [
    "Applying without complete property documents.",
    "Ignoring hidden financing charges.",
    "Providing incorrect income information.",
    "Signing the financing agreement without reading the terms.",
  ],

  estimatedFee:
      "According to the bank's schedule of charges, valuation fees, legal verification fees, and applicable processing charges.",

  estimatedTime:
      "Usually several weeks depending upon legal verification, valuation, and financing approval.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Select Financing Scheme",
      description:
          "Choose the most suitable home financing product offered by the bank.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Collect Required Documents",
      description:
          "Gather personal, financial and property-related documents.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Submit Application",
      description:
          "Submit the completed financing application together with all supporting documents.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Income Assessment",
      description:
          "The bank evaluates your repayment capacity and financial profile.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Property Verification",
      description:
          "The bank conducts legal and technical verification of the property.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Property Valuation",
      description:
          "The bank assesses the market value of the property.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Financing Approval",
      description:
          "The bank reviews the application and issues its financing decision.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Execution & Disbursement",
      description:
          "After execution of the financing documents, the approved financing is disbursed according to the agreed terms.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Vehicle Finance
//-----------------------------------------------------------

ProcedureModel(
  id: "vehicle_finance",

  categoryId: "banking",

  title: "Vehicle Finance",

  overview:
      "Vehicle Finance is the process through which an eligible individual or business obtains financing from a bank or financial institution for the purchase of a new or used motor vehicle. Financing is granted subject to the applicant's repayment capacity, credit assessment, vehicle eligibility, and the bank's financing policies.",

  governmentDepartment:
      "Scheduled Bank / Islamic Bank / Microfinance Bank",

  eligibility:
      "Any eligible individual or business meeting the bank's financing criteria, including age, income, repayment capacity, and creditworthiness, may apply for vehicle finance.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC",
    "Copy of CNIC",
    "Recent Passport-size Photographs",
    "Salary Slip or Income Proof",
    "Bank Statements",
    "Employment Certificate or Business Proof",
    "Vehicle Quotation or Proforma Invoice",
    "Completed Vehicle Finance Application Form",
    "Supporting Documents required by the bank",
  ],

  applicableLaws: [
    "Banking Companies Ordinance, 1962",
    "State Bank of Pakistan Regulations",
    "Applicable Prudential Regulations",
    "Motor Vehicle Registration Laws",
    "Bank's Financing Policies",
  ],

  importantNotes: [
    "Compare financing options offered by different banks.",
    "Understand the markup/profit rate, tenure, and total financing cost.",
    "Ensure the financed vehicle is properly insured if required.",
    "Make installment payments on time to avoid penalties.",
  ],

  commonMistakes: [
    "Providing incomplete financial documents.",
    "Ignoring the total financing cost.",
    "Failing to maintain insurance where required.",
    "Missing installment payments.",
  ],

  estimatedFee:
      "According to the bank's schedule of charges, processing fees, and applicable valuation or registration costs.",

  estimatedTime:
      "Usually completed within several working days or weeks depending on verification and financing approval.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Choose Financing Product",
      description:
          "Select the vehicle financing scheme suitable for your requirements.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Collect Required Documents",
      description:
          "Gather your financial records, identity documents and vehicle quotation.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Submit Application",
      description:
          "Submit the completed vehicle finance application with supporting documents.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Credit Assessment",
      description:
          "The bank evaluates your financial profile and repayment capacity.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Vehicle Verification",
      description:
          "The bank verifies the vehicle details and eligibility under its financing policy.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Application Review",
      description:
          "The financing request is reviewed according to the bank's internal procedures.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Financing Approval",
      description:
          "The bank issues its financing decision after successful verification.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Vehicle Delivery & Financing",
      description:
          "After execution of the financing agreement, the vehicle financing is completed according to the agreed terms.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Business Loan
//-----------------------------------------------------------

ProcedureModel(
  id: "business_loan",

  categoryId: "banking",

  title: "Business Loan",

  overview:
      "A Business Loan is a financing facility provided by a bank or financial institution to an eligible business, entrepreneur, sole proprietor, partnership, company, or other commercial entity for business establishment, expansion, working capital, machinery, equipment, inventory, or other lawful business purposes. Financing is subject to the applicant's financial standing, business viability, credit assessment, and the bank's financing policies.",

  governmentDepartment:
      "Scheduled Bank / Islamic Bank / Development Finance Institution",

  eligibility:
      "Any eligible business entity or entrepreneur meeting the bank's financing requirements, repayment capacity, and applicable regulatory conditions may apply for a Business Loan.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC of Applicant",
    "Copy of CNIC",
    "Business Registration Documents",
    "NTN Certificate (where applicable)",
    "Business Bank Statements",
    "Financial Statements",
    "Business Plan or Project Proposal",
    "Tax Records (where applicable)",
    "Collateral Documents (if required)",
    "Completed Business Loan Application Form",
    "Supporting Documents required by the bank",
  ],

  applicableLaws: [
    "Banking Companies Ordinance, 1962",
    "State Bank of Pakistan Regulations",
    "Applicable Prudential Regulations",
    "Income Tax Ordinance, 2001",
    "Bank's Financing Policies",
  ],

  importantNotes: [
    "Maintain accurate financial records before applying.",
    "Prepare a realistic business plan and repayment strategy.",
    "Understand all financing charges, markup/profit rates, and repayment obligations.",
    "Some financing facilities may require collateral or guarantees.",
  ],

  commonMistakes: [
    "Submitting incomplete financial statements.",
    "Providing unrealistic business projections.",
    "Ignoring repayment obligations.",
    "Applying without understanding the financing agreement.",
  ],

  estimatedFee:
      "According to the bank's schedule of charges, processing fees, legal verification fees, and other applicable costs.",

  estimatedTime:
      "Depends upon financial assessment, document verification, collateral evaluation (if applicable), and financing approval.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Select Financing Product",
      description:
          "Choose the business financing facility that best suits your business requirements.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Prepare Business Documents",
      description:
          "Gather business registration documents, financial statements, tax records, and the business plan.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Submit Application",
      description:
          "Submit the completed Business Loan application together with all supporting documents.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Business & Financial Assessment",
      description:
          "The bank evaluates the business model, financial performance, repayment capacity, and credit profile.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Verification Process",
      description:
          "The bank verifies business documents, identity, and any collateral offered for financing.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Application Review",
      description:
          "The financing request is reviewed according to the bank's internal policies and regulatory requirements.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Financing Approval",
      description:
          "The bank issues its financing decision after successful completion of all assessments.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Execution & Disbursement",
      description:
          "After execution of the financing agreement, the approved funds are disbursed according to the agreed financing terms.",
    ),
  ],
),

//-----------------------------------------------------------
// Procedure: Complaint Against Bank
//-----------------------------------------------------------

ProcedureModel(
  id: "complaint_against_bank",

  categoryId: "banking",

  title: "Complaint Against Bank",

  overview:
      "A Complaint Against Bank is the process through which a customer reports a grievance regarding banking services, unauthorized transactions, delays, service deficiencies, unfair practices, account disputes, financing issues, or other banking-related matters. Complaints should ordinarily be lodged with the concerned bank first. If the matter remains unresolved, it may be escalated to the appropriate banking grievance redressal mechanism in accordance with applicable laws and regulations.",

  governmentDepartment:
      "Scheduled Bank / Islamic Bank / State Bank of Pakistan (where applicable)",

  eligibility:
      "Any bank customer or an authorized representative may submit a complaint regarding banking services or transactions in accordance with the applicable procedures.",

  requiredDocuments: [
    "Original CNIC or Smart CNIC",
    "Copy of CNIC",
    "Bank Account Number or Customer ID",
    "Written Complaint or Complaint Form",
    "Relevant Transaction Details",
    "Supporting Documents or Evidence",
    "Previous Correspondence with the Bank (if any)",
  ],

  applicableLaws: [
    "Banking Companies Ordinance, 1962",
    "State Bank of Pakistan Regulations",
    "Applicable Prudential Regulations",
    "Bank's Customer Complaint Handling Policy",
  ],

  importantNotes: [
    "Submit the complaint with complete facts and supporting evidence.",
    "Keep copies of all complaint documents and acknowledgements.",
    "Record the complaint or reference number for future follow-up.",
    "Escalate the complaint only after following the bank's internal complaint process where applicable.",
  ],

  commonMistakes: [
    "Submitting incomplete information.",
    "Failing to attach supporting evidence.",
    "Not preserving the complaint reference number.",
    "Providing incorrect contact information.",
  ],

  estimatedFee:
      "Generally no fee is charged for lodging a complaint.",

  estimatedTime:
      "Depends upon the bank's complaint handling process, investigation, and applicable regulatory timelines.",

  steps: [

    ProcedureStep(
      stepNo: 1,
      title: "Collect Relevant Information",
      description:
          "Gather account details, transaction records, correspondence, and all supporting evidence relating to the complaint.",
    ),

    ProcedureStep(
      stepNo: 2,
      title: "Prepare Complaint",
      description:
          "Clearly describe the issue, the relief sought, and attach supporting documents.",
    ),

    ProcedureStep(
      stepNo: 3,
      title: "Submit Complaint to the Bank",
      description:
          "Submit the complaint through the branch, customer service, helpline, official website, mobile application, or any other authorized complaint channel.",
    ),

    ProcedureStep(
      stepNo: 4,
      title: "Receive Complaint Reference",
      description:
          "Obtain and safely retain the complaint or reference number for future follow-up.",
    ),

    ProcedureStep(
      stepNo: 5,
      title: "Investigation by the Bank",
      description:
          "The bank reviews the complaint, verifies the facts, and conducts any necessary investigation.",
    ),

    ProcedureStep(
      stepNo: 6,
      title: "Receive Bank's Response",
      description:
          "Review the bank's decision or proposed resolution after completion of its investigation.",
    ),

    ProcedureStep(
      stepNo: 7,
      title: "Escalate if Necessary",
      description:
          "If dissatisfied with the bank's response, pursue the available escalation mechanism in accordance with applicable laws and regulatory procedures.",
    ),

    ProcedureStep(
      stepNo: 8,
      title: "Maintain Records",
      description:
          "Keep copies of all correspondence, evidence, and final decisions for future reference or legal proceedings if required.",
    ),
  ],
),

];