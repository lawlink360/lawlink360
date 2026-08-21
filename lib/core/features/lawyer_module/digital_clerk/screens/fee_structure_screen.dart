import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/fee_item_model.dart';
import '../models/fee_structure_model.dart';
import '../providers/fee_structure_provider.dart';
import 'package:lawlink360/core/services/download_service.dart';
import 'package:lawlink360/core/services/share_service.dart';


class FeeStructureScreen extends ConsumerStatefulWidget {
  const FeeStructureScreen({
    super.key,
    this.feeStructure,
  });

  final FeeStructureModel? feeStructure;

  @override
  ConsumerState<FeeStructureScreen> createState() =>
      _FeeStructureScreenState();
}

class _FeeStructureScreenState
    extends ConsumerState<FeeStructureScreen> {
  final _formKey = GlobalKey<FormState>();

  // ============================================================
  // SERVICES
  // ============================================================

  final DownloadService _downloadService = const DownloadService();
  final ShareService _shareService = const ShareService();

  // ============================================================
  // BASIC INFORMATION
  // ============================================================

  final _firmNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _websiteController = TextEditingController();

  final _clientNameController = TextEditingController();
  final _caseTitleController = TextEditingController();
  final _oppositePartyController = TextEditingController();
  final _caseNumberController = TextEditingController();
  final _natureController = TextEditingController();
  final _dateController = TextEditingController();
  final _dueDateController = TextEditingController();

  final _notesController = TextEditingController();

  // ============================================================
  // FEE CONTROLLERS
  // ============================================================

  final _lawyerConsultationController =
      TextEditingController();

  final _lawyerServicesController =
      TextEditingController();

  final _draftingController =
      TextEditingController();

  final _clerkController =
      TextEditingController();

  final _paidController =
      TextEditingController();

  // ============================================================
  // MISCELLANEOUS FEES CONTROLLERS
  // ============================================================

  final _courtStampController = TextEditingController();
  final _commissionController = TextEditingController();
  final _newspaperController = TextEditingController();
  final _noticeSummonController = TextEditingController();

  // ============================================================
  // MISCELLANEOUS FEES ITEMS
  // ============================================================

  final List<_FeeRowController> _miscellaneousFeeItems = [];

  // ============================================================
  // DATE
  // ============================================================

  @override
  void initState() {
    super.initState();

    final existing = widget.feeStructure;

    if (existing != null) {
      _loadExisting(existing);
    } else {
      _dateController.text = _formatDate(DateTime.now());
    }
  }

  void _loadExisting(FeeStructureModel existing) {
    _firmNameController.text = '';
    _addressController.text = '';
    _phoneController.text = '';
    _emailController.text = '';
    _websiteController.text = '';

    _clientNameController.text =
        existing.clientName ?? '';

    _caseTitleController.text =
        existing.caseTitle ?? '';

    _oppositePartyController.text =
        existing.oppositeParty ?? '';

    _caseNumberController.text =
        existing.caseNumber ?? '';

    _dateController.text =
        _formatDate(existing.createdAt);

    _notesController.text =
        existing.notes;

    // Load existing fee items into the standard rows.
    for (final item in existing.items) {
      final description =
          item.description.toLowerCase();

      if (description.contains('consultation')) {
        _lawyerConsultationController.text =
            item.amount.toStringAsFixed(0);
      } else if (description.contains('lawyer services') ||
          description.contains('lawyer fee')) {
        _lawyerServicesController.text =
            item.amount.toStringAsFixed(0);
      } else if (description.contains('drafting')) {
        _draftingController.text =
            item.amount.toStringAsFixed(0);
      } else if (description.contains('clerk')) {
        _clerkController.text =
            item.amount.toStringAsFixed(0);
      } else {
        _miscellaneousFeeItems.add(
          _FeeRowController(
            description: item.description,
            amount: item.amount.toStringAsFixed(0),
          ),
        );
      }
    }

    _paidController.text =
        existing.paidAmount == 0
            ? ''
            : existing.paidAmount.toStringAsFixed(0);
  }

  @override
  void dispose() {
    _firmNameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _websiteController.dispose();

    _clientNameController.dispose();
    _caseTitleController.dispose();
    _oppositePartyController.dispose();
    _caseNumberController.dispose();
    _natureController.dispose();
    _dateController.dispose();
    _dueDateController.dispose();

    _notesController.dispose();

    _lawyerConsultationController.dispose();
    _lawyerServicesController.dispose();
    _draftingController.dispose();
    _clerkController.dispose();

    _paidController.dispose();

    _courtStampController.dispose();
    _commissionController.dispose();
    _newspaperController.dispose();
    _noticeSummonController.dispose();

    for (final fee in _miscellaneousFeeItems) {
      fee.dispose();
    }

    super.dispose();
  }

  // ============================================================
  // HELPERS
  // ============================================================

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  double _amount(TextEditingController controller) {
    final value = controller.text
        .replaceAll(',', '')
        .replaceAll('Rs.', '')
        .trim();

    return double.tryParse(value) ?? 0;
  }

  String _formatAmount(double amount) {
    final formatted = amount
        .toStringAsFixed(2)
        .replaceAllMapped(
          RegExp(r'\B(?=(\d{3})+(?!\d))'),
          (match) => ',',
        );

    return 'Rs. $formatted/-';
  }

  double get _totalAmount {
    double total = 0;

    total += _amount(_lawyerConsultationController);
    total += _amount(_lawyerServicesController);
    total += _amount(_draftingController);
    total += _amount(_clerkController);

    total += _amount(_courtStampController);
    total += _amount(_commissionController);
    total += _amount(_newspaperController);
    total += _amount(_noticeSummonController);

    for (final fee in _miscellaneousFeeItems) {
      total += fee.amount;
    }

    return total;
  }

  double get _paidAmount {
    return _amount(_paidController);
  }

  double get _pendingAmount {
    final pending = _totalAmount - _paidAmount;
    return pending < 0 ? 0 : pending;
  }

  Future<void> _selectDueDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF13294B),
              secondary: Color(0xFFD4AF37),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        _dueDateController.text =
            _formatDate(pickedDate);
      });
    }
  }

  // ============================================================
  // ADD MISCELLANEOUS FEE
  // ============================================================

  Future<void> _addMiscellaneousFee() async {
    final descriptionController =
        TextEditingController();

    final amountController =
        TextEditingController();

    final result =
        await showDialog<_FeeRowController>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Add Fee',
            style: TextStyle(
              color: Color(0xFF13294B),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Fee Description',
                  hintText: 'Enter fee description',
                ),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: amountController,
                keyboardType:
                    const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  prefixText: 'Rs. ',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(0xFF13294B),
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                final description =
                    descriptionController.text.trim();

                final amount =
                    double.tryParse(
                          amountController.text
                              .trim()
                              .replaceAll(',', ''),
                        ) ??
                        0;

                if (description.isEmpty ||
                    amount <= 0) {
                  return;
                }

                Navigator.pop(
                  dialogContext,
                  _FeeRowController(
                    description: description,
                    amount:
                        amount.toStringAsFixed(0),
                  ),
                );
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );

    descriptionController.dispose();
    amountController.dispose();

    if (result != null) {
      setState(() {
        _miscellaneousFeeItems.add(result);
      });
    }
  }

  // ============================================================
  // REMOVE MISCELLANEOUS FEE
  // ============================================================

  void _removeMiscellaneousFee(int index) {
    setState(() {
      final fee = _miscellaneousFeeItems.removeAt(index);
      fee.dispose();
    });
  }

  // ============================================================
  // SAVE
  // ============================================================

  void _saveFeeStructure() {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    final now = DateTime.now();

    final List<FeeItemModel> items = [];

    void addItem(
      String description,
      TextEditingController controller,
    ) {
      final amount = _amount(controller);

      if (amount > 0) {
        items.add(
          FeeItemModel(
            id:
                'fee_item_${DateTime.now().microsecondsSinceEpoch}_${items.length}',
            description: description,
            amount: amount,
          ),
        );
      }
    }

    addItem(
      'Lawyer Consultation Fee',
      _lawyerConsultationController,
    );

    addItem(
      'Lawyer Services / Fee',
      _lawyerServicesController,
    );

    addItem(
      'Drafting Fee',
      _draftingController,
    );

    addItem(
      'Clerk Fee',
      _clerkController,
    );

    addItem(
      'Court / Stamp Duty',
      _courtStampController,
    );

    addItem(
      'Local Commission Fee',
      _commissionController,
    );

    addItem(
      'Newspaper Expenses',
      _newspaperController,
    );

    addItem(
      'Notice / Summon Expenses',
      _noticeSummonController,
    );

    for (final fee in _miscellaneousFeeItems) {
      if (fee.amount > 0) {
        items.add(
          FeeItemModel(
            id:
                'fee_item_${DateTime.now().microsecondsSinceEpoch}_${items.length}',
            description: fee.description,
            amount: fee.amount,
          ),
        );
      }
    }

    if (items.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please enter at least one fee.',
          ),
        ),
      );
      return;
    }

    final existing = widget.feeStructure;

    final caseTitle = [
      _caseTitleController.text.trim(),
      _oppositePartyController.text.trim(),
    ]
        .where((value) => value.isNotEmpty)
        .join(' V/S ');

    final feeStructure = FeeStructureModel(
      id: existing?.id ??
          'fee_structure_${now.microsecondsSinceEpoch}',

      clientId: existing?.clientId,

      clientName:
          _clientNameController.text.trim(),

      caseId: existing?.caseId,

      caseTitle: caseTitle,

      caseNumber:
          _caseNumberController.text.trim(),

      items: items,

      totalAmount: _totalAmount,

      paidAmount: _paidAmount,

      remainingAmount: _pendingAmount,

      installments:
          existing?.installments ?? [],

      notes:
          _notesController.text.trim(),

      createdAt:
          existing?.createdAt ?? now,

      updatedAt: now,
    );

    if (existing == null) {
      ref
          .read(feeStructureProvider.notifier)
          .addFeeStructure(feeStructure);
    } else {
      ref
          .read(feeStructureProvider.notifier)
          .updateFeeStructure(feeStructure);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          existing == null
              ? 'Fee structure saved successfully.'
              : 'Fee structure updated successfully.',
        ),
      ),
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF5F7FB),

      appBar: AppBar(
        backgroundColor:
            const Color(0xFF13294B),
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Fee Structure',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Form(
        key: _formKey,
        child: ListView(
          padding:
              const EdgeInsets.fromLTRB(
            14,
            16,
            14,
            35,
          ),
          children: [
            _feeDocument(),

            const SizedBox(height: 20),

            // SAVE
            SizedBox(
              height: 52,
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed:
                    _saveFeeStructure,
                icon: const Icon(
                  Icons.save_outlined,
                ),
                label: const Text(
                  'Save Fee Structure',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
                style:
                    ElevatedButton.styleFrom(
                  backgroundColor:
                      const Color(
                          0xFFD4AF37),
                  foregroundColor:
                      const Color(
                          0xFF13294B),
                  elevation: 0,
                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(
                            14),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // DOWNLOAD + SHARE
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _downloadFeeStructure,
                    icon: const Icon(
                      Icons.download_outlined,
                    ),
                    label:
                        const Text('Download'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _shareFeeStructure,
                    icon: const Icon(
                      Icons.share_outlined,
                    ),
                    label:
                        const Text('Share'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // COMPLETE FEE DOCUMENT
  // ============================================================

  Widget _feeDocument() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(10),
        border: Border.all(
          color:
              const Color(0xFFD9DDE5),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black
                .withValues(alpha: 0.04),
            blurRadius: 10,
            offset:
                const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding:
            const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            _documentHeader(),

            _documentDivider(),

            _clientInformation(),

            _documentDivider(),

            _feeDetails(),

            const SizedBox(height: 16),

            _miscellaneousFees(),

            const SizedBox(height: 16),

            _totalsSection(),

            _documentDivider(),

            _notesSection(),

            const SizedBox(height: 35),

            _signatureSection(),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // HEADER
  // ============================================================

  Widget _documentHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ======================================================
        // LAW FIRM INFORMATION
        // ======================================================

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _editableLine(
                controller: _firmNameController,
                placeholder: 'Enter your law firm name here',
                fontSize: 16,
                bold: true,
              ),

              const SizedBox(height: 10),

              _headerInputLine(
                label: 'Address:',
                controller: _addressController,
              ),

              const SizedBox(height: 7),

              _headerInputLine(
                label: 'Phone:',
                controller: _phoneController,
              ),

              const SizedBox(height: 7),

              _headerInputLine(
                label: 'Email:',
                controller: _emailController,
              ),

              const SizedBox(height: 7),

              _headerInputLine(
                label: 'Website:',
                controller: _websiteController,
              ),
            ],
          ),
        ),

        const SizedBox(width: 14),

        // ======================================================
        // LAWLINK360 OFFICIAL LOGO
        // ======================================================

        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 82,
              height: 82,
              child: Image.asset(
                'assets/logos/lawlink360_transparent_logo.png',
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.gavel_rounded,
                    size: 48,
                    color: Color(0xFFD4AF37),
                  );
                },
              ),
            ),

            const SizedBox(height: 3),

            const Text(
              'LawLink360',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Color(0xFF13294B),
              ),
            ),

            const Text(
              'Legal Super App',
              style: TextStyle(
                fontSize: 8,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ============================================================
  // HEADER INPUT LINE
  // ============================================================

  Widget _headerInputLine({
    required String label,
    required TextEditingController controller,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: Color(0xFF6B7280),
          ),
        ),

        const SizedBox(width: 6),

        Expanded(
          child: TextField(
            controller: controller,
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF13294B),
            ),
            decoration: const InputDecoration(
              hintText: '________________________',
              hintStyle: TextStyle(
                fontSize: 11,
                color: Color(0xFF6B7280),
              ),
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // CLIENT INFORMATION
  // ============================================================

  Widget _clientInformation() {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        _documentSectionTitle(
          'CLIENT INFORMATION',
        ),

        const SizedBox(height: 12),

        _formLine(
          label: 'Client Name:',
          controller:
              _clientNameController,
        ),

        const SizedBox(height: 10),

        _caseTitleSection(),

        const SizedBox(height: 10),

        _formLine(
          label: 'Nature of Case:',
          controller:
              _natureController,
        ),

        const SizedBox(height: 10),

        _formLine(
          label: 'Case No.:',
          controller:
              _caseNumberController,
        ),

        const SizedBox(height: 10),

        _formLine(
          label: 'Date:',
          controller:
              _dateController,
        ),
      ],
    );
  }

  // ============================================================
  // CASE TITLE SECTION
  // ============================================================

  Widget _caseTitleSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text(
          'Case Title:',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Color(0xFF374151),
          ),
        ),

        const SizedBox(width: 7),

        Expanded(
          child: _casePartyLine(
            controller: _caseTitleController,
          ),
        ),

        const SizedBox(width: 8),

        const Text(
          'V/S',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Color(0xFF13294B),
          ),
        ),

        const SizedBox(width: 8),

        Expanded(
          child: _casePartyLine(
            controller: _oppositePartyController,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // CASE PARTY LINE
  // ============================================================

  Widget _casePartyLine({
    required TextEditingController controller,
  }) {
    return TextField(
      controller: controller,
      style: const TextStyle(
        fontSize: 11,
        color: Color(0xFF374151),
      ),
      decoration: const InputDecoration(
        hintText: '________________',
        hintStyle: TextStyle(
          color: Color(0xFF6B7280),
        ),
        border: InputBorder.none,
        isDense: true,
        contentPadding: EdgeInsets.zero,
      ),
    );
  }

  // ============================================================
  // FEE DETAILS
  // ============================================================

  Widget _feeDetails() {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        _documentSectionTitle(
          'FEE DETAILS',
        ),

        const SizedBox(height: 12),

        _feeInputRow(
          label: 'Lawyer Consultation Fee',
          controller:
              _lawyerConsultationController,
        ),

        const SizedBox(height: 10),

        _feeInputRow(
          label: 'Lawyer Services / Fee',
          controller:
              _lawyerServicesController,
        ),

        const SizedBox(height: 10),

        _feeInputRow(
          label: 'Drafting Fee',
          controller:
              _draftingController,
        ),

        const SizedBox(height: 10),

        _feeInputRow(
          label: 'Clerk Fee',
          controller:
              _clerkController,
        ),
      ],
    );
  }

  // ============================================================
  // MISCELLANEOUS FEES
  // ============================================================

  Widget _miscellaneousFees() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE5E7EB),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: const Color(0xFFD4AF37)
                      .withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.account_balance_wallet_outlined,
                  color: Color(0xFFD4AF37),
                  size: 20,
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'Miscellaneous Fees',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF13294B),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          _miscellaneousFeeRow(
            'Court / Stamp Duty (if applicable)',
            _courtStampController,
          ),

          _miscellaneousFeeRow(
            'Local Commission Fee (if applicable)',
            _commissionController,
          ),

          _miscellaneousFeeRow(
            'Newspaper Expenses (if applicable)',
            _newspaperController,
          ),

          _miscellaneousFeeRow(
            'Notice / Summon Expenses',
            _noticeSummonController,
          ),

          const SizedBox(height: 8),

          Align(
            alignment: Alignment.centerRight,
            child: OutlinedButton.icon(
              onPressed: _addMiscellaneousFee,
              icon: const Icon(
                Icons.add,
                size: 17,
              ),
              label: const Text('Add Fee'),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF13294B),
                side: const BorderSide(
                  color: Color(0xFF13294B),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 9,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),

          if (_miscellaneousFeeItems.isNotEmpty) ...[
            const SizedBox(height: 12),

            ...List.generate(
              _miscellaneousFeeItems.length,
              (index) {
                final fee = _miscellaneousFeeItems[index];

                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          fee.description,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF374151),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      const SizedBox(width: 10),

                      SizedBox(
                        width: 120,
                        child: TextField(
                          controller: fee.amountController,
                          keyboardType:
                              const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Color(0xFF13294B),
                            fontWeight: FontWeight.w600,
                          ),
                          decoration: const InputDecoration(
                            prefixText: 'Rs. ',
                            prefixStyle: TextStyle(
                              fontSize: 11,
                              color: Color(0xFF13294B),
                              fontWeight: FontWeight.w600,
                            ),
                            hintText: '________',
                            hintStyle: TextStyle(
                              fontSize: 11,
                              color: Color(0xFF6B7280),
                            ),
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                          onChanged: (_) {
                            setState(() {});
                          },
                        ),
                      ),

                      IconButton(
                        onPressed: () {
                          _removeMiscellaneousFee(index);
                        },
                        icon: const Icon(
                          Icons.delete_outline,
                          color: Colors.redAccent,
                          size: 19,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ],
      ),
    );
  }

  // ============================================================
  // MISCELLANEOUS FEE ROW
  // ============================================================

  Widget _miscellaneousFeeRow(
    String title,
    TextEditingController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF374151),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          const SizedBox(width: 10),

          SizedBox(
            width: 120,
            child: TextField(
              controller: controller,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xFF13294B),
                fontWeight: FontWeight.w600,
              ),
              decoration: const InputDecoration(
                prefixText: 'Rs. ',
                prefixStyle: TextStyle(
                  fontSize: 11,
                  color: Color(0xFF13294B),
                  fontWeight: FontWeight.w600,
                ),
                hintText: '________',
                hintStyle: TextStyle(
                  fontSize: 11,
                  color: Color(0xFF6B7280),
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              onChanged: (_) {
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // FEE INPUT ROW
  // ============================================================

  Widget _feeInputRow({
    required String label,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xFF374151),
              ),
            ),
          ),

          const SizedBox(width: 8),

          SizedBox(
            width: 110,
            child: TextField(
              controller: controller,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xFF13294B),
                fontWeight: FontWeight.w600,
              ),
              decoration: const InputDecoration(
                prefixText: 'Rs. ',
                prefixStyle: TextStyle(
                  fontSize: 11,
                  color: Color(0xFF13294B),
                  fontWeight: FontWeight.w600,
                ),
                hintText: '________',
                hintStyle: TextStyle(
                  fontSize: 11,
                  color: Color(0xFF6B7280),
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              onChanged: (_) {
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // TOTALS
  // ============================================================

  Widget _totalsSection() {
    return Column(
      children: [
        _totalRow(
          label: 'Total Amount:',
          amount: _totalAmount,
        ),

        const SizedBox(height: 8),

        Row(
          children: [
            const Expanded(
              child: Text(
                'Paid Amount:',
                textAlign:
                    TextAlign.right,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight:
                      FontWeight.w600,
                  color:
                      Color(0xFF374151),
                ),
              ),
            ),

            const SizedBox(width: 10),

            SizedBox(
              width: 120,
              child: TextField(
                controller:
                    _paidController,
                keyboardType:
                    const TextInputType
                        .numberWithOptions(
                  decimal: true,
                ),
                textAlign:
                    TextAlign.right,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF13294B),
                  fontWeight: FontWeight.w600,
                ),
                decoration: const InputDecoration(
                  prefixText: 'Rs. ',
                  prefixStyle: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF13294B),
                    fontWeight: FontWeight.w600,
                  ),
                  hintText: '________',
                  hintStyle: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF6B7280),
                  ),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
                onChanged: (_) {
                  setState(() {});
                },
              ),
            ),
          ],
        ),

        const SizedBox(height: 8),

        _totalRow(
          label: 'Pending Amount:',
          amount: _pendingAmount,
          highlight: true,
        ),

        const SizedBox(height: 14),

        // ============================================================
        // DUE DATE BOX
        // ============================================================

        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFBEB),
            border: Border.all(
              color: const Color(0xFFD4AF37),
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Expanded(
                child: Text(
                  'Kindly pay the remaining amount within due date:',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF374151),
                  ),
                ),
              ),

              const SizedBox(width: 8),

              InkWell(
                onTap: _selectDueDate,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: const Color(0xFFD1D5DB),
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _dueDateController.text.isEmpty
                            ? '00/00/0000'
                            : _dueDateController.text,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: _dueDateController.text.isEmpty
                              ? const Color(0xFF9CA3AF)
                              : const Color(0xFF13294B),
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.calendar_month_outlined,
                        size: 15,
                        color: Color(0xFF13294B),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _totalRow({
    required String label,
    required double amount,
    bool highlight = false,
  }) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            textAlign:
                TextAlign.right,
            style: TextStyle(
              fontSize:
                  highlight ? 13 : 12,
              fontWeight:
                  FontWeight.bold,
              color:
                  const Color(0xFF13294B),
            ),
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 120,
          child: Text(
            _formatAmount(amount),
            textAlign:
                TextAlign.right,
            style: TextStyle(
              fontSize:
                  highlight ? 14 : 12,
              fontWeight:
                  FontWeight.bold,
              color: highlight
                  ? const Color(
                      0xFFD4AF37)
                  : const Color(
                      0xFF13294B),
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // NOTES
  // ============================================================

  Widget _notesSection() {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        _documentSectionTitle(
          'NOTES',
        ),

        const SizedBox(height: 8),

        TextField(
          controller:
              _notesController,
          maxLines: 4,
          decoration:
              const InputDecoration(
            hintText:
                'Enter any additional notes here...',
            border:
                InputBorder.none,
            contentPadding:
                EdgeInsets.zero,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // SIGNATURES
  // ============================================================

  Widget _signatureSection() {
    return Row(
      children: [
        Expanded(
          child: _signatureLine(
            'Signature of Counsel',
          ),
        ),
        const SizedBox(width: 30),
        Expanded(
          child: _signatureLine(
            'Signature of Client',
          ),
        ),
      ],
    );
  }

  Widget _signatureLine(
    String title,
  ) {
    return Column(
      children: [
        const SizedBox(height: 30),

        Container(
          height: 1,
          color:
              const Color(0xFF6B7280),
        ),

        const SizedBox(height: 6),

        Text(
          title,
          textAlign:
              TextAlign.center,
          style: const TextStyle(
            fontSize: 10,
            color:
                Color(0xFF4B5563),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // SMALL UI HELPERS
  // ============================================================

  Widget _documentSectionTitle(
    String title,
  ) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.bold,
        color: Color(0xFF13294B),
        letterSpacing: 0.3,
      ),
    );
  }

  Widget _documentDivider() {
    return Padding(
      padding:
          const EdgeInsets.symmetric(
        vertical: 16,
      ),
      child: Container(
        height: 1,
        color:
            const Color(0xFFE1E4E8),
      ),
    );
  }

  Widget _formLine({
    required String label,
    required TextEditingController
        controller,
  }) {
    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight:
                FontWeight.w600,
            color:
                Color(0xFF374151),
          ),
        ),

        const SizedBox(width: 7),

        Expanded(
          child: TextField(
            controller:
                controller,
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF13294B),
            ),
            decoration:
                const InputDecoration(
              hintText:
                  '________________________',
              hintStyle: TextStyle(
                fontSize: 11,
                color: Color(0xFF6B7280),
              ),
              border:
                  InputBorder.none,
              isDense: true,
              contentPadding:
                  EdgeInsets.zero,
            ),
          ),
        ),
      ],
    );
  }

  Widget _editableLine({
    required TextEditingController
        controller,
    required String placeholder,
    double fontSize = 11,
    bool bold = false,
  }) {
    return TextField(
      controller:
          controller,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: bold
            ? FontWeight.bold
            : FontWeight.normal,
        color:
            const Color(0xFF13294B),
      ),
      decoration:
          InputDecoration(
        hintText:
            placeholder,
        hintStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: bold
              ? FontWeight.bold
              : FontWeight.normal,
          color:
              const Color(0xFF6B7280),
        ),
        border:
            InputBorder.none,
        isDense: true,
        contentPadding:
            EdgeInsets.zero,
      ),
    );
  }

  Widget _addFeeButton({
    required VoidCallback onPressed,
  }) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: const Icon(
        Icons.add,
        size: 17,
      ),
      label: const Text(
        'Add Fee',
        style: TextStyle(
          fontSize: 12,
          fontWeight:
              FontWeight.w600,
        ),
      ),
      style: TextButton.styleFrom(
        foregroundColor:
            const Color(0xFF13294B),
        padding:
            const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 6,
        ),
      ),
    );
  }

  // ============================================================
  // PDF CONTENT
  // ============================================================

  String _buildFeeStructurePdfContent() {
    final buffer = StringBuffer();

    buffer.writeln('FEE STRUCTURE');
    buffer.writeln('');

    // LAW FIRM
    if (_firmNameController.text.trim().isNotEmpty) {
      buffer.writeln(_firmNameController.text.trim());
    }
    if (_addressController.text.trim().isNotEmpty) {
      buffer.writeln('Address: ${_addressController.text.trim()}');
    }
    if (_phoneController.text.trim().isNotEmpty) {
      buffer.writeln('Phone: ${_phoneController.text.trim()}');
    }
    if (_emailController.text.trim().isNotEmpty) {
      buffer.writeln('Email: ${_emailController.text.trim()}');
    }
    if (_websiteController.text.trim().isNotEmpty) {
      buffer.writeln('Website: ${_websiteController.text.trim()}');
    }

    buffer.writeln('');
    buffer.writeln('CLIENT INFORMATION');
    buffer.writeln('');
    buffer.writeln('Client: ${_clientNameController.text.trim()}');
    buffer.writeln('Case: ${_caseTitleController.text.trim()}');
    buffer.writeln('Nature: ${_natureController.text.trim()}');
    buffer.writeln('Case No.: ${_caseNumberController.text.trim()}');
    buffer.writeln('Date: ${_dateController.text.trim()}');

    buffer.writeln('');
    buffer.writeln('FEE DETAILS');
    buffer.writeln('');
    _addPdfFeeLine(buffer, 'Consultation', _lawyerConsultationController);
    _addPdfFeeLine(buffer, 'Services', _lawyerServicesController);
    _addPdfFeeLine(buffer, 'Drafting', _draftingController);
    _addPdfFeeLine(buffer, 'Clerk', _clerkController);

    buffer.writeln('');
    buffer.writeln('MISCELLANEOUS FEES');
    buffer.writeln('');
    _addPdfFeeLine(buffer, 'Court/Stamp', _courtStampController);
    _addPdfFeeLine(buffer, 'Commission', _commissionController);
    _addPdfFeeLine(buffer, 'Newspaper', _newspaperController);
    _addPdfFeeLine(buffer, 'Notice/Summon', _noticeSummonController);

    for (final fee in _miscellaneousFeeItems) {
      if (fee.amount > 0) {
        buffer.writeln('${fee.description}: Rs. ${fee.amount.toStringAsFixed(2)}/-');
      }
    }

    buffer.writeln('');
    buffer.writeln('PAYMENT SUMMARY');
    buffer.writeln('');
    buffer.writeln('Total: Rs. ${_totalAmount.toStringAsFixed(2)}/-');
    buffer.writeln('Paid: Rs. ${_paidAmount.toStringAsFixed(2)}/-');
    buffer.writeln('Pending: Rs. ${_pendingAmount.toStringAsFixed(2)}/-');

    // Due Date
    if (_dueDateController.text.trim().isNotEmpty) {
      buffer.writeln('Due Date: ${_dueDateController.text.trim()}');
    } else if (widget.feeStructure?.dueDate != null) {
      buffer.writeln('Due Date: ${_formatDate(widget.feeStructure!.dueDate!)}');
    }

    // NOTES - condensed
    if (_notesController.text.trim().isNotEmpty) {
      buffer.writeln('');
      buffer.writeln('NOTES');
      buffer.writeln(_notesController.text.trim());
    }

    return buffer.toString();
  }

  void _addPdfFeeLine(
    StringBuffer buffer,
    String label,
    TextEditingController controller,
  ) {
    final amount = _amount(controller);

    if (amount > 0) {
      buffer.writeln(
        '$label: Rs. ${amount.toStringAsFixed(2)}/-',
      );
    }
  }

  // ============================================================
  // DOWNLOAD
  // ============================================================

  Future<void> _downloadFeeStructure() async {
    try {
      final pdfContent =
          _buildFeeStructurePdfContent();

      final filePath =
          await _downloadService.savePdf(
        title: 'Fee Structure',
        body: pdfContent,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Fee structure PDF saved successfully.',
          ),
        ),
      );

      debugPrint(
        'Fee Structure PDF saved at: $filePath',
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Unable to save PDF: $e',
          ),
        ),
      );
    }
  }

  // ============================================================
  // SHARE
  // ============================================================

  Future<void> _shareFeeStructure() async {
    try {
      final pdfContent =
          _buildFeeStructurePdfContent();

      final filePath =
          await _downloadService.savePdf(
        title: 'Fee Structure',
        body: pdfContent,
      );

      // Ensure file is fully written before sharing
      await Future.delayed(const Duration(milliseconds: 300));

      await _shareService.sharePdf(
        filePath,
        text: 'Fee Structure - LawLink360',
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Unable to share PDF: $e',
          ),
        ),
      );
    }
  }
}

// ============================================================
// DYNAMIC FEE ROW CONTROLLER
// ============================================================

class _FeeRowController {
  _FeeRowController({
    required this.description,
    required String amount,
  }) {
    amountController.text =
        amount;
  }

  final String description;

  final TextEditingController
      amountController =
      TextEditingController();

  double get amount {
    return double.tryParse(
          amountController.text
              .trim()
              .replaceAll(',', ''),
        ) ??
        0;
  }

  void dispose() {
    amountController.dispose();
  }
}