import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:whatsapp/core/datasources/firebase_storage_datasources.dart';
import 'package:whatsapp/features/auth/data/datasources/remote_data_sources.dart';
import 'package:whatsapp/features/auth/data/repositories/repositories_impl.dart';
import 'package:whatsapp/features/auth/domain/repositories/repository.dart';
import 'package:whatsapp/features/auth/domain/usecases/get_current_user_data_use_case.dart';
import 'package:whatsapp/features/auth/domain/usecases/save_user_data_use_case.dart';
import 'package:whatsapp/features/auth/domain/usecases/sign_in_with_phone_number_use_case.dart';
import 'package:whatsapp/features/auth/domain/usecases/verify_otp_use_case.dart';
import 'package:whatsapp/features/auth/presentation/bloc/save_user_data/save_user_data_bloc.dart';
import 'package:whatsapp/features/auth/presentation/bloc/sign_in_with_phone_number/sign_in_with_phone_number_bloc.dart';
import 'package:whatsapp/features/chat/data/datasourses/remote_data_sources.dart';
import 'package:whatsapp/features/chat/data/repositories/chat_repositories_impl.dart';
import 'package:whatsapp/features/chat/domain/repositories/chat_repositories.dart';
import 'package:whatsapp/features/chat/domain/usecases/get_message_user_usecase.dart';
import 'package:whatsapp/features/chat/presentation/bloc/get_message_user/get_message_user_bloc.dart';
final sl=GetIt.instance;
Future<void>init()async{

  ///Bloc
  sl.registerFactory(() => SignInWithPhoneNumberBloc(signInWithPhoneNumberUseCase: sl(), verifyOtpUseCase: sl()));
  sl.registerFactory(() => SaveUserDataBloc(saveUserDataUseCase: sl(),getCurrentUserDataUseCase: sl()));
  sl.registerFactory(() => GetMessageUserBloc(getMessageUserUseCase: sl()));


  /// UseCases
  sl.registerLazySingleton(() => SignInWithPhoneNumberUseCase(repository: sl()));
  sl.registerLazySingleton(() => VerifyOtpUseCase(authRepository: sl()));
  sl.registerLazySingleton(() => SaveUserDataUseCase(authRepository: sl()));
  sl.registerLazySingleton(() => GetCurrentUserDataUseCase(authRepository: sl()));
  sl.registerLazySingleton(() => GetMessageUserUseCase(chatRepositories: sl()));


  ///Repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoriesImpl(remoteDataSources: sl()));
  sl.registerLazySingleton<ChatRepositories>(() => ChatRepositoriesImpl(chatRemoteDataSources: sl()));


  ///RemoteDataSources
  sl.registerLazySingleton<AuthRemoteDataSources>(() => AuthRemoteDataSourcesImpl(auth: sl(), firestore: sl()));
  sl.registerLazySingleton<ChatRemoteDataSources>(() => ChatRemoteDataSourcesImpl(auth: sl(), firestore: sl()));
  sl.registerLazySingleton(() => FirebaseStorageDataSources( firebaseStorage: sl()));

  ///Firebase
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => FirebaseStorage.instance);
}