import 'package:flutter/material.dart';

class Tips extends StatelessWidget {
  const Tips({Key? key}) : super(key: key);

  Widget _buildSafetySection(String title, List<String> tips) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ),
            Divider(),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: tips.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Icon(Icons.check_circle),
                  title: Text(tips[index]),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          _buildSafetySection('General Safety Tips', [
            'Stay aware in public places. Avoid isolated areas.',
            'Use trusted transportation services.',
            'Secure your personal information online.',
            'Inform someone about your location when going out.',
            'Trust your instincts in uncomfortable situations.',
          ]),
          _buildSafetySection('Online Safety Tips', [
            'Use strong, unique passwords for accounts.',
            'Enable two-factor authentication wherever possible.',
            'Be cautious about sharing personal information online.',
            'Regularly update privacy settings on social media.',
            'Avoid clicking on suspicious links or emails.',
          ]),
          _buildSafetySection('Self-Defense Techniques', [
            'Learn basic self-defense moves or take a self-defense class.',
            'Practice awareness and assertive body language.',
            'Carry personal safety devices if legal and appropriate.',
            'Use vocal commands in threatening situations.',
            'Escape strategies: Run, hide, or seek help.',
          ]),
          _buildSafetySection('Workplace Safety', [
            'Know your workplace emergency exits and procedures.',
            'Report any concerning behavior or harassment to HR.',
            'Understand company policies related to safety.',
            'Avoid working alone in isolated areas if possible.',
            'Follow safety protocols for handling equipment.',
          ]),
          // Feel free to add more sections and safety tips as needed
        ],
      ),
    );
  }
}
