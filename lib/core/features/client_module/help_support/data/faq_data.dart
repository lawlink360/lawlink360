import '../models/faq_items.dart';

class FaqData {
  static const List<FaqItem> items = [
    FaqItem(
      question: "How do I find a lawyer?",
      answer:
          "Use the Find Lawyer section to search for verified lawyers by specialization and location.",
    ),

    FaqItem(
      question: "How can I verify a document?",
      answer:
          "Open the Verification Hub and upload or scan your document for verification.",
    ),

    FaqItem(
      question: "How do I download legal documents?",
      answer:
          "Complete the document form, preview it, and use the Download option to save it as PDF or DOCX.",
    ),

    FaqItem(
      question: "How do I upgrade to Premium?",
      answer:
          "Go to Profile > Premium and choose the subscription plan that best suits your needs.",
    ),

    FaqItem(
      question: "Can I use LawLink360 offline?",
      answer:
          "Some features such as saved documents are available offline, while online services require an internet connection.",
    ),
  ];
}