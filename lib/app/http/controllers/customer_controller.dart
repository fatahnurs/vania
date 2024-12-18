import 'package:paml_serve/app/models/user.dart';
import 'package:vania/vania.dart';

class CustomerController extends Controller {

     Future<Response> index() async {
          return Response.json({'message':'Hello World'});
     }

     Future<Response> create(Request request) async {
      try {
        final customerData = request.input();

        await User().query().insert(customerData);

        return Response.json(
          {
            'message': 'Customer berhasil ditambahkan',
            'data': customerData,
          }, 201
        );
      } catch (e) {
        return Response.json(
          {
            'message': 'Server Error, Coba lagi nanti',
          },500
        );
      }
     }

     Future<Response> show(Request request) async {
       try {
         final customer = await User().query().get();

         return Response.json(
          {
            "message": 'Data Customer',
            "data": customer,
            
          },201
         );
       } catch (e) {
         return Response.json(
          {
            'message': "Tidak dapat mengambil data, coba lagi nanti"
          }, 500
         );
       }

     }

     Future<Response> edit(int id) async {
          return Response.json({});
     }

     Future<Response> update(Request request, int id) async {
      try {

  
        final body = await request.input();
        final name = body['cust_name'];
        final address = body['cust_address'];
        final city = body['cust_city'];
        final state = body['cust_state'];
        final zip = body['cust_zip'];
        final country = body['cust_country'];
        final telp = body['cust_telp'];

        final result = await User()
        .query()
        .where('cust_id', '=', id)
        .update(
          {
            "cust_name": name,
            "cust_address": address,
            "cust_city": city,
            "cust_state": state,
            "cust_zip": zip,
            "cust_country": country,
            "cust_telp": telp
          }
        );

        if (result > 0) {
        return Response.json(
          {
            'message': 'Data berhasil diupdate',
            'updated_id': id,
          }, 200, // OK
        );
      } else {
        return Response.json(
          {
            'message': 'Data tidak ditemukan atau tidak ada perubahan',
          }, 404, // Not Found
        );
      }
        
      } catch (e) {
        return Response.json(
          {
            'message':'Terjadi kesalahan saat update data',
            'error':e.toString(),
          },500
        );
      }

     }

     Future<Response> destroy(Request request, int id) async {
          try {
            await User().query().where('cust_id','=',id).delete();

            return Response.json(
              {
                
                'message': 'customer berhasil di hapus'
              }
            );
          } catch (e) {
            return Response.json(
              {
                'message':'Gagal menghapus user',
                'error': e.toString()
              }
            );
          }
     }
}


final CustomerController customerController = CustomerController();

