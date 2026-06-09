// Login Exceptions

// InvalidEmailFormatAuthException for login and register
class InvalidEmailFormatAuthException implements Exception {}

class UserNotFoundAuthException implements Exception {}

//firebaseAuth other login Exceptions
class InvalidEmailOrPasswordAuthException implements Exception {}

// Register Exceptions
class EmailAlreadyInUseAuthException implements Exception {}

class WeakPasswordAuthException implements Exception {}

//Generic Login Exception and Register
class GenericAuthException implements Exception {}

// if the user is null after register that user and firebase could not get that user
class UserNotLoggedInAuthException implements Exception {}
