
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../entities/user.dart';

part 'app_user_state.dart';

class AppUserCubit extends Cubit<AppUserState> {
  AppUserCubit() : super(AppUserInitial());
  void updateUser(String? userId) {
    if (userId == null) {
      emit(AppUserInitial());
    }
    emit(AppUserLoggedIn(userId!));
  }
}
