// lib/models/event_item.dart

/// EventItem = yrityksen luoma tapahtuma (MVP).
///
/// MVP-periaate:
/// - pelkkä datamalli (ei logiikkaa)
/// - UI ja toiminnallisuus hoidetaan screeneissä
///
/// todo:
/// - lisää myöhemmin toJson/fromJson kun backend tulee mukaan
/// - lisää myöhemmin status/pending ym. jos tarvitaan
class EventItem {
  final String id;

  // Kuka loi (yritys)
  final String companyId;
  final String companyName;

  // Perustiedot
  final String title;
  final String dateLabel; // MVP: pidetään stringinä
  final String location;
  final String shortDescription;
  final List<String> tags;

  // Julkaisu
  final bool isPublished;

  // MVP: osallistujat pelkkinä id:inä (vaikuttajat)
  final List<String> participantInfluencerIds;

  EventItem({
    required this.id,
    required this.companyId,
    required this.companyName,
    required this.title,
    required this.dateLabel,
    required this.location,
    required this.shortDescription,
    required this.tags,
    required this.isPublished,
    required this.participantInfluencerIds,
  });

  // todo: toJson/fromJson (+ mahdollinen copyWith) myöhemmin
}
