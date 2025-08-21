class FormValidation {
  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Name is required";
    }
    final cleanedValue = value.trim();
    final nameRegex = RegExp(r"^[A-Za-z]+(?: [A-Za-z]+)*$");

    if (!nameRegex.hasMatch(cleanedValue)) {
      return "Please enter a valid name";
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Phone number is required";
    }
    final cleaned = value.trim();
    final phoneRegex = RegExp(r'^(\+91)?[6-9]\d{9}$');

    if (!phoneRegex.hasMatch(cleaned)) {
      return "Enter a valid 10-digit phone number";
    }
    return null;
  }

  static String? validateAddress(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Address is required";
    }
    final cleaned = value.trim();
    if (cleaned.length < 5) {
      return "Address is too short";
    }
    return null;
  }

  static String? validateWeight(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Package weight is required";
    }
    final weight = double.tryParse(value.trim());
    if (weight == null || weight <= 0) {
      return "Enter a valid weight";
    }
    return null;
  }


  static String? validateTrackingId(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Tracking number is required";
    }
    final cleaned = value.trim();
    final trackingRegex = RegExp(r'^[A-Z]{2}[0-9]{9}$'); 

    if (!trackingRegex.hasMatch(cleaned)) {
      return "Please enter a valid tracking number (e.g. JB693411754)";
    }
    return null;
  }
}
