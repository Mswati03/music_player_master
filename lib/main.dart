
import 'package:flutter/material.dart';
import 'package:music_player_master/components/log-in.dart';
import 'package:music_player_master/components/login-page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://ftkaerbdxghjyjneyleh.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZ0a2FlcmJkeGdoanlqbmV5bGVoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTc5NjUyODIsImV4cCI6MjAzMzU0MTI4Mn0.X5hswwusKZ3Px74cVt9DTqGkEskz4gXQEIuIOKc_fls',
  );
  runApp(MyApp());
}
        

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDo App',
      home: LoginForm(),
    );
  }
}