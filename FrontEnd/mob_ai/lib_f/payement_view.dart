import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/common/widgets/custom_button.dart';
import 'core/theme/app_pallete.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();
  final _nameController = TextEditingController();

  bool _isProcessing = false;

  // Format card number with spaces
  String _formatCardNumber(String input) {
    if (input.length > 16) return input;
    final buffer = StringBuffer();
    for (int i = 0; i < input.length; i++) {
      if (i > 0 && i % 4 == 0) {
        buffer.write(' ');
      }
      buffer.write(input[i]);
    }
    return buffer.toString();
  }

  // Format expiry date
  String _formatExpiry(String input) {
    if (input.length > 4) return input;
    if (input.length == 2 && !input.contains('/')) {
      return '$input/';
    }
    return input;
  }

  void _processPayment() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isProcessing = true;
      });

      // Simulate payment processing
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isProcessing = false;
        });

        // Show success dialog
        showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                title: const Text('Payment Successful'),
                content: const Text(
                  'Your payment has been processed successfully.',
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      // Navigate back to cart or home
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppPallete.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
       title: const Text(
          "payement ",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Color(0xFFE18673),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Center(
              child: Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              
                  _buildLabel('Card Number'),
                  TextFormField(
                    controller: _cardNumberController,
                    decoration: _buildInputDecoration('1234 5678 9012 3456'),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(16),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _cardNumberController.text = _formatCardNumber(
                          value.replaceAll(' ', ''),
                        );
                        _cardNumberController
                            .selection = TextSelection.fromPosition(
                          TextPosition(offset: _cardNumberController.text.length),
                        );
                      });
                    },
                    validator: (value) {
                      if (value == null ||
                          value.replaceAll(' ', '').length != 16) {
                        return 'Please enter a valid card number';
                      }
                      return null;
                    },
                  ),
                  _buildLabel('Card Holder Name'),
                  TextFormField(
                    controller: _nameController,
                    decoration: _buildInputDecoration('John Doe'),
                    textCapitalization: TextCapitalization.words,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the card holder name';
                      }
                      return null;
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel('Expiry Date'),
                            TextFormField(
                              controller: _expiryController,
                              decoration: _buildInputDecoration('MM/YY'),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(4),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _expiryController.text = _formatExpiry(
                                    value.replaceAll('/', ''),
                                  );
                                  _expiryController
                                      .selection = TextSelection.fromPosition(
                                    TextPosition(
                                      offset: _expiryController.text.length,
                                    ),
                                  );
                                });
                              },
                              validator: (value) {
                                if (value == null || value.length != 5) {
                                  return 'Invalid expiry date';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel('CVV'),
                            TextFormField(
                              controller: _cvvController,
                              decoration: _buildInputDecoration('123'),
                              keyboardType: TextInputType.number,
                              obscureText: true,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(3),
                              ],
                              validator: (value) {
                                if (value == null || value.length != 3) {
                                  return 'Invalid CVV';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.4,),
                  CustomButton(hintText: 'pay now', onTap: () {}),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.grey[100],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.red[600]!),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.red),
      ),
    );
  }

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    _nameController.dispose();
    super.dispose();
  }
}
