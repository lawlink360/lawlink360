import 'package:flutter/material.dart';

class ChatDocumentMessage extends StatelessWidget {
  const ChatDocumentMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const CircleAvatar(
            radius: 18,
            backgroundColor: Color(0xFFD4AF37),
            child: Icon(
              Icons.person,
              color: Colors.white,
              size: 18,
            ),
          ),

          const SizedBox(width: 10),

          Flexible(
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Text(
                    "I've reviewed your document.",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F7FB),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Row(
                      children: [

                        Icon(
                          Icons.picture_as_pdf,
                          color: Colors.red,
                          size: 36,
                        ),

                        SizedBox(width: 12),

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [

                              Text(
                                "Case_Document.pdf",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              SizedBox(height: 4),

                              Text(
                                "2.4 MB",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),

                            ],
                          ),
                        ),

                        Icon(Icons.download),

                      ],
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    "09:25 AM",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),

                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}