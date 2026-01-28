// lib/models/company.dart

class Company {
  // Yrityksen ominaisuudet (MVP)
  final String id;              // Yksilöivä tunniste
  final String name;            // Yrityksen nimi
  final String industry;        // Toimiala (esim. "Beauty", "Tech", "Food")
  final String location;        // Paikkakunta
  final String description;     // Lyhyt kuvaus (1–2 lausetta)
  final String logoUrl;         // Linkki logoon (MVP: URL/tyhjä)

  // Yhteyshenkilö (tarvitaan käyttäjäpolussa)
  final String contactName;     // Yhteyshenkilön nimi
  final String contactEmail;    // Yhteyssähköposti

  // Konstruktori: luo uuden Company-olion
  Company({
    required this.id,
    required this.name,
    required this.industry,
    required this.location,
    required this.description,
    required this.logoUrl,
    required this.contactName,
    required this.contactEmail,
  });

  // todo: lisää myöhemmin toJson/fromJson (+ copyWith) kun backend tulee mukaan
  // todo: lisää myöhemmin linkit (www/IG/TikTok), tapahtumat, “mitä etsimme” -kentät jne.
}
