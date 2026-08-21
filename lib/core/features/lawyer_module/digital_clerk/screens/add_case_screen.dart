import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/case_model.dart';
import '../models/client_model.dart';
import '../providers/clerk_providers.dart';

class AddCaseScreen extends ConsumerStatefulWidget {
  const AddCaseScreen({
    super.key,
    this.caseToEdit,
  });

  final CaseModel? caseToEdit;

  @override
  ConsumerState<AddCaseScreen> createState() => _AddCaseScreenState();
}

class _AddCaseScreenState extends ConsumerState<AddCaseScreen> {
  final _formKey = GlobalKey<FormState>();

  final _caseTitleController = TextEditingController();
  final _caseNumberController = TextEditingController();
  final _clientNameController = TextEditingController();
  final _oppositePartyController = TextEditingController();
  final _judgeNameController = TextEditingController();
  final _notesController = TextEditingController();

  String _caseType = 'Civil';
  String _status = 'Active';

  DateTime? _nextHearingDate;
  TimeOfDay? _hearingTime;

  ClientModel? _selectedClient;

  @override
  void initState() {
    super.initState();

    final existingCase = widget.caseToEdit;

    if (existingCase != null) {
      _caseTitleController.text = existingCase.caseTitle;
      _caseNumberController.text = existingCase.caseNumber;
      _clientNameController.text = existingCase.clientName;
      _oppositePartyController.text = existingCase.oppositeParty;
      _judgeNameController.text = existingCase.judgeName;
      _notesController.text = existingCase.notes;

      _caseType = existingCase.caseType;
      _nextHearingDate = existingCase.nextHearingDate;
      _status = existingCase.status;
    }
  }

