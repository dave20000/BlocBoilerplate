// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:boilerplate_bloc/domain/enums/account_type.dart';
// import 'package:boilerplate_bloc/domain/models/user/user.dart';
// import 'package:boilerplate_bloc/domain/states/core/app/app_state.dart';
// import 'package:boilerplate_bloc/domain/states/user/user_state.dart';

// import '../../../mocks/usecases/usecases_mock.mocks.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   late MockReadUser mockReadUser;
//   late MockLogoutUser mockLogoutUser;

//   setUpAll(() {
//     mockReadUser = MockReadUser();
//     mockLogoutUser = MockLogoutUser();

//     when(mockReadUser()).thenAnswer(
//       (_) async => const UserState.notAvailable(),
//     );
//   });

//   ProviderContainer setProviderContainer(
//     MockReadUser mockReadUser,
//     MockLogoutUser mockLogoutUser,
//   ) {
//     return ProviderContainer(
//       overrides: [
//         readUserUseCaseProvider.overrideWithValue(mockReadUser),
//         logoutUserUseCaseProvider.overrideWithValue(mockLogoutUser),
//       ],
//     );
//   }

//   group('AppStateNotifier', () {
//     test(
//       'Starting state is initial',
//       () {
//         final container = setProviderContainer(
//           mockReadUser,
//           mockLogoutUser,
//         );
//         const appState = AppState.initial();
//         expect(
//           AppStateNotifier(container.read).currentState,
//           appState,
//         );
//         // container.dispose();
//       },
//     );

//     group("Authenticate State", () {
//       test(
//         'update app state to authenticate when user get logged in',
//         () async {
//           //arrange
//           const user = User(
//             name: "",
//             accountType: AccountType.google,
//           );
//           //act
//           final container = setProviderContainer(
//             mockReadUser,
//             mockLogoutUser,
//           );
//           final appStateNotifier = AppStateNotifier(container.read);
//           await appStateNotifier.authenticateState(user);
//           expect(
//             appStateNotifier.currentState,
//             const AppState.authenticated(user),
//           );
//           container.dispose();
//         },
//       );
//     });

//     group("UnAuthenticate State", () {
//       test(
//         'update app state to unAuthenticate when user get logged out',
//         () async {
//           //arrange
//           const user = User(
//             name: "",
//             accountType: AccountType.google,
//           );
//           when(mockLogoutUser(user.accountType)).thenAnswer(
//             (_) async => Future.value(),
//           );
//           //act
//           final container = setProviderContainer(
//             mockReadUser,
//             mockLogoutUser,
//           );
//           final appStateNotifier = AppStateNotifier(container.read);
//           appStateNotifier.currentState = const AppState.authenticated(user);
//           await appStateNotifier.unAuthenticateState();
//           //assert
//           expect(
//             appStateNotifier.currentState,
//             const AppState.unAuthenticated(),
//           );
//           container.dispose();
//         },
//       );
//     });
//   });
// }
