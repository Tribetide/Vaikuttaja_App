import 'package:flutter/material.dart';
import '../models/event.dart';

// UUSI
import '../widgets/app_scaffold.dart';

/// CreateOrEditEventScreen = sama ruutu sekä luontiin että muokkaukseen.
///
/// MVP:
/// - title, dateLabel, location, shortDescription, tags
/// - isPublished (julkaistu / luonnos)
///
/// Palauttaa Navigator.pop(context, EventItem)
class CreateOrEditEventScreen extends StatefulWidget {
  const CreateOrEditEventScreen({
    super.key,
    required this.companyId,
    required this.companyName,
    this.initial,
  });

  final String companyId;
  final String companyName;
  final EventItem? initial;

  @override
  State<CreateOrEditEventScreen> createState() => _CreateOrEditEventScreenState();
}

class _CreateOrEditEventScreenState extends State<CreateOrEditEventScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _title;
  late final TextEditingController _dateLabel;
  late final TextEditingController _location;
  late final TextEditingController _shortDescription;
  late final TextEditingController _tags; // pilkulla eroteltuna

  bool _isPublished = false;

  @override
  void initState() {
    super.initState();
    final e = widget.initial;

    _title = TextEditingController(text: e?.title ?? '');
    _dateLabel = TextEditingController(text: e?.dateLabel ?? '');
    _location = TextEditingController(text: e?.location ?? '');
    _shortDescription = TextEditingController(text: e?.shortDescription ?? '');
    _tags = TextEditingController(text: (e?.tags ?? const []).join(', '));

    _isPublished = e?.isPublished ?? false;
  }

  @override
  void dispose() {
    _title.dispose();
    _dateLabel.dispose();
    _location.dispose();
    _shortDescription.dispose();
    _tags.dispose();
    super.dispose();
  }

  void _save() {
    final ok = _formKey.currentState?.validate() ?? false;
    if (!ok) return;

    final tagList = _tags.text
        .split(',')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();

    final id = widget.initial?.id ?? DateTime.now().millisecondsSinceEpoch.toString();

    final next = EventItem(
      id: id,
      companyId: widget.companyId,
      companyName: widget.companyName,
      title: _title.text.trim(),
      dateLabel: _dateLabel.text.trim(),
      location: _location.text.trim(),
      shortDescription: _shortDescription.text.trim(),
      tags: tagList,
      isPublished: _isPublished,
      participantInfluencerIds: widget.initial?.participantInfluencerIds ?? const [],
    );

    Navigator.pop(context, next);
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.initial != null;

    return AppScaffold(
      title: isEdit ? 'Muokkaa tapahtumaa' : 'Luo tapahtuma',
      padding: EdgeInsets.zero,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _title,
                decoration: const InputDecoration(
                  labelText: 'Tapahtuman nimi',
                  prefixIcon: Icon(Icons.title),
                ),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Pakollinen' : null,
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _dateLabel,
                decoration: const InputDecoration(
                  labelText: 'Päivä ja aika (MVP)',
                  hintText: 'Esim. La 3.2. • 18:00',
                  prefixIcon: Icon(Icons.event_outlined),
                ),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Pakollinen' : null,
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _location,
                decoration: const InputDecoration(
                  labelText: 'Sijainti',
                  prefixIcon: Icon(Icons.place_outlined),
                ),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Pakollinen' : null,
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _shortDescription,
                minLines: 2,
                maxLines: 6,
                decoration: const InputDecoration(
                  labelText: 'Lyhyt kuvaus',
                  prefixIcon: Icon(Icons.notes_outlined),
                ),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Pakollinen' : null,
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _tags,
                decoration: const InputDecoration(
                  labelText: 'Tagit (pilkulla eroteltuna)',
                  hintText: 'Esim. studio, UGC, verkostoituminen',
                  prefixIcon: Icon(Icons.sell_outlined),
                ),
              ),
              const SizedBox(height: 12),

              SwitchListTile(
                value: _isPublished,
                onChanged: (v) => setState(() => _isPublished = v),
                title: const Text('Julkaistu'),
                subtitle: const Text('Vaikuttajat näkevät vain julkaistut tapahtumat.'),
              ),
              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _save,
                  icon: const Icon(Icons.save_outlined),
                  label: const Text('Tallenna'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
