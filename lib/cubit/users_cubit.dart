import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:siresep/models/models.dart';
import 'package:siresep/services/services.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit() : super(UsersInitial());

  Future<void> getUser(String id) async {
    Users user = await UsersServices.getUser(id);
    emit(UsersLoaded(user));
  }
}
