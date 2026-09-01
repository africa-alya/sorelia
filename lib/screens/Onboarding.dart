import 'package:flutter/material.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  // Couleurs de la maquette
  static const Color primaryColor = Color(0xFF162C52);
  static const Color accentYellow = Colors.amber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              
              const SizedBox(height: 12),
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFAF0D7),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,// Pour que le row ne prends pas tout la place 
                    
                    children: [
                      Icon(
                        Icons.wifi_off_rounded,
                        size: 16,
                        color: Color(0xFF4A3E2C),
                      ),
                      SizedBox(width: 3),
                      Text(
                        "Hors ligne · données enregistrées sur l'appareil",
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF4A3E2C),
                        ),
                      ),
                    ],
                  ),
                ),

              ),
              
              const Spacer(),
              //const SizedBox(height: 24,),

              Center(
                  child: Container(
                    width: 260,
                    height:260,
                    padding: const EdgeInsets.only(right: 24,left: 24,top: 24,bottom: 10), // Espace intérieur pour l'image
                    decoration: BoxDecoration(
                      //color: const Color(0xFF162C52), // Couleur bleu marine principale
                      borderRadius: BorderRadius.circular(25), 
                    ),
                    child: Image.asset(
                      'assets/logos/onboarding.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Suivi · Orientation · Avenir",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                    fontSize: 18,
                    fontFamily:"Montserrat",
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 29, 29, 29)
                  ),),
                  SizedBox(height: 12),
                  Text(
                    "Bienvenue sur Sorélia",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: primaryColor,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Tes notes, ton emploie du temps et tes révisions, toujours avec toi -- même sans connexion",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: accentYellow,
                    ),
                  ),
                ],
              ),

              const Spacer(),

              Column(
                children: [
                  //  Bouton Principal : Créer un compte
                  SizedBox(
                    width: double.infinity,
                    height: 52, 
                    child: ElevatedButton(
                      onPressed: () {
                        // Action lors du clic
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:primaryColor,
                        foregroundColor: Colors.white, 
                        elevation: 0, 
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16), 
                        ),
                      ),
                      child: const Text(
                        "Créer un compte",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  //  Bouton Secondaire : J'ai déjà un compte
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: TextButton(
                      onPressed: () {
                        // Action lors du clic
                      },
                      style: TextButton.styleFrom(
                        foregroundColor:primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        "J'ai déjà un compte",
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}