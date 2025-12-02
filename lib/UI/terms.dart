import 'package:flutter/material.dart';

class TermsView extends StatelessWidget {
  const TermsView({super.key});

  // Aquí iría el texto completo de tus términos y condiciones
  final String termsContent = """
Terms and Conditions for TripMatch

Last updated: December 02, 2025

Please read these Terms and Conditions carefully before using the TripMatch Application.

1. Interpretation and Definitions
Interpretation

Words with capitalized initials have meanings defined under the following conditions. These definitions apply whether they appear in singular or plural.

Definitions

For the purposes of these Terms and Conditions:

Application means the TripMatch software provided by the Company and downloaded on any electronic device.

Application Store means Apple App Store, Google Play Store, or other digital distribution platforms where the Application is available.

Company (“We”, “Us”, or “Our”) refers to Xplora, located in Lima, San Miguel, Peru.

Service refers to the Application.

User (“You”) means any individual or legal entity using the Service.
TripMatch has two types of Users:

Tourist Users – Individuals seeking travel experiences.

Agency Users – Registered travel agencies offering services, tours, or experiences.

Account means the unique profile created to access the Service.

Device means any device capable of accessing the Service.

Third-Party Social Media Service refers to any external login provider (e.g., Google).

Content means any text, images, data, reviews, listings, comments, or other media submitted to the Service.

Affiliate means any entity controlled by or under common control with the Company.

2. Acknowledgment

These Terms and Conditions govern the use of the Service and form a binding agreement between You and the Company.

Your access to the Service is conditioned on Your acceptance of these Terms.
If You disagree with any part, You may not access the Service.

You represent that You are at least 18 years old. The Service is not intended for individuals under 18.

Use of the Service is also subject to Our Privacy Policy, which describes how We collect and use personal data.

3. Account Creation and User Responsibilities
3.1 Account Types

TripMatch allows two types of accounts:

Tourist Accounts

Created by individuals seeking travel experiences, tours, or adventure packages.

Agency Accounts

Created by legally registered tourism agencies to offer services through TripMatch.
Agencies must provide:

Legal business name

Email

Phone number

Proof of operation or registry (if required by local regulations)

The Company may request additional documentation to verify agency authenticity.

3.2 Account Security

You agree to:

Provide accurate, complete, and updated information.

Maintain the confidentiality of your credentials.

Notify the Company immediately of any unauthorized access.

The Company is not liable for damages arising from failure to comply with security obligations.

3.3 Social Media Login

Users may log in using Third-Party Social Media Services (e.g., Google).
By doing so, You authorize the Company to access basic profile data allowed by the provider.

4. Use of the Service

You agree NOT to use the Service for:

Posting false, misleading, or fraudulent information.

Impersonating another person or agency.

Uploading harmful, unlawful, or offensive content.

Interfering with the Service’s operation (e.g., malware, scraping, hacking).

Posting copyrighted materials without permission.

The Company may suspend or terminate any account violating these rules.

5. Agency Listings and Responsibilities

Agencies using TripMatch agree to:

Provide accurate descriptions of tours, prices, schedules, and policies.

Keep availability and information updated.

Respond to tourist inquiries within reasonable timeframes.

Comply with all regional tourism laws and safety regulations.

Be solely responsible for the quality and execution of offered services.

TripMatch acts as a platform, not a travel agency.
We do not operate tours, guarantee agency performance, or assume liability for disputes between Users.

6. Booking, Payments, and Cancellations (If Applicable)

If TripMatch enables bookings or payments in the future:

The Company may act as an intermediary to process reservations.

Agencies must clearly state cancellation policies.

Tourists must review and accept Agency policies before booking.

The Company is not responsible for:

Changes made by agencies,

Cancellation fees,

Refund disputes.

Currently, TripMatch may operate as a matching platform, and any payments or arrangements outside the Application are the sole responsibility of the parties involved.

7. User-Generated Content

Users may submit reviews, photos, or comments.
By doing so, You grant the Company:

A non-exclusive,

Worldwide,

Royalty-free,

Transferable license

to use, display, reproduce, and distribute such content for purposes of improving or promoting the Service.

You retain ownership of your content.

The Company may remove content at its sole discretion if it violates these Terms.

8. Intellectual Property

The Application, including logos, graphics, software, and trademarks, is owned by the Company and protected under national and international laws.

You may not:

Copy,

Modify,

Distribute,

Reverse-engineer,

Sell or sublicense

any part of the Application without written permission.

9. Third-Party Links

TripMatch may contain links to third-party websites.
The Company is not responsible for their content, policies, or reliability.

You are encouraged to review third-party terms and privacy policies.

10. Termination

We may terminate or suspend Your access immediately if:

You violate these Terms,

Engage in fraudulent or harmful activity,

Provide false information.

Upon termination, You must stop using the Service immediately.

11. Limitation of Liability

To the maximum extent permitted by law, the Company shall not be liable for:

Loss of profits,

Loss of data,

Personal injury,

Agency misconduct,

Cancellations or service failures by Agencies,

Damages resulting from misuse of the platform.

Our total liability shall not exceed:

The amount paid by You through the Service, or

100 USD if no purchases were made.

12. “AS IS” Disclaimer

The Service is provided “AS IS” and “AS AVAILABLE”, without warranties of any kind, including implied warranties of merchantability or fitness for a particular purpose.

We do not guarantee that:

The Service will be error-free,

The Service will operate without interruption,

Agency listings are accurate,

User content is truthful.

13. Governing Law

These Terms are governed by the laws of Peru, without regard to conflict-of-law principles.

14. Dispute Resolution

You agree to attempt to resolve disputes informally by contacting the Company first.
If unresolved, disputes shall be handled under the jurisdiction of Peruvian courts.

15. Changes to These Terms

We may update these Terms at any time.
If changes are significant, We will provide notice within the Application.

Your continued use of the Service constitutes acceptance of the revised Terms.

16. Contact Us

If you have questions regarding these Terms, you may contact us at:

Email: u20231c505@upc.edu.pe
""";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Términos y Condiciones"),
        backgroundColor: const Color(0xFF2EBFAF), // Color primario
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Usamos un widget para formatear el Markdown si fuera necesario,
            // pero para texto simple, Text es suficiente.
            Text(
              termsContent,
              style: const TextStyle(fontSize: 14, height: 1.5),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}