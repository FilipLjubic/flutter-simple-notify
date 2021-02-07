import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:flutter/foundation.dart';

class User extends Equatable {
  final String email;
  final String id;
  final String name;

  const User({
    @required this.email,
    @required this.id,
    @required this.name,
  });

  static const empty = User(email: '', id: '', name: '');

  factory User.fromFirebaseUser(firebase.User firebaseUser) => User(
      email: firebaseUser.email,
      id: firebaseUser.uid,
      name: firebaseUser.displayName);

  @override
  List<Object> get props => [email, id, name];
}
