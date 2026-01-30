import 'package:flutter/material.dart';
import '../models/company.dart';

// UUSI: yhteiset widgetit
import '../widgets/app_header_card.dart';
import '../widgets/app_section_card.dart';

/// CompanyProfileScreen = yrityksen profiili “muiden silmin” (katselunäkymä).
///
/// MVP:
/// - header: nimi + paikkakunta + toimiala
/// - toimiala chipinä
/// - lyhyt kuvaus
///
/// todo:
/// - lisää myöhemmin “Mitä etsimme”
/// - lisää yhteystiedot näkyviin (contactName/contactEmail) tarvittaessa
class CompanyProfileScreen extends StatelessWidget {
  const CompanyProfileScreen({
    super.key,
    this.company,
  });

  final Company? company;

  @override
  Widget build(BuildContext context) {
    // MVP: fallback testidata, jos dataa ei välitetä vielä
    final c = company ??
        Company(
          id: 'test-company-id',
          name: 'Yritys Oy',
          industry: 'Beauty / Lifestyle',
          location: 'Helsinki',
          description:
              'Rakennamme brändejä, joista ihmiset oikeasti innostuvat. Teemme mielellämme pitkäjänteisiä yhteistyöitä.',
          logoUrl: '',
          contactName: 'Yhteyshenkilö',
          contactEmail: 'info@yritys.fi',
        );

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // VANHA _CompanyHeaderCard -> UUSI AppHeaderCard
          AppHeaderCard(
            icon: Icons.apartment_outlined,
            title: c.name,
            subtitle: c.location,
            meta: c.industry,
          ),
          const SizedBox(height: 12),

          // VANHA _SectionCard -> UUSI AppSectionCard
          AppSectionCard(
            title: 'Toimiala',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                Chip(label: Text(c.industry)),
              ],
            ),
          ),
          const SizedBox(height: 12),

          AppSectionCard(
            title: 'Lyhyt kuvaus',
            child: Text(c.description),
          ),
          const SizedBox(height: 12),

          // todo: lisää myöhemmin:
          // - Mitä etsimme
          // - Yhteystiedot (contactName/contactEmail)
          // - Linkit ja tapahtumat
        ],
      ),
    );
  }
}
