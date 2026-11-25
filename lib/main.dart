import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp(apiClient: ApiClient()));
}

class MyApp extends StatelessWidget {
  final ApiClient apiClient;
  const MyApp({super.key, required this.apiClient});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Menyediakan ApiClient untuk seluruh widget.
        Provider<ApiClient>.value(
          value: apiClient,
        ),

        // Menyediakan status login pengguna.
        ChangeNotifierProvider<AuthState>(
          create: (_) => AuthState(apiClient),
        ),
      ],
      child: MaterialApp(
        title: 'MyPortfolio',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.indigo,
            secondary: Colors.amber[700],
          ),
          useMaterial3: true,
        ),

        // Menggunakan halaman utama yang sudah kamu miliki.
        home: MyHomePage(),
      ),
    );
  }
}