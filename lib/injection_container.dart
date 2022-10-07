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
final sl=GetIt.instance;
Future<void>init()async{
  //!Features - auth
  //Bloc
  sl.registerFactory(() => SignInWithPhoneNumberBloc(signInWithPhoneNumberUseCase: sl(), verifyOtpUseCase: sl()));
  sl.registerFactory(() => SaveUserDataBloc(saveUserDataUseCase: sl(),getCurrentUserDataUseCase: sl()));
  // UseCases
  sl.registerLazySingleton(() => SignInWithPhoneNumberUseCase(repository: sl()));
  sl.registerLazySingleton(() => VerifyOtpUseCase(authRepository: sl()));
  sl.registerLazySingleton(() => SaveUserDataUseCase(authRepository: sl()));
  sl.registerLazySingleton(() => GetCurrentUserDataUseCase(authRepository: sl()));
  //Repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoriesImpl(remoteDataSources: sl()));
  //RemoteDataSources
  sl.registerLazySingleton<AuthRemoteDataSources>(() => AuthRemoteDataSourcesImpl(auth: sl(), firestore: sl()));
  sl.registerLazySingleton(() => FirebaseStorageDataSources( firebaseStorage: sl()));
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => FirebaseStorage.instance);
}