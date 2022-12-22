import 'package:dartz/dartz.dart';

import '../../../../shared/contracts/i_error.dart';
import '../../../../shared/errors/datasource_error.dart';
import '../../pokedex_module.dart';

class ReadPokemonRepository extends IReadPokemonRepository {
  final IReadPokemonDatasource datasource;

  ReadPokemonRepository(this.datasource);
  @override
  Future<Either<IError, ReadPokemonResponse>> call(
    ReadPokemonParams params,
  ) async {
    try {
      var result = await datasource(params);
      return Right(result);
    } on DataSourceError catch (e) {
      return Left(e);
    } catch (e, s) {
      return Left(DataSourceError(message: e.toString(), stackTrace: s));
    }
  }
}
