import 'package:flutter/material.dart';
import 'package:flutter_app/assets/vpn-server/virtual_private_network_server_list.dart';
import 'package:flutter_app/assets/vpn-server/virtual_private_netwrok_server.dart';
import 'package:flutter_app/classes/application/application_state.dart';
import 'package:flutter_app/elements/button_content/double_text_button_content.dart';
import 'package:flutter_app/elements/buttons/main_buttons/button.dart';
import 'package:flutter_app/elements/buttons/main_buttons/main_button_styles/button_style.dart';
import 'package:flutter_app/widgets/header/header.dart';
import 'package:flutter_svg/svg.dart';

class LocationsScreen extends StatelessWidget {
  const LocationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 104, 73, 191),
              Color.fromARGB(255, 8, 1, 29),
            ],
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
                        // const Header(),
                        HeaderState(),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.12),
                                  borderRadius: ApplicationState().theme.borderRadius,
                                ),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                                    child: const Row(
                                      children: [
                                        Icon(Icons.search, color: Colors.white70),
                                        SizedBox(width: 6),
                                        Expanded(
                                          child: TextField(
                                            style: TextStyle(color: Colors.white),
                                            decoration: InputDecoration(
                                              hintText: 'Search location',
                                              hintStyle:
                                                  TextStyle(color: Colors.white54, fontSize: 17),
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
            
                      const SizedBox(height: 0),

                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                            child: Column(
                              children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 24),
                                    child: _sectionHeader(
                                      title: 'Free',
                                      speedLabel: '1MB/S',
                                    ),
                                  ),

                                  const SizedBox(height: 5),

                                for (var server in servers.values)
                                  if (server.type == ServerType.Free)
                                    _LocationTile(
                                      flag: server.flag,
                                      city: server.city,
                                      countryCode: server.countryCode,
                                      label: server.type.toString(),
                                      latencyMs: 12,
                                      type: server.type.name,
                                    ),

                                  const SizedBox(height: 18),
                              ],
                            ),
                          ),
                        ),
                      ),
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
              fontSize: 14,
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
  final String type;
  final int latencyMs;

  const _LocationTile({
    required this.flag,
    required this.city,
    required this.countryCode,
    required this.label,
    required this.latencyMs,
    required this.type
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
         Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: SvgPicture.asset(
                flag,
                width: 46,
                height: 46,
              ),
            ),
          ),
          const SizedBox(width: 10,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$city, $countryCode", 
                style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
              ),
              Text(
                type, 
                style: TextStyle(
                  fontSize: 15, 
                  fontWeight: FontWeight.w400, 
                  color: Theme.of(context).textTheme.bodyMedium!.color!.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
        
          const Spacer(),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Row(
              //   children: [
              //     Icon(Icons.bar_chart,
              //         size: 16, color: Colors.greenAccent.shade200),
              //     const SizedBox(width: 4),
              //     Text(
              //       '${latencyMs}MS',
              //       style: const TextStyle(
              //         color: Colors.white70,
              //         fontSize: 11,
              //       ),
              //     ),
              //   ],
              // ),
              // const SizedBox(height: 4),
              // Text(
              //   label,
              //   style: const TextStyle(
              //     color: Colors.white,
              //     fontSize: 11,
              //     fontWeight: FontWeight.w500,
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}

class LocationButtonStyle extends AbstractButtonStyle {
  @override
  Color get background => const Color.fromRGBO(255, 255, 255, 0.15);

  @override
  BorderRadius get borderRadius => ApplicationState().theme.borderRadius;

  @override
  Color get foreground => const Color.fromRGBO(255, 255, 255, 1);
  
  @override
  Color get accent => const Color.fromARGB(255, 104, 73, 191);
}