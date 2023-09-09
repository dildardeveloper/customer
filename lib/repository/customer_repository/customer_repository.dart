
import '../../app_url/app_url.dart';
import '../../data/network/network_api_services.dart';

class CustomerRepository{
  final _apiService  = NetworkApiServices() ;
  // ///-------to get all the customers--------///
  // Future<dynamic> getAllCustomersApi() async{
  //   dynamic response = await _apiService.getApi(AppUrl.allCustomers);
  //   return CustomerModel.fromJson(response);
  // }
  ///-------to create the customer--------///
  Future<dynamic> createCustomerApi(var data) async{
    dynamic response = await _apiService.updateApi(data, AppUrl.createCustomer);
    return response ;
  }
  ///-------to get only one customer details--------///
  Future<dynamic> getCustomerApi() async{
    dynamic response = await _apiService.getApi(AppUrl.getCustomer);
    return response ;
  }
  ///-------to update customer--------///
  Future<dynamic> updateCustomerApi(var data ) async{
    dynamic response = await _apiService.updateApi(data, AppUrl.updateCustomer);
    return response ;
  }
  ///-------to delete the customer record--------///
  Future<dynamic> deleteCustomerApi(int id) async{
    dynamic response = await _apiService.getApi(AppUrl.deleteCustomer + '?id=$id');
    return response ;
  }
}