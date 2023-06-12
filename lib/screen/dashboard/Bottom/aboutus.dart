import 'package:artsy/components/slider.dart';
import 'package:artsy/theme/size_config.dart';
import 'package:flutter/material.dart';
import '../../../theme/theme_data.dart';

class AboutusScreen extends StatefulWidget {
  const AboutusScreen({super.key});

  @override
  State<AboutusScreen> createState() => _AboutusScreenState();
}

class _AboutusScreenState extends State<AboutusScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const ScreenSlider(),
        Text('Our Mission',
            style: TextStyle(
                fontSize: getProportionateScreenHeight(20),
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat')),
        const SizedBox(height: 10),
        const SizedBox(
          width: 300,
          child: Divider(
            color: COLOR_PRIMARY,
            thickness: 2,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          child: Text(
              'At BigBite, our mission is to provide an easy, enjoyable, and affordable shopping experience for food lovers everywhere. We aim to showcase of delicoius food from diverse backgrounds and cultures, highlighting their unique perspectives. Our mission is to make sure that every customer who shops with us finds the perfect food taste that speaks to their personality, style, and aesthetic preferences.',
              style: TextStyle(
                  fontSize: getProportionateScreenHeight(15),
                  fontFamily: 'Montserrat')),
        ),
        const SizedBox(height: 10),
        Text('Contact Us',
            style: TextStyle(
                fontSize: getProportionateScreenHeight(20),
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat')),
        const SizedBox(
          width: 300,
          child: Divider(
            color: COLOR_PRIMARY,
            thickness: 2,
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(30, 20, 0, 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(Icons.email),
              const SizedBox(width: 10),
              Text(
                'bigbite108@gmail.com',
                style: TextStyle(fontSize: getProportionateScreenHeight(15)),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(30, 0, 0, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(Icons.phone),
              const SizedBox(width: 10),
              Text(
                '+977 9814647140',
                style: TextStyle(fontSize: getProportionateScreenHeight(15)),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/map');
                  },
                  icon: const Icon(Icons.location_on)),
              const SizedBox(width: 10),
              Text(
                'Kathmandu, Nepal',
                style: TextStyle(fontSize: getProportionateScreenHeight(15)),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
