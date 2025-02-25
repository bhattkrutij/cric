part of 'edit_profile_cubit.dart';

@immutable
sealed class EditProfileState {}

final class EditProfileInitial extends EditProfileState {}

final class EditProfileLoading extends EditProfileState {}

final class EditProfileSuccess extends EditProfileState {
 final String message;
 EditProfileSuccess(this.message);
}
final class EditProfileValidationSuccess extends EditProfileState {}
final class EditProfileFailure extends EditProfileState {
  final String errors;
  EditProfileFailure(this.errors);
}
final class EditProfileValidationFailure extends EditProfileState {
  final Map<String, String> errors;
  EditProfileValidationFailure(this.errors);
}
