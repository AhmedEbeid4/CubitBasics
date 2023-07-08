import 'package:cubit_code_lab/utils/data_status.dart';

abstract class Repository{
  Future<DataStatus<dynamic>> getFirstPage();
  Future<DataStatus<dynamic>> getNextPage(int page);
}