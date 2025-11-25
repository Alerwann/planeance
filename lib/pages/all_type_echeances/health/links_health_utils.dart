import 'package:flutter/material.dart';
import 'package:planeance/data/models/health/links/health_link_list.dart';
import 'package:url_launcher/url_launcher.dart';

class LinksHealthUtils extends StatelessWidget {
  const LinksHealthUtils({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Liens utiles")),
      body: Center(
        child: Scrollbar(
          thumbVisibility: true,
          child: ListView.builder(
            itemCount: HealthLinkList.allLinks.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: ListTile(
                    title: Text(
                      HealthLinkList.allLinks[index].nameWebStite,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      _exteriorLink(
                        HealthLinkList.allLinks[index].externLink,
                        context,
                      );
                    },
                    trailing: IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Informations"),
                              content: Text(
                                HealthLinkList.allLinks[index].description,
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Retour"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: Icon(Icons.info_rounded),
                    ),
                  ),
                ),
              );
            },
          ),
        ),

      ),
    );
  }

  void _exteriorLink(String links, BuildContext context) async {
    final uri = Uri.parse(links);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Impossible de charger l'image"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
