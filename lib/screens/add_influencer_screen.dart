import 'package:flutter/material.dart';

class AddInfluencerScreen extends StatefulWidget {
  const AddInfluencerScreen({super.key});

  @override
  State<AddInfluencerScreen> createState() => _AddInfluencerScreenState();
}

class _AddInfluencerScreenState extends State<AddInfluencerScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Add Influencer content',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
