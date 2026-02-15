/*
|--------------------------------------------------------------------------
| API Path Constants
|--------------------------------------------------------------------------
| Centralized definitions for all backend API endpoints used by the app.
| This file serves as a single source of truth for endpoint paths,
| helping maintain consistency, readability, and easier refactoring
| across services and repositories.
|--------------------------------------------------------------------------
*/
class ApiPath {
  // Auth and Profile endpoints
  static const login = 'api/v1/login/';
  static const register = 'api/v1/users/';
  static const currentLoggedUser = 'api/v1/me/';

  // Locker endpoints
  static const lockers = 'api/v1/lockers/';

  // Locker Available endpoint -- Use for filtering
  static const lockersAvailable = 'api/v1/lockers/available/';

  // Locker subscription endpoints

  // Locker subscription request endpoints
  static const requestLocker = 'api/v1/locker-subscription-requests/';

  // Report issues endpoints
}
