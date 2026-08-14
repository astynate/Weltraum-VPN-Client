import 'package:flutter/material.dart';
import 'package:flutter_app/classes/application/application_state.dart';

class LocationsScreen extends StatelessWidget {
  const LocationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [ Color(0xFF7700FF), Color(0xFF34177D),],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            child: Column(
              children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          child: Column(
                            children: [
                                        Row(
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.arrow_back, color: Colors.white),
                                            onPressed: () => Navigator.of(context).pop(),
                                          ),
                                          const Spacer(),
                                          const Text(
                                            'Locations',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 22,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const Spacer(),
                                          IconButton(
                                            icon: const Icon(Icons.menu, color: Colors.white),
                                            onPressed: () => Navigator.of(context).pop(),
                                          ),
                                        ],
                                      ),

                        Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.12),
                          borderRadius: ApplicationState().theme.borderRadius,
                        ),
                        padding:
                            const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                            child: const Row(
                              children: [
                                Icon(Icons.search, color: Colors.white70),
                                SizedBox(width: 8),
                                Expanded(
                                  child: TextField(
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      hintText: 'Search location',
                                      hintStyle:
                                          TextStyle(color: Colors.white54, fontSize: 16),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                      ),

                      ],
                      ) 
                          
                    ),
                  ],
                ),
            
                const SizedBox(height: 24),
                // Free header
                _sectionHeader(
                  title: 'Free',
                  speedLabel: '1MB/S',
                ),
                const SizedBox(height: 12),
                const Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                          _LocationTile(
                            flag: '🇫🇷',
                            city: 'Paris',
                            countryCode: 'FR',
                            label: 'Free',
                            latencyMs: 12,
                          ),
                          _LocationTile(
                            flag: '🇩🇪',
                            city: 'Hamburg',
                            countryCode: 'GE',
                            label: 'Free',
                            latencyMs: 12,
                          ),
                          _LocationTile(
                            flag: '🇵🇱',
                            city: 'Warsaw',
                            countryCode: 'PO',
                            label: 'Free',
                            latencyMs: 12,
                          ),
                          _LocationTile(
                            flag: '🇵🇱',
                            city: 'Warsaw',
                            countryCode: 'PO',
                            label: 'Free',
                            latencyMs: 12,
                          ),
                          _LocationTile(
                            flag: '🇵🇱',
                            city: 'Warsaw',
                            countryCode: 'PO',
                            label: 'Free',
                            latencyMs: 12,
                          ),
                          _LocationTile(
                            flag: '🇵🇱',
                            city: 'Warsaw',
                            countryCode: 'PO',
                            label: 'Free',
                            latencyMs: 12,
                          ),
                          _LocationTile(
                            flag: '🇵🇱',
                            city: 'Warsaw',
                            countryCode: 'PO',
                            label: 'Free',
                            latencyMs: 12,
                          ),
                          _LocationTile(
                            flag: '🇫🇷',
                            city: 'Paris',
                            countryCode: 'FR',
                            label: 'Free',
                            latencyMs: 12,
                          ),
                          _LocationTile(
                            flag: '🇩🇪',
                            city: 'Hamburg',
                            countryCode: 'GE',
                            label: 'Free',
                            latencyMs: 12,
                          ),
                          _LocationTile(
                            flag: '🇵🇱',
                            city: 'Warsaw',
                            countryCode: 'PO',
                            label: 'Free',
                            latencyMs: 12,
                          ),
                          _LocationTile(
                            flag: '🇵🇱',
                            city: 'Warsaw',
                            countryCode: 'PO',
                            label: 'Free',
                            latencyMs: 12,
                          ),
                          _LocationTile(
                            flag: '🇵🇱',
                            city: 'Warsaw',
                            countryCode: 'PO',
                            label: 'Free',
                            latencyMs: 12,
                          ),
                          _LocationTile(
                            flag: '🇵🇱',
                            city: 'Warsaw',
                            countryCode: 'PO',
                            label: 'Free',
                            latencyMs: 12,
                          ),
                          _LocationTile(
                            flag: '🇵🇱',
                            city: 'Warsaw',
                            countryCode: 'PO',
                            label: 'Free',
                            latencyMs: 12,
                          ),
                      ],
                    ),
                  ),
                ),
                // Free list
                // const SizedBox(height: 24),
                // // Premium header
                // _sectionHeader(
                //   title: 'Premium',
                //   speedLabel: '1GB/S',
                // ),
                // const SizedBox(height: 12),
                // // Premium list
                // Expanded(
                //   child: ListView(
                //     children: const [
                //       _LocationTile(
                //         flag: '🇺🇸',
                //         city: 'Los Angeles',
                //         countryCode: 'US',
                //         label: 'Premium',
                //         latencyMs: 12,
                //       ),
                //       _LocationTile(
                //         flag: '🇬🇧',
                //         city: 'London',
                //         countryCode: 'UK',
                //         label: 'Premium',
                //         latencyMs: 12,
                //       ),
                //       _LocationTile(
                //         flag: '🏳️',
                //         city: 'Solenberg',
                //         countryCode: 'SO',
                //         label: 'Premium',
                //         latencyMs: 12,
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionHeader({required String title, required String speedLabel}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            speedLabel,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class _LocationTile extends StatelessWidget {
  final String flag;
  final String city;
  final String countryCode;
  final String label;
  final int latencyMs;

  const _LocationTile({
    required this.flag,
    required this.city,
    required this.countryCode,
    required this.label,
    required this.latencyMs,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Text(
            flag,
            style: const TextStyle(fontSize: 22),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                city,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                countryCode,
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Icon(Icons.bar_chart,
                      size: 16, color: Colors.greenAccent.shade200),
                  const SizedBox(width: 4),
                  Text(
                    '${latencyMs}MS',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}