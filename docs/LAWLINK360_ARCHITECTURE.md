with this.

# LawLink360 Architecture & Development Constitution

**Project Name:** LawLink360  
**Project Type:** Legal Super App  
**Framework:** Flutter  
**Primary Language:** Dart  
**State Management:** Riverpod  
**Backend:** Firebase  
**Database:** Cloud Firestore  
**Authentication:** Firebase Authentication  
**Repository:** GitHub  

---

# 1. Project Overview

LawLink360 is a legal technology application designed to provide users with a centralized platform for:

- Finding and connecting with lawyers
- Discussing legal cases
- Booking legal consultations
- Managing appointments
- Managing legal documents
- Understanding legal procedures
- Preparing applications and documents
- Translating legal documents
- Scanning and processing documents
- Verifying legal and institutional services
- Managing user profiles
- Accessing legal support resources
- Providing future lawyer and administration functionality

LawLink360 is being developed as a multi-module legal platform consisting of:

1. Client Module
2. Lawyer Module
3. Admin Module

The development priority is:

```text
Client Module
      ↓
Lawyer Module
      ↓
Admin Module

The Client Module is currently the primary development focus.

---

2. Primary Architecture Principle

LawLink360 must use a structured and scalable architecture.

The application must not become a collection of unrelated screens.

Features should be organized into appropriate architectural layers such as:

Screens
Widgets
Models
Data
Providers
Notifiers
Repositories
Services
Firebase integrations
Database structures
Navigation
Utilities
Shared components

Each new feature must integrate with the existing project architecture instead of creating duplicate or isolated implementations.

-----

3. Major Application Modules
LawLink360
│
├── Client Module
│
├── Lawyer Module
│
└── Admin Module

----

3.1 Client Module

The Client Module provides the user-facing legal services and application functionality.

Current client-related functionality includes:

Client Dashboard
Find Lawyer
Lawyer Profiles
Lawyer Details and Reviews
Lawyer Booking
Appointments
Chat
Voice Consultation
Video Consultation
Payments
My Cases
Documents
Procedure Guide
Application
Verification
Translation
Scanner
Profile
Settings
Help & Support
Messages
Subscription
Legal Navigator

----

3.2 Lawyer Module

The Lawyer Module is planned as the second major development phase.

The current source tree already contains the initial structural foundation:

core/features/lawyer_module/
├── cases/
├── dashboard/
├── judgments/
└── providers/

The Lawyer Module will eventually contain lawyer-specific:

Dashboard
Cases
Judgments
Client management
Appointments
Messages
Legal resources
Lawyer profile management
Other lawyer services

The visual UI will be designed according to the project owner's requirements.

The existing Client Module must not be redesigned or broken while the Lawyer Module is developed.

----

3.3 Admin Module

The Admin Module is planned as the third major development phase.

The current source tree contains:

core/features/admin_module/
├── contents/
├── lawyers/
├── providers/
└── users/

The Admin Module will eventually manage:

Users
Lawyers
Legal/application content
Verification-related content
Platform administration
Other administrative functionality

----

4. Core Technology Stack

The project currently uses or is configured to use the following technologies:

Flutter
Dart
Riverpod
Firebase Core
Firebase Authentication
Cloud Firestore
Google Sign-In
Local Authentication / Biometrics
Secure Storage
Shared Preferences
Camera
Image processing
Image cropping
OCR
Google ML Kit Translation
Speech-to-Text
Text-to-Speech
PDF generation
PDF printing
File sharing
WebView
Permission Handler

Exact dependency versions are controlled by:

pubspec.yaml

The actual installed/resolved dependency versions must be determined from the project's dependency lock/resolution rather than guessed from the architecture document.

----

5. Development Philosophy
5.1 Preserve Existing Work

Existing:

Screens
Widgets
Navigation
Providers
Repositories
Services
Models
UI designs
Functionality

must not be deleted, replaced, or redesigned unless explicitly requested.

----

5.2 Avoid Duplicate Architecture

Before creating a new:

Provider
Repository
Service
Model
Widget
Notifier
Controller
State class

the existing project structure must be inspected.

If an equivalent implementation already exists, it should be reused or extended instead of creating a duplicate.

----

5.3 Separate UI From Business Logic

Screens should primarily handle:

UI presentation
User interaction
Navigation

Business logic should be handled through appropriate:

Providers
Notifiers
Repositories
Services
Models

Database operations should not be unnecessarily embedded directly inside UI widgets.

----

5.4 Riverpod as State Management

Riverpod is the planned application-wide state-management architecture.

Feature-specific state should be managed using appropriate Riverpod providers/notifiers.

Shared state should be placed at an appropriate shared architecture level.

Existing providers must be inspected before new providers are created.

----

5.5 Firebase as Backend Foundation

Firebase is the planned backend foundation for:

Authentication
User accounts
Client data
Lawyer data
Appointments
Messages
Cases
Documents
Verification-related data
Application-related data
Other cloud-backed functionality

Cloud Firestore is the planned primary database.

Firebase architecture must be introduced without unnecessarily changing existing UI.

----

6. Source of Truth

The following hierarchy should be used when determining the actual project architecture:

1. Actual LawLink360 source code
2. LAWLINK360_ARCHITECTURE.md
3. pubspec.yaml and project configuration
4. Explicit instructions from the project owner
5. Previous conversation decisions
6. AI assumptions

AI assumptions must never override the actual source code.

If the source code and this document disagree, the source code must be inspected first and this document should then be updated if the architecture has intentionally changed.

7. AI Development Tool Rules

Any AI development tool, including Cursor AI, must read this document before making significant architectural changes.

The AI must not assume that a feature needs to be created from scratch.

Before modifying the project, the AI should:

Read this document.
Inspect the relevant existing files.
Identify existing implementations.
Identify existing providers and repositories.
Identify existing models and services.
Preserve existing functionality.
Make only the requested changes.
Avoid unnecessary restructuring.
Avoid redesigning UI unless explicitly instructed.
Update this document when an important architectural decision changes.
8. Current Project Folder Architecture

The current project structure is based on the actual lib tree.

lib/
│
├── app.dart
├── main.dart
│
├── auth/
│   ├── controllers/
│   ├── models/
│   │   └── auth_state.dart
│   ├── providers/
│   │   ├── auth_provider.dart
│   │   ├── auth_providers.dart
│   │   └── auth_state_provider.dart
│   ├── repositories/
│   │   ├── auth_repository.dart
│   │   └── auth_repository_provider.dart
│   ├── screens/
│   │   ├── auth_wrapper.dart
│   │   ├── create_account_screen.dart
│   │   ├── forgot_password_screen.dart
│   │   ├── login_screen.dart
│   │   └── role_selection_screen.dart
│   ├── services/
│   │   ├── auth_service.dart
│   │   └── auth_service_provider.dart
│   └── widgets/
│       ├── animated_text_field.dart
│       ├── create_account_button.dart
│       ├── login_button.dart
│       ├── login_header.dart
│       ├── role_card.dart
│       ├── signup_header.dart
│       ├── social_login_button.dart
│       └── terms_checkbox.dart
│
├── core/
│   ├── constants/
│   ├── dialogs/
│   │   ├── enable_biometric_dialog.dart
│   │   └── premium_dialog.dart
│   │
│   ├── features/
│   │
│   ├── models/
│   │   └── dialog_type.dart
│   │
│   ├── providers/
│   │   ├── app_providers.dart
│   │   ├── providers.dart
│   │   └── theme_provider.dart
│   │
│   ├── repositories/
│   │   ├── appointment_repository.dart
│   │   ├── auth_repository.dart
│   │   ├── document_repository.dart
│   │   ├── message_repository.dart
│   │   └── procedure_repository.dart
│   │
│   ├── services/
│   │   ├── biometric_service.dart
│   │   ├── dialog_service.dart
│   │   ├── pdf_service.dart
│   │   ├── service_providers.dart
│   │   └── share_service.dart
│   │
│   ├── states/
│   │   ├── app_state.dart
│   │   ├── auth_state.dart
│   │   ├── loading_state.dart
│   │   └── user_state.dart
│   │
│   ├── theme/
│   │   ├── app_colors.dart
│   │   ├── app_radius.dart
│   │   ├── app_spacing.dart
│   │   ├── app_text_styles.dart
│   │   ├── app_theme.dart
│   │   ├── dark_theme.dart
│   │   ├── light_theme.dart
│   │   └── theme_manager.dart
│   │
│   └── utils/
│       ├── provider_helpers.dart
│       └── state_helpers.dart
│
├── features/
│   └── legal_navigator/
│       ├── components/
│       ├── data/
│       ├── enums/
│       ├── models/
│       ├── providers/
│       ├── screens/
│       ├── services/
│       ├── utils/
│       └── views/
│
├── profile/
│   ├── models/
│   │   └── user_profile.dart
│   ├── providers/
│   │   └── user_profile_provider.dart
│   └── repositories/
│       └── user_profile_repository.dart
│
└── widgets/
    ├── appbar/
    ├── appointment/
    ├── buttons/
    ├── cards/
    ├── inputs/
    └── navigation/

The above structure represents the project structure supplied by the project owner and must not be replaced with an invented architecture.

9. Core Feature Architecture

The major features currently present under:

lib/core/features/

are:

application
appointments
client
dashboard
demo
documents
find_lawyer
help_support
lawyer_module
messages
my_cases
procedure_guide
profile
scanner
settings
splash
subscription
translation
verification
admin_module

Each feature may contain different architectural layers depending on its current implementation.

Empty folders are intentional placeholders and must not automatically be treated as missing architecture.

10. Client Feature Architecture

The Client area currently contains:

core/features/client/
├── activity/
├── cases/
├── dashboard/
├── models/
├── navigation/
├── profile/
├── providers/
├── screens/
├── services/
└── widgets/

Important existing client providers include:

client/providers/
├── appointment_provider.dart
├── client_provider.dart
├── client_providers.dart
└── lawyer_provider.dart

The Client Module is the current primary development area.

11. Find Lawyer Architecture

The Find Lawyer feature currently contains:

core/features/find_lawyer/
├── models/
├── providers/
│   └── lawyer_search_provider.dart
├── screens/
│   └── lawyer_dashboard_screen.dart
├── services/
└── widgets/

The Client area also contains lawyer-related providers and UI components.

Therefore, AI tools must inspect the existing lawyer-related architecture before creating new providers or repositories.

The Find Lawyer UI includes functionality such as:

Search
Practice Areas
Top Rated Lawyers
Lawyer Cards
Lawyer Profiles
Lawyer Details
Reviews
Chat
Booking

The visual design of these screens is controlled by the project owner.

12. Appointment Architecture

Appointments have their own shared feature:

core/features/appointments/
├── data/
│   └── appointment_data.dart
├── models/
│   ├── appointment_model.dart
│   └── appointment_status.dart
├── providers/
│   ├── appointment_filter_provider.dart
│   ├── appointment_provider.dart
│   └── appointment_providers.dart
├── screens/
│   └── appointments_screen.dart
├── services/
└── widgets/

Appointments must not be duplicated unnecessarily inside individual screens.

13. Application Feature

The Application feature currently contains:

core/features/application/
├── models/
│   ├── document_category.dart
│   ├── document_subcategory.dart
│   ├── document_template.dart
│   └── form_field_model.dart
├── screens/
│   ├── ai_document_screen.dart
│   ├── application_category_screen.dart
│   ├── application_home_screen.dart
│   ├── application_screen.dart
│   ├── application_subcategory_screen.dart
│   ├── document_editor_screen.dart
│   └── document_preview_screen.dart
├── services/
│   └── document_data_service.dart
└── widgets/

The Application feature is responsible for application/document-related functionality.

14. Procedure Guide

The Procedure Guide is the planned replacement for a traditional client-facing Laws section.

Its purpose is to guide users through legal procedures rather than simply displaying legal material.

Current architecture:

core/features/procedure_guide/
├── data/
├── database/
├── models/
├── providers/
├── repository/
├── screens/
├── services/
├── utils/
└── widgets/

Current models include:

procedure_category.dart
procedure_model.dart
procedure_step.dart

Current providers include:

procedure_filter_provider.dart
procedure_provider.dart
procedure_providers.dart
procedure_state_provider.dart

Current repository:

procedure_repository.dart
procedure_repository_provider.dart

The Procedure Guide currently contains procedure data for areas including:

Banking
Civil
Criminal
Family
Government
Inheritance
Labour
Property
Registration
Traffic

The Procedure Guide is intended to provide step-by-step legal guidance and related resources.

15. Legal Navigator

Legal Navigator is a cross-feature/hybrid feature.

It is designed to show related resources depending on the content currently being viewed.

Current architecture:

features/legal_navigator/
├── components/
├── data/
├── enums/
├── models/
├── providers/
├── screens/
├── services/
├── utils/
└── views/

Current providers include:

legal_navigator_provider.dart
navigator_state_provider.dart
navigator_visibility_provider.dart
related_resource_provider.dart

The Legal Navigator should be treated as a reusable cross-feature system rather than a standalone isolated screen.

When a user views relevant content, the navigator may expose related resources.

16. Verification Feature

The Verification feature currently contains:

core/features/verification/
├── models/
├── providers/
├── screens/
├── services/
├── webview/
└── widgets/

Models include:

verification_category.dart
verification_institution.dart
verification_service.dart
verification_subcategory.dart

Provider:

verification_provider.dart

Service:

verification_data_service.dart

The Verification Hub is a major Client Module feature.

17. Translation Feature

The Translation feature currently contains:

core/features/translation/
├── models/
├── providers/
│   └── translation_provider.dart
├── screens/
│   └── translation_screen.dart
└── services/
    ├── document_service.dart
    ├── download_service.dart
    ├── ocr_service.dart
    └── translation_service.dart

Translation functionality includes support for:

Text translation
Document translation
OCR
Speech input
Document generation
Document sharing

The project also uses Google ML Kit translation and text recognition.

The translation feature may use monetization mechanisms such as premium functionality and watermark removal.

18. Scanner Feature

The Scanner feature currently contains:

core/features/scanner/
├── models/
│   └── scanner_mode.dart
├── providers/
│   └── scanner_provider.dart
├── screens/
├── services/
│   ├── camera_service.dart
│   └── crop_service.dart
└── widgets/

The scanner architecture supports document scanning and processing functionality.

Existing scanner screens include:

Smart Camera
Document Crop
Document Editor
Document Preview
My Case Files
Scanner Converter Home
19. Documents Feature

The Documents feature currently contains:

core/features/documents/
├── data/
├── models/
├── providers/
├── screens/
├── services/
└── widgets/

Existing models include:

document_model.dart
document_type.dart

Existing providers include:

document_provider.dart
document_providers.dart
document_upload_provider.dart

A shared document repository also exists under:

core/repositories/document_repository.dart
20. Messages Feature

The Messages feature currently contains:

core/features/messages/
├── data/
├── models/
├── providers/
├── screens/
├── services/
└── widgets/

Existing models include:

conversation_model.dart
message_model.dart
message_type.dart

Existing providers include:

conversation_provider.dart
message_provider.dart
message_providers.dart

Messages are intended to support communication between clients and lawyers.

21. My Cases Feature

The My Cases feature currently contains:

core/features/my_cases/
├── data/
├── models/
├── screens/
├── services/
└── widgets/

Existing models include:

case_models.dart
case_status.dart

This feature is intended to support client case management.

22. Profile Feature

The Profile feature currently contains:

core/features/profile/
├── data/
├── models/
├── providers/
├── screens/
├── services/
└── widgets/

Existing providers include:

profile_provider.dart
profile_providers.dart

There is also a separate top-level profile architecture:

lib/profile/
├── models/
├── providers/
└── repositories/

This must be considered before creating additional profile providers or repositories.

23. Settings Feature

The Settings feature currently contains:

core/features/settings/
├── data/
├── models/
├── providers/
├── screens/
├── services/
└── widgets/

Existing providers include:

settings_provider.dart
settings_providers.dart
theme_provider.dart

Shared theme architecture also exists under:

core/theme/

and:

core/providers/theme_provider.dart

AI tools must inspect existing theme implementations before changing them.

24. Help & Support

The Help & Support feature currently contains:

core/features/help_support/
├── data/
├── models/
├── screens/
├── services/
└── widgets/

Existing functionality includes:

FAQs
Help categories
Contact support
Emergency support
Social links
25. Subscription

The Subscription feature currently contains:

core/features/subscription/
├── models/
├── providers/
│   └── subscription_provider.dart
└── screens/

Subscription functionality is intended to support future premium features.

26. Dashboard Architecture

There are dashboard-related structures at multiple levels.

Current dashboard feature:

core/features/dashboard/
├── data/
├── models/
├── screens/
├── services/
└── widgets/

There is also a Client Dashboard structure:

core/features/client/dashboard/
└── dashboard_screen.dart

and:

core/features/client/screens/client_dashboard_screen.dart

Therefore, before changing dashboard architecture, the actual navigation and usage of these screens must be inspected.

AI tools must not delete or merge dashboard implementations without explicit instruction.

27. Authentication Architecture

Authentication is a separate top-level module:

lib/auth/
├── controllers/
├── models/
├── providers/
├── repositories/
├── screens/
├── services/
└── widgets/

Authentication uses Firebase Authentication.

Current authentication components include:

Login
Registration
Forgot Password
Role Selection
Auth Wrapper
Google Sign-In
Authentication State
Authentication Repository
Authentication Service

Riverpod is used for authentication state management.

The authentication architecture must be preserved while other feature modules are developed.

28. Current Authentication Riverpod Architecture

The authentication repository provider currently follows the pattern:

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(
    ref.read(authServiceProvider),
  );
});

The authentication state is managed through:

AuthNotifier
AuthState
AuthStatus
authStateProvider

The authentication notifier handles:

Email/password login
Google Sign-In
Registration
Password reset
Role saving
Logout

Authentication errors are propagated back to the calling UI.

Firebase initialization is already performed in main.dart.

29. Core Shared Architecture

Shared providers are located under:

core/providers/

Current files:

app_providers.dart
providers.dart
theme_provider.dart

Shared repositories are located under:

core/repositories/

Current repositories:

appointment_repository.dart
auth_repository.dart
document_repository.dart
message_repository.dart
procedure_repository.dart

Shared services are located under:

core/services/

Current services include:

biometric_service.dart
dialog_service.dart
pdf_service.dart
service_providers.dart
share_service.dart
30. Global State Architecture

The project contains shared state definitions under:

core/states/

Current state files include:

app_state.dart
auth_state.dart
loading_state.dart
user_state.dart

These states must be considered before creating duplicate global state classes.

31. Theme Architecture

The project contains a dedicated theme system:

core/theme/
├── app_colors.dart
├── app_radius.dart
├── app_spacing.dart
├── app_text_styles.dart
├── app_theme.dart
├── dark_theme.dart
├── light_theme.dart
└── theme_manager.dart

The project uses a visual identity centered around:

White backgrounds
Dark navy
Gold accent
Rounded cards
Modern mobile-first UI

Existing theme architecture must be reused instead of creating separate feature-specific theme systems.

32. Shared Widgets

Reusable widgets are located under:

lib/widgets/

Current groups include:

widgets/
├── appbar/
├── appointment/
├── buttons/
├── cards/
├── inputs/
└── navigation/

These widgets should be reused when appropriate.

Feature-specific widgets should remain inside their respective feature folders unless there is a clear reason to promote them to shared widgets.

33. Navigation Architecture

The Client Module contains:

core/features/client/navigation/
├── client_navigation_controller.dart
└── client_navigation_item.dart

The application also contains shared navigation widgets:

widgets/navigation/
├── app_scaffold.dart
└── quick_action_grid.dart

and:

widgets/appbar/
└── bottom_nav_bar.dart

The current Client bottom navigation design uses five primary tabs:

Home
Find Lawyer
Verification
Application
Translation

The menu/app drawer remains separate from the five-tab bottom navigation.

AI tools must not change this navigation architecture unless explicitly instructed.

34. Lawyer UI Architecture

Lawyer-related UI components already exist in several locations.

Examples include:

core/features/client/widgets/

and:

widgets/cards/
widgets/inputs/
widgets/navigation/
widgets/appbar/

Existing lawyer UI includes:

Lawyer Card
Lawyer Profile Header
Lawyer About Card
Lawyer Education Card
Lawyer Review Card
Lawyer Stats Card
Lawyer Practice Chip
Lawyer Quick Actions
Lawyer Bottom Action Bar

The project owner controls the visual design of the Lawyer Module.

The existence of lawyer UI components does not mean that the complete Lawyer Module backend architecture is finished.

35. Firebase Architecture

Firebase is the backend foundation.

Current Firebase dependencies include:

firebase_core
firebase_auth
cloud_firestore

Google Sign-In is also configured.

Firebase initialization is performed in:

lib/main.dart

The Firebase architecture should eventually support:

Authentication
     ↓
Users
     ↓
Clients
     ↓
Lawyers
     ↓
Appointments
     ↓
Cases
     ↓
Messages
     ↓
Documents
     ↓
Applications
     ↓
Verification
     ↓
Subscriptions

The exact Firestore collection structure should be documented separately once finalized.

AI tools must not invent production Firestore collections without explicit approval or an agreed database design.

36. Database Development Principle

Cloud Firestore is the planned primary database.

Database development should follow this sequence:

Existing Models
      ↓
Data Requirements
      ↓
Firestore Data Model
      ↓
Repositories
      ↓
Riverpod Providers / Notifiers
      ↓
UI Integration

The database must not be designed independently of the existing models and feature architecture.

Before creating collections, inspect:

Existing models
Existing repositories
Existing providers
Existing services
Authentication/user structure
37. Riverpod Development Strategy

Riverpod should progressively connect the existing UI to the application's business logic.

The intended pattern is:

UI Screen
    ↓
Riverpod Provider / Notifier
    ↓
Repository
    ↓
Service
    ↓
Firebase / Firestore / External API

For example:

Find Lawyer Screen
       ↓
Lawyer Provider
       ↓
Lawyer Repository
       ↓
Firestore

The exact implementation may vary by feature.

Existing providers must be reused before new providers are created.

38. Client Riverpod Development

The Client Module already contains a number of providers.

Examples include:

client_provider.dart
client_providers.dart
lawyer_provider.dart
appointment_provider.dart

Other client features already contain providers for:

Documents
Messages
Procedure Guide
Profile
Scanner
Settings
Translation
Verification
Subscription
Legal Navigator

The next development stage is to progressively connect these providers to the existing UI and repositories without changing the desired UI.

39. Repository Pattern

Repositories act as the appropriate abstraction between application state and data sources.

Existing repositories include:

core/repositories/
├── appointment_repository.dart
├── auth_repository.dart
├── document_repository.dart
├── message_repository.dart
└── procedure_repository.dart

Authentication also has its own repository layer:

auth/repositories/
├── auth_repository.dart
└── auth_repository_provider.dart

Procedure Guide has:

procedure_guide/repository/
├── procedure_repository.dart
└── procedure_repository_provider.dart

Before creating a repository, AI tools must search the existing project for an equivalent repository.

40. Service Pattern

Services are responsible for operations such as:

Authentication
Camera
OCR
Translation
PDF creation
Sharing
Biometrics
Dialog management
Document processing

Services should not unnecessarily contain UI code.

Existing service structures must be reused where possible.

41. Models

Models are distributed according to their feature.

Examples include:

Lawyer Model
Appointment Model
Document Model
Case Model
Message Model
Procedure Model
Procedure Step
Profile Model
Verification Models
Settings Models
Authentication State

Models should represent application data and should not unnecessarily contain UI presentation logic.

42. Data Layer

Several features already contain dedicated data folders.

Examples:

appointments/data/
documents/data/
messages/data/
my_cases/data/
profile/data/
procedure_guide/data/
settings/data/

Data files currently include static or feature-specific data.

These should not automatically be replaced by Firestore until the database migration/integration is intentionally planned.

43. UI Ownership Rule

The visual UI is controlled by the project owner.

AI tools may:

Implement requested UI changes
Connect existing UI to providers
Add required loading/error states
Connect buttons to functionality
Fix UI bugs
Improve technical integration when requested

AI tools must not:

Redesign screens without permission
Change the navigation structure without permission
Replace the owner's chosen UI style
Remove existing visual components because they appear unnecessary
44. Existing UI Must Be Preserved During Backend Work

Backend and Riverpod integration must be performed around the existing UI.

The preferred sequence is:

Existing UI
    ↓
Provider
    ↓
Repository
    ↓
Service
    ↓
Firebase

not:

Firebase
    ↓
Generate a completely new UI

The goal is to make the existing LawLink360 interface functional without losing the design already created.

45. Static Data vs Production Data

Some existing features currently use local/static data.

Examples include:

Lawyer cards
Procedure data
Application data
Verification data
Dashboard data
Help data
Profile data
Appointment demo data
Message demo data

Static data should not be removed simply because Firestore integration is planned.

Migration should be performed feature-by-feature.

46. Procedure Guide Content Strategy

The Procedure Guide is intended to provide structured legal procedure information.

The application should ultimately use structured legal content rather than simply displaying law PDFs to users.

The planned approach is:

Official Legal Sources
        ↓
Extraction / Cleaning
        ↓
Structured Legal Data
        ↓
Database
        ↓
LawLink360 Procedure Guide

The Procedure Guide should be designed so that future search and AI functionality can operate on structured legal information.

47. Legal Navigator Architecture Principle

Legal Navigator is a master/hybrid feature.

It can connect a user from one legal resource to other relevant resources.

For example:

Procedure
   ↓
Related Legal Resources
   ↓
Application
   ↓
Documents
   ↓
Find Lawyer

The Legal Navigator should remain independent enough to operate across multiple features.

48. Authentication and User Roles

Authentication supports different user roles.

Current authentication includes:

Login
Registration
Google Sign-In
Role Selection
Authentication State
Logout
Password Reset

The planned major roles are:

Client
Lawyer
Admin

Role-specific functionality must be separated while allowing shared authentication infrastructure.

49. Security Principle

Sensitive operations should use appropriate secure mechanisms.

The project currently includes:

Firebase Authentication
Local Authentication
Flutter Secure Storage
Shared Preferences

Credentials and sensitive authentication information must not be stored directly in ordinary application state or hard-coded into source code.

50. Development Sequence

The overall intended development sequence is:

Phase 1
Client UI
    ↓
Client Riverpod
    ↓
Client Repositories
    ↓
Firebase / Firestore
    ↓
Client Feature Completion

Phase 2
Lawyer UI
    ↓
Lawyer Riverpod
    ↓
Lawyer Repositories
    ↓
Firebase / Firestore
    ↓
Lawyer Feature Completion

Phase 3
Admin UI
    ↓
Admin Riverpod
    ↓
Admin Repositories
    ↓
Firebase / Firestore
    ↓
Admin Feature Completion

This sequence can change when technically necessary, but changes should be documented.

51. Development Status
Completed / Existing Foundations

The project already contains:

Flutter application foundation
Authentication architecture
Firebase dependencies
Firebase initialization
Riverpod dependencies
Authentication Riverpod architecture
Client UI architecture
Find Lawyer UI
Lawyer profile UI
Appointment UI
Application UI
Translation UI
Verification UI
Scanner UI
Documents UI
Messages UI
My Cases UI
Procedure Guide
Legal Navigator
Profile
Settings
Help & Support
Subscription foundation
Lawyer Module foundation
Admin Module foundation
Shared theme system
Shared widgets
Shared repositories
Shared services

The exact implementation state of individual files must always be checked in the source code.

52. Current Priority

The current priority is:

Complete and stabilize Client Module architecture
        ↓
Connect Client features to Riverpod
        ↓
Connect repositories/services
        ↓
Integrate Firebase / Firestore
        ↓
Complete Client functionality
        ↓
Proceed to Lawyer Module

The visual design should continue to be controlled by the project owner.

53. Rule Against Guessing

This is a critical LawLink360 development rule.

If an AI tool does not know whether a file, provider, repository, service, model, screen or widget already exists, it must inspect the project before creating one.

It must not say:

"This file probably doesn't exist."

It must verify.

If the requested file is empty, the AI should treat it as an intentional architectural placeholder unless there is evidence that it should contain code.

54. Rule Against Unnecessary Refactoring

AI tools must not perform broad refactoring when the requested task is narrow.

For example, if the request is:

Connect Find Lawyer to Riverpod

the AI should not automatically:

Rebuild the entire Client Module
Rename folders
Move screens
Replace navigation
Rewrite UI
Replace existing repositories
Create a new architecture
Delete existing providers

Only the required changes should be made.

55. Rule for New Features

When a new feature is requested, the AI should follow:

1. Inspect existing structure
2. Identify related files
3. Identify existing models
4. Identify existing providers
5. Identify existing repositories
6. Identify existing services
7. Identify navigation
8. Determine what is missing
9. Implement only the missing pieces
10. Preserve existing UI
11. Test compilation
12. Update architecture documentation if necessary
56. Rule for Existing Features

When working on an existing feature:

DO NOT START FROM ZERO.

First determine:

What already exists
What is complete
What is empty
What is connected
What is not connected
What is static
What is Firebase-backed
What is only UI

Then make the requested changes.

57. Rule for Empty Folders and Files

Empty folders are part of the planned architecture unless proven otherwise.

For example:

core/features/find_lawyer/models/
core/features/find_lawyer/services/
core/features/find_lawyer/widgets/

may currently be empty while the feature is still being developed.

Do not automatically remove empty folders.

Do not create unnecessary files merely to populate empty folders.

58. Rule for Architecture Documentation

This document is a living architectural constitution.

Whenever a major architectural decision changes, update this document.

Examples:

New module
New major feature
New database architecture
New authentication architecture
New navigation structure
Riverpod restructuring
Repository restructuring
Firebase architecture
Major folder restructuring

Minor UI changes do not need to be documented here.

59. Rule for Cursor AI

Cursor AI may be used extensively for implementation, but it must follow this constitution.

Recommended instruction:

Before modifying LawLink360:

1. Read docs/LAWLINK360_ARCHITECTURE.md.
2. Inspect the relevant existing source files.
3. Do not assume a component is missing.
4. Do not create duplicate providers, repositories, services or models.
5. Do not redesign existing UI unless explicitly instructed.
6. Preserve existing navigation.
7. Preserve existing functionality.
8. Make only the requested changes.
9. Use Riverpod according to the existing architecture.
10. Use repositories/services for backend operations.
11. Do not invent Firestore collections without an approved database design.
12. Verify the project compiles after changes.
13. Report exactly which files were created or modified.
60. Final Architectural Principle

LawLink360 is being built as a long-term scalable legal platform.

The objective is not merely to make individual screens work.

The objective is to create a maintainable system where:

UI
 ↓
Riverpod
 ↓
Repository
 ↓
Service
 ↓
Firebase / Firestore

can evolve independently while remaining connected through clearly defined responsibilities.

The project owner's existing UI and product decisions are authoritative.

The actual source code is the ultimate technical source of truth.

This document exists to prevent:

Architectural confusion
Duplicate code
Accidental deletion
Unnecessary refactoring
Incorrect assumptions
Loss of previous development decisions
AI tools misunderstanding the project structure

Any future AI-assisted development must use this document together with the actual source code.

END OF LAWLINK360 ARCHITECTURE & DEVELOPMENT CONSTITUTION

### One important point

I have **not invented missing files** in your tree. For example, your `find_lawyer` folder really has only:

```text
models/
providers/
    lawyer_search_provider.dart
screens/
    lawyer_dashboard_screen.dart
services/
widgets/

So the document records that structure rather than pretending that additional Find Lawyer files exist.