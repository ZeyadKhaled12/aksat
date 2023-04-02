
import 'package:aksat/features/account_payments/domain/usecases/pay_uc.dart';
import 'package:aksat/features/account_payments/domain/usecases/search_for_bill_uc.dart';
import 'package:get_it/get_it.dart';
import '../../features/account_payments/data/datasource/ap_remote_data_source.dart';
import '../../features/account_payments/data/repository/ap_repo.dart';
import '../../features/account_payments/domain/repository/base_ap_repo.dart';
import '../../features/account_payments/domain/usecases/choose_filters_uc.dart';
import '../../features/account_payments/domain/usecases/get_contracts_list_uc.dart';
import '../../features/account_payments/domain/usecases/search_uc.dart';
import '../../features/account_payments/domain/usecases/get_ap_list_uc.dart';
import '../../features/account_payments/presentation/controller/account_payments_bloc.dart';
import '../../features/add_new_contract/data/datasource/anc_local_data_source.dart';
import '../../features/add_new_contract/data/datasource/anc_remote_data_source.dart';
import '../../features/add_new_contract/data/repository/anc_repo.dart';
import '../../features/add_new_contract/domain/repository/base_anc_repo.dart';
import '../../features/add_new_contract/domain/usecases/add_new_contract_uc.dart';
import '../../features/add_new_contract/domain/usecases/update_anc_info_uc.dart';
import '../../features/add_new_contract/presentation/controller/anc_bloc.dart';
import '../../features/start/data/datasource/start_remote_data_source.dart';
import '../../features/start/data/repository/start_repo.dart';
import '../../features/start/domain/repository/base_start_repo.dart';
import '../../features/start/domain/usecases/login_uc.dart';
import '../../features/start/domain/usecases/sign_up_uc.dart';
import '../../features/start/domain/usecases/verified_email_uc.dart';
import '../../features/start/presentation/controller/start_bloc.dart';

final sl = GetIt.instance;

class ServicesLocator {
  void init() {
    //Bloc
    sl.registerFactory(() => StartBloc(sl(), sl(), sl()));
    sl.registerFactory(() => AncBloc(sl(), sl()));
    sl.registerFactory(() => AccountStatementBloc(sl(), sl(), sl(), sl(), sl(), sl()));

    //Use Case
    sl.registerLazySingleton(() => LoginUc(sl()));
    sl.registerLazySingleton(() => SignUpUc(sl()));
    sl.registerLazySingleton(() => VerifiedEmailUc(sl()));

    sl.registerLazySingleton(() => UpdateAncInfoUc(sl()));
    sl.registerLazySingleton(() => AddNewContractUc(sl()));

    sl.registerLazySingleton(() => GetContractsListUc(sl()));
    sl.registerLazySingleton(() => GetApListUc(sl()));

    sl.registerLazySingleton(() => ChooseFiltersUc(sl()));
    sl.registerLazySingleton(() => SearchUc(sl()));

    sl.registerLazySingleton(() => PayUc(sl()));
    sl.registerLazySingleton(() => SearchForBillUc(sl()));

    //Repo
    sl.registerLazySingleton<BaseStartRepo>(() => StartRepo(sl()));
    sl.registerLazySingleton<BaseAncRepo>(() => AncRepo(sl(), sl()));
    sl.registerLazySingleton<BaseApRepo>(() => ApRepo(sl()));

    //Data Source
    sl.registerLazySingleton<BaseStartRemoteDataSource>(
        () => StartRemoteDataSource());

    sl.registerLazySingleton<BaseAncLocalDataSource>(
        () => AncLocalDataSource());
    sl.registerLazySingleton<BaseAncRemoteDataSource>(
        () => AncRemoteDataSource());

    sl.registerLazySingleton<BaseApRemoteDataSource>(
            () => ApRemoteDataSource());
  }
}
