class MailSenderRequest{
  String toEmail;
  String subject ;

  MailSenderRequest({required this.toEmail, required this.subject});

  factory MailSenderRequest.fromJson(Map<String , dynamic> json){
    return MailSenderRequest(
        toEmail: json["toEmail"],
        subject: json["subject"]);
  }

  Map<String, dynamic> toJson()=>{

        'toEmail': toEmail,
        'subject': subject
  };
}