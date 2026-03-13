import 'package:dnsc_locker/core/components/pushed_appbar.dart';
import 'package:dnsc_locker/core/styles/palette.dart';
import 'package:dnsc_locker/feature/locker_subscription/presentation/bloc/request_locker_cubit.dart';
import 'package:dnsc_locker/feature/locker_subscription/presentation/bloc/request_locker_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RequestsPage extends StatefulWidget {
  const RequestsPage({super.key});

  @override
  State<RequestsPage> createState() => _RequestsPageState();
}

class _RequestsPageState extends State<RequestsPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    final cubit = context.read<RequestLockerCubit>();
    cubit.getAllRequestsSubmissions();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        cubit.getAllRequestsSubmissions();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PushedAppbar(title: 'Requests'),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your Requests",
              style: TextStyle(
                color: Palette.darkShadePrimary,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: BlocBuilder<RequestLockerCubit, RequestLockerState>(
                builder: (context, state) {
                  // Initial or loading state
                  if (state is RequestLockerInitial ||
                      state is RequestLockerLoading &&
                          !(state is RequestLockersLoaded)) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  // Error state
                  if (state is RequestLockerError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  // Loaded state
                  if (state is RequestLockersLoaded) {
                    final requests = state.requests;
                    final cubit = context.read<RequestLockerCubit>();
                    final hasReachedMax = requests.length >= state.totalItems;

                    if (requests.isEmpty) {
                      return const Center(child: Text("No requests found"));
                    }

                    return ListView.builder(
                      controller: _scrollController,
                      itemCount: hasReachedMax
                          ? requests.length
                          : requests.length + 1,
                      itemBuilder: (context, index) {
                        if (index >= requests.length) {
                          // Pagination loading indicator
                          return const Padding(
                            padding: EdgeInsets.all(16),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }

                        final request = requests[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: ListTile(
                            leading: const Icon(Icons.lock_outline),
                            title: Text(
                              "Locker ID: ${request.locker?.lockerNumber ?? 'N/A'}",
                            ),
                            subtitle: Text(
                              "${request.academicYear} - ${request.semester}",
                            ),
                            trailing: Text(
                              request.status ?? "Pending",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }

                  return const SizedBox.shrink(); // fallback
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
