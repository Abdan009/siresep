part of 'users_cubit.dart';

abstract class UsersState extends Equatable {
  const UsersState();
}

class UsersInitial extends UsersState {
  @override
  List<Object> get props => [];
}

class UsersLoaded extends UsersState {
  final Users user;
  UsersLoaded(this.user);
  @override
  List<Object> get props => [user];
}
