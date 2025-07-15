import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthProvider extends ChangeNotifier {
  final _supabase = Supabase.instance.client;

  String? username;

  User? user;

  bool get isLogged => user != null; //* check if user is logged in

  Future<void> fetchUsername() async {
    if (user == null) return;
    try {
      final response =
          await _supabase
              .from('profiles')
              .select('username')
              .eq('id', user!.id)
              .maybeSingle(); //* retrieve only 1 row

      username = response?['username'];
    } catch (e) {
      print("Error in fetching username: $e");
    }

    notifyListeners();
  }

  Future<AuthResponse> signUp(
    String email,
    String password,
    String username,
  ) async {
    final response = await _supabase.auth.signUp(
      password: password,
      email: email,
    );
    final session = await _supabase.auth.currentSession;
    user = session?.user;

    if (user != null) {
      await _supabase.from('profiles').insert({
        'id': user?.id,
        'username': username,
      });
      await fetchUsername();

      notifyListeners();
    }

    return response;
  }

  Future<AuthResponse> Login(String email, String password) async {
    final response = await _supabase.auth.signInWithPassword(
      password: password,
      email: email,
    );
    user = response.user;
    notifyListeners();
    return response;
  }

  Future<void> SignOut() async {
    await _supabase.auth.signOut();
    user = null;
    notifyListeners();
  }

  //* check session for user if logged in go to home page & updating session from supabase
  Future<void> checkSession() async {
    final session = Supabase.instance.client.auth.currentSession;
    user = session?.user;
    if (user != null) {
      try {
        await fetchUsername();
      } catch (e) {
        print("Error while fetching user $e");
      }
    }
    notifyListeners();
  }

  Future<void> resetPassword(String email) async {
    await _supabase.auth.resetPasswordForEmail(
      email,
      redirectTo: 'https://basmlaahmed.github.io/Notino-App/', //*vSending user to the reset password website
    );
  }
}
