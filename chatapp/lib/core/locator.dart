import 'package:get_it/get_it.dart';
import 'package:chatapp/core/services/firestore_db.dart';
import 'package:chatapp/viewModels/chats_model.dart';

GetIt getIt = GetIt.instance;

setupLocators(){
  getIt.registerLazySingleton(() => FirestoreDB()); 

  getIt.registerFactory(() => ChatsModel());
}