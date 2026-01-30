import 'package:flutter/material.dart';
import '../models/influencer.dart';

// UUSI
import '../widgets/app_scaffold.dart';

/// AddInfluencerScreen = mediakortin (Influencer) rakentaja.
///
/// Rajaus (mvp):
/// - tässä ruudussa EI luoda uutta käyttäjää (nimi, sposti, osoite...).
///   se tehdään erillisessä create user -ruudussa.
/// - tässä ruudussa tehdään vain mediakortin perusdata.
///
/// MVP ilman backendiä:
/// - kentät täytetään halutessa testidatalla (_initialInfluencer)
/// - “Tallenna” rakentaa Influencer-olion ja palauttaa sen Navigator.pop:illa
///
/// todo (backend):
/// - hae initial-data repo/backendistä (uid)
/// - tallenna repo.upsertInfluencer(influencer)
class AddInfluencerScreen extends StatefulWidget {
  const AddInfluencerScreen({super.key});

  @override
  State<AddInfluencerScreen> createState() => _AddInfluencerScreenState();
}

class _AddInfluencerScreenState extends State<AddInfluencerScreen> {
  final _formKey = GlobalKey<FormState>();

  // MVP: simuloi tilannetta jossa dataa jo on.
  // Pidä null jos haluat täysin tyhjän lomakkeen.
  //
  // todo: poistuu kun backend-data haetaan oikeasti
  final Influencer? _initialInfluencer = null;

  late final TextEditingController _nameController;
  late final TextEditingController _followersController;
  late final TextEditingController _priceController;
  late final TextEditingController _imageUrlController;

  String _platform = 'Instagram';
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    final initial = _initialInfluencer;

    _nameController = TextEditingController(text: initial?.name ?? '');
    _followersController =
        TextEditingController(text: initial != null ? initial.followers.toString() : '');
    _priceController =
        TextEditingController(text: initial != null ? initial.price.toString() : '');
    _imageUrlController = TextEditingController(text: initial?.imageUrl ?? '');
    _platform = initial?.platform ?? 'Instagram';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _followersController.dispose();
    _priceController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    if (_isSaving) return;

    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    setState(() => _isSaving = true);

    // MVP: id fallbackina kovakoodattu.
    // todo (auth/backend): id tulee käyttäjän uid:stä
    final id = _initialInfluencer?.id ?? 'test-user-id';

    final followers = int.tryParse(_followersController.text.trim()) ?? 0;
    final price = double.tryParse(_priceController.text.trim().replaceAll(',', '.')) ?? 0.0;

    final influencer = Influencer(
      id: id,
      name: _nameController.text.trim(),
      platform: _platform,
      followers: followers,
      price: price,
      imageUrl: _imageUrlController.text.trim(),
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _initialInfluencer == null ? 'Mediakortti luotu (mvp)' : 'Mediakortti päivitetty (mvp)',
        ),
      ),
    );

    Navigator.pop(context, influencer);
    setState(() => _isSaving = false);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return AppScaffold(
      title: 'Muokkaa profiilia',
      padding: EdgeInsets.zero,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _initialInfluencer == null ? 'Rakenna mediakortti' : 'Päivitä mediakortti',
                style: textTheme.headlineSmall,
              ),
              const SizedBox(height: 12),

              Card(
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Text(
                    'Täytä perustiedot mediakorttia varten. '
                    'Myöhemmin lisätään lisää osioita (slogan, yleisödata, portfolio).',
                    style: textTheme.bodyMedium,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nimi / Nimimerkki',
                  hintText: 'Esim. Mimosa',
                  prefixIcon: Icon(Icons.person_outline),
                ),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Nimi on pakollinen' : null,
              ),
              const SizedBox(height: 12),

              DropdownButtonFormField<String>(
                initialValue: _platform,
                items: const [
                  DropdownMenuItem(value: 'Instagram', child: Text('Instagram')),
                  DropdownMenuItem(value: 'TikTok', child: Text('TikTok')),
                  DropdownMenuItem(value: 'YouTube', child: Text('YouTube')),
                ],
                onChanged: (v) => setState(() => _platform = v ?? 'Instagram'),
                decoration: const InputDecoration(
                  labelText: 'Pääkanava',
                  prefixIcon: Icon(Icons.campaign_outlined),
                ),
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _followersController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Seuraajat',
                  hintText: 'Esim. 58000',
                  prefixIcon: Icon(Icons.groups_outlined),
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Seuraajamäärä on pakollinen';
                  final parsed = int.tryParse(v.trim());
                  if (parsed == null || parsed < 0) return 'Anna numero (0 tai enemmän)';
                  return null;
                },
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _priceController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Hinta (mvp)',
                  hintText: 'Esim. 150',
                  prefixIcon: Icon(Icons.payments_outlined),
                ),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Hinta on pakollinen (0 sallittu)';
                  final parsed = double.tryParse(v.trim().replaceAll(',', '.'));
                  if (parsed == null || parsed < 0) return 'Anna numero (0 tai enemmän)';
                  return null;
                },
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: _imageUrlController,
                decoration: const InputDecoration(
                  labelText: 'Profiilikuvan URL (valinnainen)',
                  hintText: 'https://...',
                  prefixIcon: Icon(Icons.image_outlined),
                ),
              ),
              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSaving ? null : _handleSave,
                  child: Text(_isSaving ? 'Tallennetaan...' : 'Tallenna'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
