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
  static const login = 'api/v1/login/';
  static const register = 'api/v1/users/';
  static const currentLoggedUser = 'api/v1/me/';
}
