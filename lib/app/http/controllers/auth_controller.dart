import 'dart:io';

import 'package:paml_serve/app/models/loginuser.dart';
import 'package:vania/vania.dart';

class AuthController extends Controller {

     Future<Response> register(Request request) async {
      request.validate({
        'name': "required",
        'email': 'required|email',
        'password': 'required'
      }, {
        'email.required': 'nama tidak boleh kosong',
        'email.email': 'email tidak valid',
        "password.required": "pasword tidak boleh kosong",
         
      });

      final name= request.input('name');
      final email = request.input('email');
      var password = request.input('password');

      var user = await Loginuser().query().where('email', '=', email).first();
      if (user != null){
        return Response.json({
          "message":"user sudah ada",

        }, 409,);
      }

      password = Hash().make(password);
      await Loginuser().query().insert({
        "name": name,
        "email": email,
        "password": password,
        "created_at": DateTime.now().toIso8601String()
      });
      return Response.json({
        "meesage": "berhasil mendaftarkan user"
      },201 );

     }

     Future<Response> login(Request request) async {
      request.validate({
        'email':'required | email',
        'password':'required',
      }, {
        'email.required':'email tidak boleh kosong',
        'email.email': 'email tidak valid',
        'password.required': 'pasword tidak boleh kosong',
      });

      final email = request.input('email');
      var password = request.input('password').toString();

      var user = await Loginuser().query().where('email', '=', email). first();
      if (user == null){
        return Response.json({
          "message": "user belum terdaftar",
        }, 409);
      }
      
      if (!Hash().verify(password, user['password'])){
        return Response.json({
          "message":"kata sandi yang dimasukan salah"
        },401);
      }

      final token = await Auth().login(user)
      .createToken(expiresIn: Duration(days: 30), withRefreshToken: true);

      return Response.json({
        "message": "Berhasil login",
        "token": token,
      });
     }

     Future<Response> store(Request request) async {
          return Response.json({});
     }

     Future<Response> me(Request request) async {
          Map? user = Auth().user();

          if (user != null) {
            user.remove('password');
            return Response.json({
              "message": "success",
              "data":user
            }, HttpStatus.ok);
          }

          return Response.json({
            "message":"success",
            "data":""
          }, HttpStatus.notFound);
     }

     Future<Response> edit(int id) async {
          return Response.json({});
     }

     Future<Response> update(Request request,int id) async {
          return Response.json({});
     }

     Future<Response> destroy(int id) async {
          return Response.json({});
     }
}

final AuthController authController = AuthController();