  @override
  void dispose() {
    _caseTitleController.dispose();
    _caseNumberController.dispose();
    _clientNameController.dispose();
    _oppositePartyController.dispose();
    _judgeNameController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _selectHearingDate() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: _nextHearingDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      setState(() {
        _nextHearingDate = selectedDate;
      });
    }
  }

  Future<void> _selectHearingTime() async {
    final selectedTime = await showTimePicker(
      context: context,
      initialTime: _hearingTime ?? TimeOfDay.now(),
    );

    if (selectedTime != null) {
      setState(() {
        _hearingTime = selectedTime;
      });
    }
  }

  void _selectClient(ClientModel client) {
    setState(() {
      _selectedClient = client;
      _clientNameController.text = client.name;
    });
  }

  void _saveCase() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_nextHearingDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select the next hearing date.'),
        ),
      );
      return;
    }

    final now = DateTime.now();
    final existingCase = widget.caseToEdit;

    final typedClientName =
        _clientNameController.text.trim();

    if (typedClientName.isEmpty) {
      return;
    }

    String clientId;
    String clientName;

    if (_selectedClient != null) {
      // Existing client selected.
      clientId = _selectedClient!.id;
      clientName = _selectedClient!.name;
    } else if (existingCase != null) {
      // Editing an existing case and no new client was selected.
      clientId = existingCase.clientId;
      clientName = typedClientName;
    } else {
      // Completely new client typed manually.
      final newClientId =
          'client_${now.microsecondsSinceEpoch}';

      final newClient = ClientModel(
        id: newClientId,
        name: typedClientName,
        phone: '',
        email: '',
        address: '',
        cnic: null,
        notes: '',
        createdAt: now,
        updatedAt: now,
      );

      ref
          .read(clerkClientsProvider.notifier)
          .addClient(newClient);

      clientId = newClientId;
      clientName = typedClientName;
    }

    final updatedCase = CaseModel(
      id: existingCase?.id ??
          'case_${now.microsecondsSinceEpoch}',
      caseTitle: _caseTitleController.text.trim(),
      caseNumber: _caseNumberController.text.trim(),
      clientId: clientId,
      clientName: clientName,
      courtName: '',
      caseType: _caseType,
      oppositeParty: _oppositePartyController.text.trim(),
      judgeName: _judgeNameController.text.trim(),
      nextHearingDate: _nextHearingDate,
      hearingTime: _hearingTime?.format(context),
      status: _status,
      notes: _notesController.text.trim(),
      createdAt: existingCase?.createdAt ?? now,
      updatedAt: now,
    );

    if (existingCase == null) {
      ref
          .read(clerkCasesProvider.notifier)
          .addCase(updatedCase);
    } else {
      ref
          .read(clerkCasesProvider.notifier)
          .updateCase(updatedCase);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          existingCase == null
              ? 'Case added successfully.'
              : 'Case updated successfully.',
        ),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final clients = ref.watch(clerkClientsProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Text(
          widget.caseToEdit == null ? 'Add Case' : 'Edit Case',
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            color: Color(0xFF13294B),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Color(0xFF13294B),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            16,
            20,
            16,
            30,
          ),
          children: [
            _sectionTitle(
              icon: Icons.folder_outlined,
              title: 'Case Information',
            ),

            const SizedBox(height: 12),

            _textField(
              controller: _caseTitleController,
              label: 'Case Title',
              hint: 'Enter case title',
              icon: Icons.gavel_outlined,
              required: true,
            ),

            _clientSelector(
              clients: clients,
            ),

            _textField(
              controller: _oppositePartyController,
              label: 'Opposite Party Name',
              hint: 'Enter opposite party name',
              icon: Icons.people_outline,
              required: true,
            ),

            _textField(
              controller: _judgeNameController,
              label: 'Judge Name',
              hint: 'Enter judge name',
              icon: Icons.person_pin_outlined,
              required: true,
            ),

            _textField(
              controller: _caseNumberController,
              label: 'Case Number',
              hint: 'e.g. 123/2026',
              icon: Icons.numbers_outlined,
            ),

            _dropdownField(
              label: 'Case Type',
              value: _caseType,
              items: const [
                'Civil',
                'Criminal',
                'Family',
                'Constitutional',
                'Corporate',
                'Labour',
                'Property',
                'Other',
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _caseType = value;
                  });
                }
              },
            ),

            const SizedBox(height: 10),

            _sectionTitle(
              icon: Icons.event_outlined,
              title: 'Next Hearing',
            ),

            const SizedBox(height: 12),

            _dateField(),

            const SizedBox(height: 12),

            _timeField(),

            const SizedBox(height: 10),

            _dropdownField(
              label: 'Case Status',
              value: _status,
              items: const [
                'Active',
                'Pending',
                'Closed',
                'Disposed',
                'On Hold',
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _status = value;
                  });
                }
              },
            ),

            const SizedBox(height: 10),

            _sectionTitle(
              icon: Icons.notes_outlined,
              title: 'Case Notes',
            ),

            const SizedBox(height: 12),

            _textField(
              controller: _notesController,
              label: 'Notes',
              hint: 'Add any important case notes',
              icon: Icons.notes_outlined,
              maxLines: 5,
            ),

            const SizedBox(height: 28),

            SizedBox(
              height: 52,
              child: ElevatedButton.icon(
                onPressed: _saveCase,
                icon: const Icon(Icons.save_outlined),
                label: Text(
                  widget.caseToEdit == null
                      ? 'Save Case'
                      : 'Update Case',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF13294B),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _clientSelector({
    required List<ClientModel> clients,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Autocomplete<ClientModel>(
        displayStringForOption: (client) => client.name,

        initialValue: TextEditingValue(
          text: _clientNameController.text,
        ),

        optionsBuilder: (TextEditingValue textEditingValue) {
          final query = textEditingValue.text.trim().toLowerCase();

          if (query.isEmpty) {
            return clients;
          }

          return clients.where(
            (client) => client.name.toLowerCase().contains(query),
          );
        },

        onSelected: (ClientModel client) {
          _selectClient(client);
        },

        fieldViewBuilder: (
          BuildContext context,
          TextEditingController fieldController,
          FocusNode focusNode,
          VoidCallback onFieldSubmitted,
        ) {
          // Keep our existing controller synchronized.
          if (fieldController.text != _clientNameController.text) {
            fieldController.value = _clientNameController.value;
          }

          fieldController.addListener(() {
            if (_clientNameController.text != fieldController.text) {
              _clientNameController.value = fieldController.value;

              if (_selectedClient != null &&
                  _selectedClient!.name != fieldController.text.trim()) {
                _selectedClient = null;
              }
            }
          });

          return TextFormField(
            controller: fieldController,
            focusNode: focusNode,
            decoration: InputDecoration(
              labelText: 'Client Name',
              hintText: 'Select existing or type new client',
              prefixIcon: const Icon(
                Icons.person_outline,
                color: Color(0xFF13294B),
              ),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(
                  color: Color(0xFFE5E7EB),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(
                  color: Color(0xFFE5E7EB),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(
                  color: Color(0xFFD4AF37),
                  width: 1.5,
                ),
              ),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Client Name is required';
              }

              return null;
            },
          );
        },

        optionsViewBuilder: (
          BuildContext context,
          AutocompleteOnSelected<ClientModel> onSelected,
          Iterable<ClientModel> options,
        ) {
          return Align(
            alignment: Alignment.topLeft,
            child: Material(
              elevation: 6,
              borderRadius: BorderRadius.circular(14),
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 240,
                  maxWidth: 350,
                ),
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  shrinkWrap: true,
                  itemCount: options.length,
                  itemBuilder: (context, index) {
                    final client = options.elementAt(index);

                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor:
                            const Color(0xFF13294B).withValues(alpha: 0.08),
                        child: const Icon(
                          Icons.person_outline,
                          color: Color(0xFF13294B),
                          size: 20,
                        ),
                      ),
                      title: Text(
                        client.name,
                        style: const TextStyle(
                          color: Color(0xFF13294B),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        client.phone,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                      onTap: () {
                        onSelected(client);
                      },
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _sectionTitle({
    required IconData icon,
    required String title,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFD4AF37)
                .withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            size: 20,
            color: const Color(0xFFD4AF37),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: Color(0xFF13294B),
          ),
        ),
      ],
    );
  }

  Widget _textField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    bool required = false,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: Icon(
            icon,
            color: const Color(0xFF13294B),
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Color(0xFFE5E7EB),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Color(0xFFE5E7EB),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Color(0xFFD4AF37),
              width: 1.5,
            ),
          ),
        ),
        validator: required
            ? (value) {
                if (value == null ||
                    value.trim().isEmpty) {
                  return '$label is required';
                }
                return null;
              }
            : null,
      ),
    );
  }

  Widget _dropdownField({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: DropdownButtonFormField<String>(
        initialValue: value,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: const Icon(
            Icons.category_outlined,
            color: Color(0xFF13294B),
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Color(0xFFE5E7EB),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Color(0xFFE5E7EB),
            ),
          ),
        ),
        items: items.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _dateField() {
    return InkWell(
      onTap: _selectHearingDate,
      borderRadius: BorderRadius.circular(14),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'Next Hearing Date *',
          prefixIcon: const Icon(
            Icons.calendar_today_outlined,
            color: Color(0xFF13294B),
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Color(0xFFE5E7EB),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Color(0xFFE5E7EB),
            ),
          ),
        ),
        child: Text(
          _nextHearingDate == null
              ? 'Select hearing date'
              : '${_nextHearingDate!.day.toString().padLeft(2, '0')}/'
                    '${_nextHearingDate!.month.toString().padLeft(2, '0')}/'
                    '${_nextHearingDate!.year}',
          style: TextStyle(
            color: _nextHearingDate == null
                ? Colors.grey.shade600
                : const Color(0xFF1F2937),
          ),
        ),
      ),
    );
  }

  Widget _timeField() {
    return InkWell(
      onTap: _selectHearingTime,
      borderRadius: BorderRadius.circular(14),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'Hearing Time',
          prefixIcon: const Icon(
            Icons.access_time_outlined,
            color: Color(0xFF13294B),
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Color(0xFFE5E7EB),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Color(0xFFE5E7EB),
            ),
          ),
        ),
        child: Text(
          _hearingTime == null
              ? 'Select hearing time'
              : _hearingTime!.format(context),
          style: TextStyle(
            color: _hearingTime == null
                ? Colors.grey.shade600
                : const Color(0xFF1F2937),
          ),
        ),
      ),
    );
  }
}