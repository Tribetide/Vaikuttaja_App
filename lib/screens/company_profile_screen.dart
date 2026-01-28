import 'package:flutter/material.dart';
import '../models/company.dart';

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
          _CompanyHeaderCard(
            name: c.name,
            location: c.location,
            industry: c.industry,
          ),
          const SizedBox(height: 12),

          _SectionCard(
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

          _SectionCard(
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

class _CompanyHeaderCard extends StatelessWidget {
  const _CompanyHeaderCard({
    required this.name,
    required this.location,
    required this.industry,
  });

  final String name;
  final String location;
  final String industry;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              const CircleAvatar(
                radius: 26,
                child: Icon(Icons.apartment_outlined),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: textTheme.titleLarge),
                    const SizedBox(height: 4),
                    Text(location, style: textTheme.bodyMedium),
                    const SizedBox(height: 8),
                    Text(industry, style: textTheme.bodySmall),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: textTheme.titleMedium),
              const SizedBox(height: 10),
              child,
            ],
          ),
        ),
      ),
    );
  }
}
