import 'package:paml_serve/app/http/controllers/auth_controller.dart';
import 'package:paml_serve/app/http/controllers/customer_controller.dart';
import 'package:paml_serve/app/http/controllers/loginuser_controller.dart';
import 'package:paml_serve/app/http/controllers/product_controller.dart';
import 'package:paml_serve/app/http/controllers/todo_controller.dart';
import 'package:paml_serve/app/http/controllers/vendor_controller.dart';
import 'package:paml_serve/app/http/middleware/authenticate.dart';
import 'package:vania/vania.dart';

class ApiRoute implements Route {
  @override
  void register() {
    /// Base RoutePrefix
    Router.basePrefix('api');

    //customer route
    Router.post('/create-customer', customerController.create);
    Router.get('/show-customer', customerController.show);
    Router.put('/update-customer/{id}', customerController.update);
    Router.delete('/delete-customer/{id}', customerController.destroy);

    //vendors route
    Router.post('/create-vendor', vendorController.create);
    Router.get('/show-vendors', vendorController.show);
    Router.put('/update-vendors/{id}', vendorController.update);
    Router.delete('/delete-vendors/{id}', vendorController.destroy);

    // product route
    Router.post('/create-product', productController.create);
    Router.get('/show-product', productController.show);
    Router.put('/update-product/{id}', productController.update);
    Router.delete('/delete-product/{id}', productController.destroy);

    //login auth
    Router.group((){
      Router.post('register', authController.register);
      Router.post('login', authController.login);
    }, prefix: 'auth');

    Router.group((){
      Router.patch('update-password', loginuserController.updatePassword);
      Router.get('', loginuserController.index);
    }, prefix: 'user', middleware: [AuthenticateMiddleware()]);

    Router.group((){
      Router.post('todo', todoController.store);
    }, prefix: 'todo', middleware: [AuthenticateMiddleware()]);

    Router.get('me', authController.me).middleware([AuthenticateMiddleware()]);

  }
}
