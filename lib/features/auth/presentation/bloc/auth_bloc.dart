import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:notify/features/auth/data/models/user.dart';
import 'package:notify/features/auth/data/repositories/auth_repository.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  StreamSubscription<User> _userSubscription;

  AuthBloc({@required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const AuthState.unauthenticated()) {
    _userSubscription = _authRepository.user.listen(
      // Triggers mapEventToState whenever authRepository's user is changed
      (user) => add(UserChanged(user)),
    );
  }

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is UserChanged) {
      yield _mapUserChangedToState(event);
    } else if (event is LogOutRequested) {
      // Intentionally isn't awaited
      _authRepository.logOut();
    }
  }

  AuthState _mapUserChangedToState(UserChanged event) {
    return event.user != User.empty
        ? AuthState.authenticated(event.user)
        : const AuthState.unauthenticated();
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}
