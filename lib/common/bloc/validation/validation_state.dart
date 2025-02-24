abstract class ValidationState {}

class ValidationInitial extends ValidationState {}

class ValidationError extends ValidationState {
  final Map<String, String> errors; // Stores errors for each field
  ValidationError(this.errors);
}

class ValidationSuccess extends ValidationState {}
