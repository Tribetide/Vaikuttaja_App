import 'package:flutter/material.dart';

import '../models/influencer.dart';
import '../theme/app_theme_theme.dart';

/// AddInfluencerScreen = mediakortin (Influencer) rakentaja.
///
/// rajaus (mvp):
/// - tässä ruudussa EI luoda uutta käyttäjää (nimi, sposti, osoite...).
///   se tehdään erillisessä create user -ruudussa.
/// - tämä ruutu avautuu vasta sen jälkeen, kun käyttäjä on luotu.
///
/// mvp-vaiheessa EI ole backendiä:
/// - käytetään testidataa tässä tiedostossa (valinnainen esitäyttö)
/// - "tallenna" tekee vain:
///   1) validointi
///   2) influencer-olion rakentaminen
///   3) snackbar + Navigator.pop(context, influencer)
///
/// todo (kun backend tulee mukaan):
/// 1) influencerRepository: fetchInfluencer(uid) + upsertInfluencer(influencer)
/// 2) influencer-malliin: toJson/fromJson (+ copyWith)
/// 3) initial-data haetaan backendistä ja täytetään kenttiin
/// 4) tallennus kutsuu repository.upsertInfluencer(...)
class AddInfluencerScreen extends StatefulWidget {
  const AddInfluencerScreen({super.key});

  @override
  State<AddInfluencerScreen> createState() => _AddInfluencerScreenState();
}

class _AddInfluencerScreenState extends State<AddInfluencerScreen> {
  final _formKey = GlobalKey<FormState>();

  // ------------------------------------------------------------
  // mvp-testidata
  // ------------------------------------------------------------
  // simuloi “muokkaustilannetta”, jossa käyttäjällä on jo profiili.
  // jos haluat “tyhjän lomakkeen”, pidä tämä null.
  //
  // todo (backend):
  // - poistuu, kun initial-data haetaan repo/backendistä
  final Influencer? _initialInfluencer = null;

  // final Influencer? _initialInfluencer = Influencer(
  //   id: 'test-user-id',
  //   name: 'Mimosa',
  //   platform: 'Instagram',
  //   followers: 58000,
  //   price: 0,
  //   imageUrl: '',
  // );

  // ------------------------------------------------------------
  // controllers & state
  // ------------------------------------------------------------
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

  // withOpacity() on uudemmissa versioissa deprecated -> käytetään withAlpha()
  Color _alpha(Color c, double opacity) => c.withAlpha((opacity * 255).round());

  // Yhteinen InputDecoration, jotta kentät näyttävät yhtenäisiltä ja käyttävät teeman värejä.
  InputDecoration _fieldDecoration(
    String label, {
    String? hint,
    Widget? prefixIcon,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: prefixIcon,
      filled: true,
      fillColor: AppColors.surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: _alpha(AppColors.primary, 0.15)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: _alpha(AppColors.primary, 0.15)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: _alpha(AppColors.primary, 0.55),
          width: 1.5,
        ),
      ),
    );
  }

  Future<void> _handleSave() async {
    if (_isSaving) return;

    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    setState(() => _isSaving = true);

    // mvp: id tulee testidatasta tai fallbackina kovakoodatusta.
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
          _initialInfluencer == null
              ? 'Mediakortti luotu (mvp)'
              : 'Mediakortti päivitetty (mvp)',
        ),
      ),
    );

    // palautetaan data kutsuvalle näkymälle
    // todo (seuraava step): ProfileScreen voi ottaa tämän vastaan ja näyttää sen
    Navigator.pop(context, influencer);

    setState(() => _isSaving = false);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
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

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _alpha(AppColors.secondary, 0.35),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _alpha(AppColors.primary, 0.08)),
              ),
              child: Text(
                'Täytä perustiedot mediakorttia varten. '
                'Myöhemmin lisätään lisää osioita (esim. slogan, yleisödata, portfolio).',
                style: textTheme.bodyMedium,
              ),
            ),
            const SizedBox(height: 16),

            // todo (seuraavaksi lisättävät osiot tähän samaan lomakkeeseen):
            // - slogan/tagline
            // - “Minä sisällöntuottajana” (pitkä teksti)
            // - 2–3 “nostoa” (bullet pointit)
            // - yhteistyöpreferenssit (chipit/checkbox)
            // - portfolio (kuvat/videot)

            TextFormField(
              controller: _nameController,
              decoration: _fieldDecoration(
                'Nimi / Nimimerkki',
                hint: 'Esim. Mimosa',
                prefixIcon: const Icon(Icons.person_outline),
              ),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Nimi on pakollinen' : null,
            ),
            const SizedBox(height: 12),

            // HUOM:
            // teillä näkyi warning: DropdownButtonFormField.value deprecated.
            // käytetään initialValue.
            DropdownButtonFormField<String>(
              initialValue: _platform,
              items: const [
                DropdownMenuItem(value: 'Instagram', child: Text('Instagram')),
                DropdownMenuItem(value: 'TikTok', child: Text('TikTok')),
                DropdownMenuItem(value: 'YouTube', child: Text('YouTube')),
              ],
              onChanged: (v) {
                if (v == null) return;
                setState(() => _platform = v);
              },
              decoration: _fieldDecoration(
                'Pääkanava',
                prefixIcon: const Icon(Icons.campaign_outlined),
              ),
            ),
            const SizedBox(height: 12),

            TextFormField(
              controller: _followersController,
              keyboardType: TextInputType.number,
              decoration: _fieldDecoration(
                'Seuraajat',
                hint: 'Esim. 58000',
                prefixIcon: const Icon(Icons.groups_outlined),
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
              decoration: _fieldDecoration(
                'Hinta (mvp)',
                hint: 'Esim. 150',
                prefixIcon: const Icon(Icons.payments_outlined),
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
              decoration: _fieldDecoration(
                'Profiilikuvan URL (valinnainen)',
                hint: 'https://...',
                prefixIcon: const Icon(Icons.image_outlined),
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
    );
  }
}
