// lib/models/influencer.dart

class Influencer {
  // Vaikuttajan ominaisuudet
  final String id;          // Yksilöivä tunniste 
  final String name;        // Vaikuttajan nimi
  final String platform;    // Esim. "Instagram", "TikTok"
  final int followers;      // Seuraajamäärä
  final double price;       // Hinta yhteistyölle 
  final String imageUrl;    // Linkki profiilikuvaan

  // Konstruktori: luo uuden Influencer-olion
  Influencer({
    required this.id,
    required this.name,
    required this.platform,
    required this.followers,
    required this.price,
    required this.imageUrl,
  });

  // Tähän tuloo myöhemmin koodia, joka muuttaa JSON-datan palvelimelta olioksi ja päinvastoin
}