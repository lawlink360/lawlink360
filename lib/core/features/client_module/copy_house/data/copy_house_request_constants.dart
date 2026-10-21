/// Constants for the Copy House Phase 1 and Phase 2 request workflow.
///
/// These values are referenced by the request model, the repository,
/// the form, and the proposed Firestore security rules. Changing any
/// of them requires updating the rules patch as well.
library;

/// Firestore collection that stores Copy House requests.
const String copyHouseRequestsCollection = 'copyHouseRequests';

/// Service id for the District Court Certified Copies service.
/// Phase 1 and Phase 2 support only this service.
const String districtCourtCertifiedCopiesServiceId =
    'district_court_certified_copies';

/// The only status a newly created request may have.
/// Customers cannot set any other status.
const String initialCopyHouseRequestStatus = 'submitted';

/// Allowed case-type values.
const List<String> allowedCaseTypes = <String>[
  'civil',
  'criminal',
];

/// Allowed case-status values.
const List<String> allowedCaseStatuses = <String>[
  'pending',
  'decided',
];

// ---------------------------------------------------------------------------
// Support contact configuration.
//
// The real customer-support phone number has not been supplied. Until it
// is, this constant must remain exactly the placeholder string below.
// The Customer Support Center refuses to launch WhatsApp or the dialler
// while this value equals the placeholder.
//
// When the real number is available, replace the string below with the
// number in E.164 format (leading `+`, country code, no spaces or dashes),
// for example:  const String copyHouseSupportPhoneE164 = '+923001234567';
//
// Do not put a personal or placeholder number anywhere else in the app.
// This is the single configuration point.
// ---------------------------------------------------------------------------
const String copyHouseSupportPhoneE164Placeholder =
    'REPLACE_WITH_SUPPORT_NUMBER';

const String copyHouseSupportPhoneE164 =
    copyHouseSupportPhoneE164Placeholder;

/// Prefilled WhatsApp message. Users can review and edit before sending.
const String copyHouseWhatsAppPrefillMessage =
    'Assalam-o-Alaikum, I need assistance with Copy House by LawLink360.';

// ---------------------------------------------------------------------------
// Field length limits.
//
// These mirror the validation applied in the request form. They do not
// appear in the currently deployed Firestore rules; the rules proposal
// uses its own length checks. Keep them in sync if either side changes.
// ---------------------------------------------------------------------------

const int maxPartyNameLength = 200;
const int maxCaseNumberLength = 100;
const int maxFirNumberLength = 50;
const int maxFirYearLength = 4;
const int maxPoliceStationLength = 150;
const int maxOffenceLength = 200;
const int maxJurisdictionLength = 200;
const int maxCourtOrJudgeLength = 200;
const int maxRecordDocumentLength = 200;
const int maxPurposeLength = 500;
const int maxAdditionalInformationLength = 1000;

/// Initial number of document inputs shown on the form.
const int initialDocumentInputCount = 3;


// ---------------------------------------------------------------------------
// Phase 2 service ids, subtypes, and validation limits.
// ---------------------------------------------------------------------------

/// Service id for the Mutation Copies service.
const String mutationCopiesServiceId = 'mutation_copies';

/// Service id for the Registered Document Copies service.
const String registeredDocumentCopiesServiceId =
    'registered_document_copies';

/// Subtype ids for Registered Document Copies. These are stable
/// internal identifiers; user-visible labels live in
/// [registeredDocumentSubtypeLabels].
const String registeredSubtypeSaleDeed = 'registered_sale_deed';
const String registeredSubtypeGiftDeed = 'registered_gift_deed';
const String registeredSubtypeGeneralPowerOfAttorney =
    'registered_general_power_of_attorney';
const String registeredSubtypeSpecialPowerOfAttorney =
    'registered_special_power_of_attorney';

/// Ordered list of the four supported Registered Document subtypes.
const List<String> registeredDocumentSubtypes = <String>[
  registeredSubtypeSaleDeed,
  registeredSubtypeGiftDeed,
  registeredSubtypeGeneralPowerOfAttorney,
  registeredSubtypeSpecialPowerOfAttorney,
];

/// Human-readable labels for the Registered Document subtypes, in the
/// same order as [registeredDocumentSubtypes].
const Map<String, String> registeredDocumentSubtypeLabels =
    <String, String>{
  registeredSubtypeSaleDeed: 'Registered Sale Deed',
  registeredSubtypeGiftDeed: 'Registered Gift Deed',
  registeredSubtypeGeneralPowerOfAttorney:
      'Registered General Power of Attorney',
  registeredSubtypeSpecialPowerOfAttorney:
      'Registered Special Power of Attorney',
};

// Field length limits for Mutation Copies.
const int maxMutationNumberLength = 100;
const int maxSubRegistrarTownLength = 150;
const int maxDistrictLength = 150;
const int maxTehsilLength = 150;
const int maxVillageMouzaLength = 150;

// Field length limits for Registered Document Copies.
const int maxBookNumberLength = 50;
const int maxVolumeNumberLength = 50;
const int maxDocumentNumberLength = 100;


// ---------------------------------------------------------------------------
// High Court Certified Copies.
// ---------------------------------------------------------------------------

/// Service id for the High Court Certified Copies service.
const String highCourtCertifiedCopiesServiceId =
    'high_court_certified_copies';

/// Peshi types stored in `serviceDetails['peshiType']`.
const String highCourtPeshiTypePucca = 'pucca';
const String highCourtPeshiTypeKuccha = 'kuccha';

/// Initial number of justice-name inputs shown on the High Court form.
const int highCourtInitialJusticeCount = 2;

/// Initial number of requested-copy-detail inputs shown on the High
/// Court form.
const int highCourtInitialCopyDetailCount = 3;

/// Two-digit year suffix length used in the case number field.
const int highCourtCaseYearLength = 2;

const int maxHighCourtCaseNumberLength = 50;
const int maxHighCourtJusticeNameLength = 200;
const int maxHighCourtCopyDetailLength = 200;
const int maxHighCourtDistrictLength = 150;