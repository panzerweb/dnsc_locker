/*
  The constant response of any GET Methods

  All APIs with the GET method can use this since
  the response of the APIs is consistent or assumed to be.
*/

class ApiResponseEntity<T> {
  final int currentPage;
  final int perPage;
  final int totalPages;
  final int totalItems;
  final List<T> data;

  ApiResponseEntity({
    required this.currentPage,
    required this.perPage,
    required this.totalPages,
    required this.totalItems,
    required this.data,
  });
}
