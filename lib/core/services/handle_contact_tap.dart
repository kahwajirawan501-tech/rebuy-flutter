import 'package:flutter/cupertino.dart';
import 'package:roasters/features/search/domain/entities/contact_search_entity.dart';
import 'package:url_launcher/url_launcher.dart';

void handleContactTap(ContactSearchEntity contact) async {
  final phone = contact.number;

  if (contact.type == "call") {
    final Uri telUri = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(telUri)) {
      await launchUrl(telUri);
    } else {
      debugPrint("Cannot launch phone dialer");
    }
  } else if (contact.type == "whatsapp") {
    final Uri whatsappUri = Uri.parse("https://wa.me/$phone");
    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint("Cannot launch WhatsApp");
    }
  }
}