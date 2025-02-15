part of 'app_user_cubit.dart';

@immutable
sealed class AppUserState {}

final class AppUserInitial extends AppUserState {}

final class AppUserLoading extends AppUserState {}
final class AppUserLoggedIn extends AppUserState {
  final String userId;

  AppUserLoggedIn(this.userId);
}
