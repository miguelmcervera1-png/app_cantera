import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthState {
  final bool isLoggedIn;
  final String userName;
  final String userTeam;

  const AuthState({
    this.isLoggedIn = false,
    this.userName = '',
    this.userTeam = 'Alevín A',
  });

  AuthState copyWith({bool? isLoggedIn, String? userName, String? userTeam}) {
    return AuthState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      userName: userName ?? this.userName,
      userTeam: userTeam ?? this.userTeam,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState());

  void login(String name) {
    state = state.copyWith(isLoggedIn: true, userName: name);
  }

  void logout() {
    state = const AuthState();
  }

  void setTeam(String team) {
    state = state.copyWith(userTeam: team);
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(),
);
