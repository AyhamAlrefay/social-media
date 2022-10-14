import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:whatsapp/features/chat/presentation/bloc/save_data/save_data_bloc.dart';
import 'core/datasources/firebase_storage_datasources.dart';
import 'features/auth/data/datasources/remote_data_sources.dart';
import 'features/auth/data/repositories/repositories_impl.dart';
import 'features/auth/domain/repositories/repository.dart';
import 'features/auth/domain/usecases/get_current_user_data_use_case.dart';
import 'features/auth/domain/usecases/get_other_user_data_usecase.dart';
import 'features/auth/domain/usecases/save_user_data_use_case.dart';
import 'features/auth/domain/usecases/sign_in_with_phone_number_use_case.dart';
import 'features/auth/domain/usecases/verify_otp_use_case.dart';
import 'features/auth/presentation/bloc/get_users_data/get_users_data_bloc.dart';
import 'features/auth/presentation/bloc/save_user_data/save_user_data_bloc.dart';
import 'features/auth/presentation/bloc/sign_in_with_phone_number/sign_in_with_phone_number_bloc.dart';
import 'features/chat/data/datasourses/remote_data_sources.dart';
import 'features/chat/data/repositories/chat_repositories_impl.dart';
import 'features/chat/domain/repositories/chat_repositories.dart';
import 'features/chat/domain/usecases/get_chat_contacts_use_case.dart';
import 'features/chat/domain/usecases/get_message_user_usecase.dart';
import 'features/chat/presentation/bloc/get_contacts_user/get_contacts_user_bloc.dart';

import 'features/chat/domain/usecases/send_message_usecase.dart';
import 'features/chat/presentation/bloc/get_messages_user/get_message_user_bloc.dart';
import 'features/chat/presentation/bloc/send_messages_user/send_message_user_bloc.dart';
final sl=GetIt.instance;
Future<void>init()async{

  ///Bloc
  sl.registerFactory(() => SignInWithPhoneNumberBloc(signInWithPhoneNumberUseCase: sl(), verifyOtpUseCase: sl()));
  sl.registerFactory(() => SaveUserDataBloc(saveUserDataUseCase: sl(),getCurrentUserDataUseCase: sl()));
  sl.registerFactory(() => GetMessageUserBloc(getMessageUserUseCase: sl()));
  sl.registerFactory(() => SendMessageUserBloc(sendMessageUserUseCase: sl()));
  sl.registerFactory(() => GetUsersDataBloc(getCurrentUserDataUseCase: sl(), getOtherUserDataUseCase: sl()));
  sl.registerFactory(() =>GetContactsUserBloc(getChatContactsUseCase: sl()));
  sl.registerFactory(() =>SaveDataBloc());




  /// UseCases
  sl.registerLazySingleton(() => SignInWithPhoneNumberUseCase(repository: sl()));
  sl.registerLazySingleton(() => VerifyOtpUseCase(authRepository: sl()));
  sl.registerLazySingleton(() => SaveUserDataUseCase(authRepository: sl()));
  sl.registerLazySingleton(() => GetCurrentUserDataUseCase(authRepository: sl()));
  sl.registerLazySingleton(() => GetMessageUserUseCase(chatRepositories: sl()));
  sl.registerLazySingleton(() => SendMessageUseCase(chatRepositories: sl()));
  sl.registerLazySingleton(() => GetChatContactsUseCase(chatRepositories: sl()));
  sl.registerLazySingleton(() => GetOtherUserDataUseCase(authRepository:sl() ));



  ///Repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoriesImpl(remoteDataSources: sl()));
  sl.registerLazySingleton<ChatRepositories>(() => ChatRepositoriesImpl(chatRemoteDataSources: sl()));


  ///RemoteDataSources
  sl.registerLazySingleton<AuthRemoteDataSources>(() => AuthRemoteDataSourcesImpl(auth: sl(), firestore: sl()));
  sl.registerLazySingleton<ChatRemoteDataSources>(() => ChatRemoteDataSourcesImpl(auth: sl(), firestore: sl(), firebaseStorageDataSources: sl()));
  sl.registerLazySingleton(() => FirebaseStorageDataSources( firebaseStorage: sl()));

  ///Firebase
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => FirebaseStorage.instance);
}