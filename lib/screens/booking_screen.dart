import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickcourier/core/constants/app_sizes.dart';
import 'package:quickcourier/core/utils.dart';
import 'package:quickcourier/providers/booking_provider.dart';
import 'package:quickcourier/widgets/custom_appbar.dart';
import 'package:quickcourier/widgets/custom_textfield.dart';
import 'package:quickcourier/widgets/button.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final _formKey = GlobalKey<FormState>();

  final _senderNameFocus = FocusNode();
  final _senderPhoneFocus = FocusNode();
  final _senderAddressFocus = FocusNode();
  final _receiverNameFocus = FocusNode();
  final _receiverPhoneFocus = FocusNode();
  final _receiverAddressFocus = FocusNode();
  final _packageWeightFocus = FocusNode();

  @override
  void dispose() {
    _senderNameFocus.dispose();
    _senderPhoneFocus.dispose();
    _senderAddressFocus.dispose();
    _receiverNameFocus.dispose();
    _receiverPhoneFocus.dispose();
    _receiverAddressFocus.dispose();
    _packageWeightFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BookingProvider(),
      child: Scaffold(
        appBar: CustomAppbar(title: 'Book a Courier'),
        body: SafeArea(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Consumer<BookingProvider>(
              builder: (context, provider, _) {
                return LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      padding: AppSizes.commonPadding(context),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: IntrinsicHeight(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    _buildSection(
                                      title: "Sender Details",
                                      children: [
                                        CustomTextField(
                                          controller: provider.senderName,
                                          label: 'Sender Name',
                                          validator:
                                              FormValidation.validateName,
                                          focusNode: _senderNameFocus,
                                          nextFocus: _senderPhoneFocus,
                                        ),
                                        CustomTextField(
                                          controller:
                                              provider.senderPhoneNumber,
                                          label: 'Phone Number',
                                          validator:
                                              FormValidation.validatePhone,
                                          focusNode: _senderPhoneFocus,
                                          nextFocus: _senderAddressFocus,
                                        ),
                                        CustomTextField(
                                          controller: provider.senderAddress,
                                          label: 'Address',
                                          validator:
                                              FormValidation.validateAddress,
                                          focusNode: _senderAddressFocus,
                                          nextFocus: _receiverNameFocus,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),
                                    _buildSection(
                                      title: "Receiver Details",
                                      children: [
                                        CustomTextField(
                                          controller: provider.receiverName,
                                          label: 'Receiver Name',
                                          validator:
                                              FormValidation.validateName,
                                          focusNode: _receiverNameFocus,
                                          nextFocus: _receiverPhoneFocus,
                                        ),
                                        CustomTextField(
                                          controller:
                                              provider.receiverPhoneNumber,
                                          label: 'Phone Number',
                                          validator:
                                              FormValidation.validatePhone,
                                          focusNode: _receiverPhoneFocus,
                                          nextFocus: _receiverAddressFocus,
                                        ),
                                        CustomTextField(
                                          controller: provider.receiverAddress,
                                          label: 'Address',
                                          validator:
                                              FormValidation.validateAddress,
                                          focusNode: _receiverAddressFocus,
                                          nextFocus: _packageWeightFocus,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 20),

                                    CustomTextField(
                                      controller: provider.packageWeight,
                                      label: 'Package Weight (kg)',
                                      validator: FormValidation.validateWeight,
                                      focusNode: _packageWeightFocus,
                                      nextFocus: null,
                                      onChanged: (value) {
                                        provider.calculatePrice();
                                      },
                                    ),
                                    const SizedBox(height: 20),

                                    InkWell(
                                      onTap: () =>
                                          provider.selectPickupDate(context),
                                      child: IgnorePointer(
                                        child: CustomTextField(
                                          controller: TextEditingController(
                                            text: provider.pickupDate != null
                                                ? "${provider.pickupDate!.day}/${provider.pickupDate!.month}/${provider.pickupDate!.year}"
                                                : "",
                                          ),
                                          label: 'Pickup Date',
                                          validator: (v) =>
                                              provider.pickupDate == null
                                              ? "Pickup date required"
                                              : null,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),

                                    InkWell(
                                      onTap: () =>
                                          provider.selectPickupTime(context),
                                      child: IgnorePointer(
                                        child: CustomTextField(
                                          controller: TextEditingController(
                                            text: provider.pickupTime != null
                                                ? provider.pickupTime!.format(
                                                    context,
                                                  )
                                                : "",
                                          ),
                                          label: 'Pickup Time',
                                          validator: (v) =>
                                              provider.pickupTime == null
                                              ? "Pickup time required"
                                              : null,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),

                                    Text(
                                      provider.priceEstimation != null
                                          ? "Estimated Price: ₹${provider.priceEstimation!.toStringAsFixed(2)}"
                                          : "Enter package weight to see price",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 20),

                                    const SizedBox(height: 30),
                                    CustomAppElvatedButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          provider.calculatePrice();
                                          final details = provider.bookCourier(
                                            context,
                                          );

                                          if (details != null) {
                                            showDialog(
                                              context: context,
                                              builder: (ctx) => AlertDialog(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                ),
                                                title: const Text(
                                                  "Booking Confirmed ",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                content: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "Sender: ${provider.senderName.text}",
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 8),
                                                    Text(
                                                      "Receiver: ${provider.receiverName.text}",
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(
                                                        ctx,
                                                      ).pop();
                                                      Navigator.of(
                                                        context,
                                                      ).pop(); 
                                                    },
                                                    child: const Text(
                                                      "OK",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          } else {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  "Please fill all fields before booking.",
                                                ),
                                              ),
                                            );
                                          }
                                        }
                                      },
                                      child: const Text(
                                        "Book Courier",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
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
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 0,
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(
          color: Color.fromARGB(231, 158, 158, 158),
          width: 0.70,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }
}
