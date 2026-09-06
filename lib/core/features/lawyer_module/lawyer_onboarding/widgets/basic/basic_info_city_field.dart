
import 'package:flutter/material.dart';

class BasicInfoCityField extends StatefulWidget {
  final String? selectedCity;
  final ValueChanged<String> onChanged;

  const BasicInfoCityField({
    super.key,
    required this.selectedCity,
    required this.onChanged,
  });

  static const List<String> cities = [
    "Islamabad",
    "Lahore",
    "Karachi",
    "Rawalpindi",
    "Faisalabad",
    "Multan",
    "Peshawar",
    "Quetta",
    "Sialkot",
    "Gujranwala",
    "Hyderabad",
    "Bahawalpur",
    "Abbottabad",
    "Sargodha",
    "Gujrat",
    "Mardan",
    "Mingora",
    "Kasur",
    "Sheikhupura",
    "Jhelum",
    "Okara",
    "Rahim Yar Khan",
    "Sahiwal",
    "Dera Ghazi Khan",
    "Wah Cantt",
    "Nawabshah",
    "Larkana",
    "Sukkur",
    "Mirpur",
    "Muzaffarabad",
    "Other",
  ];

  @override
  State<BasicInfoCityField> createState() => _BasicInfoCityFieldState();
}

class _BasicInfoCityFieldState extends State<BasicInfoCityField> {
  final TextEditingController _searchController = TextEditingController();

  List<String> _filteredCities = [];

  @override
  void initState() {
    super.initState();
    _filteredCities = BasicInfoCityField.cities;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _openCitySelector() {
    _searchController.clear();
    _filteredCities = BasicInfoCityField.cities;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            void filter(String query) {
              final search = query.trim().toLowerCase();

              setSheetState(() {
                if (search.isEmpty) {
                  _filteredCities = BasicInfoCityField.cities;
                } else {
                  _filteredCities = BasicInfoCityField.cities
                      .where(
                        (city) =>
                            city.toLowerCase().contains(search),
                      )
                      .toList();
                }
              });
            }

            return SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 20,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                ),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.65,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Select Your City",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF13294B),
                        ),
                      ),

                      const SizedBox(height: 6),

                      const Text(
                        "Search for your city or enter it manually.",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),

                      const SizedBox(height: 16),

                      TextField(
                        controller: _searchController,
                        autofocus: true,
                        onChanged: filter,
                        decoration: InputDecoration(
                          hintText: "Search city...",
                          prefixIcon: const Icon(
                            Icons.search_rounded,
                            color: Color(0xFFD4AF37),
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF5F7FB),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      Expanded(
                        child: ListView(
                          children: [
                            ..._filteredCities
                                .where((city) => city != "Other")
                                .map(
                                  (city) => ListTile(
                                    leading: const Icon(
                                      Icons.location_city_outlined,
                                      color: Color(0xFFD4AF37),
                                    ),
                                    title: Text(city),
                                    trailing:
                                        widget.selectedCity == city
                                            ? const Icon(
                                                Icons.check_circle,
                                                color: Color(0xFFD4AF37),
                                              )
                                            : null,
                                    onTap: () {
                                      widget.onChanged(city);
                                      Navigator.pop(sheetContext);
                                    },
                                  ),
                                ),

                            const Divider(height: 20),

                            ListTile(
                              leading: const Icon(
                                Icons.edit_location_alt_outlined,
                                color: Color(0xFFD4AF37),
                              ),
                              title: const Text(
                                "Enter another city",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF13294B),
                                ),
                              ),
                              subtitle: const Text(
                                "Can't find your city? Enter it manually.",
                              ),
                              onTap: () {
                                Navigator.pop(sheetContext);
                                _showManualCityDialog();
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showManualCityDialog() {
    final controller = TextEditingController(
      text: widget.selectedCity == "Other"
          ? ""
          : widget.selectedCity ?? "",
    );

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            "Enter Your City",
            style: TextStyle(
              color: Color(0xFF13294B),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: TextField(
            controller: controller,
            autofocus: true,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              hintText: "e.g. Chakwal",
              prefixIcon: const Icon(
                Icons.location_city_outlined,
                color: Color(0xFFD4AF37),
              ),
              filled: true,
              fillColor: const Color(0xFFF5F7FB),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final city = controller.text.trim();

                if (city.isEmpty) {
                  return;
                }

                widget.onChanged(city);

                Navigator.pop(dialogContext);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD4AF37),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Save City",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const navy = Color(0xFF13294B);
    const gold = Color(0xFFD4AF37);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "City",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: navy,
          ),
        ),

        const SizedBox(height: 8),

        GestureDetector(
          onTap: _openCitySelector,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.transparent,
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.location_city_outlined,
                  color: gold,
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Text(
                    widget.selectedCity == null ||
                            widget.selectedCity!.trim().isEmpty
                        ? "Select or enter your city"
                        : widget.selectedCity!,
                    style: TextStyle(
                      fontSize: 15,
                      color: widget.selectedCity == null ||
                              widget.selectedCity!.trim().isEmpty
                          ? Colors.grey
                          : navy,
                      fontWeight: widget.selectedCity == null ||
                              widget.selectedCity!.trim().isEmpty
                          ? FontWeight.normal
                          : FontWeight.w500,
                    ),
                  ),
                ),

                const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: navy,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
