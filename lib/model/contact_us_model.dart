class ContactRequest {
  final String firstName;
  final String lastName;
  final String email;
  final String contactNo;
  final String message;

  ContactRequest({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.contactNo,
    required this.message,
  });

  Map<String, dynamic> toJson() {
    return {
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "contact_no": contactNo,
      "message": message,
    };
  }
}
