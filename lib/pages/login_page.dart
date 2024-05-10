import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 5),
              Image.asset('images/cornice.png'),
              SizedBox(height: 10),
              Text(
                'Ti diamo il benvenuto',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10), // Spazio tra il titolo e il sottotitolo
              Text(
                'Continua con una delle seguenti opzioni',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 40),
              Container(
                width: 250, // Aumenta la larghezza del campo di input
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey), // Bordo grigio
                  borderRadius: BorderRadius.circular(8.0), // Bordi arrotondati
                ),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: '+39 - cellulare',
                    prefixIcon: Icon(Icons.phone_android),
                    border: InputBorder.none, // Rimuovi il bordo predefinito del TextField
                  ),
                  keyboardType: TextInputType.phone,
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 250, // Aumenta la larghezza del bottone Google
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey), // Bordo grigio
                  borderRadius: BorderRadius.circular(8.0), // Bordi arrotondati
                ),
                child: TextButton(
                  onPressed: () {
                    // Logica per l'autenticazione con Google
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Icona di Google
                      SizedBox(width: 10),
                      Text(
                        'Google',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 250, // Aumenta la larghezza del bottone Email
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey), // Bordo grigio
                  borderRadius: BorderRadius.circular(8.0), // Bordi arrotondati
                ),
                child: TextButton(
                  onPressed: () {
                    // Logica per l'autenticazione con l'e-mail
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.email),
                      SizedBox(width: 10),
                      Text('E-mail'),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20), // Ridotto lo spazio
              TextButton(
                onPressed: () {
                  // Logica per ignorare il login per il momento
                },
                child: Text('Ignora per il momento'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Continuando, accetti automaticamente i nostri Termini e condizioni, Politica sulla Privacy e Politica sui cookie.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              SizedBox(height: 200), // Sposta tutto più in basso
            ],
          ),
        ),
      ),
    );
  }
}
