import 'package:paml_serve/app/models/vendors.dart';
import 'package:vania/vania.dart';

class VendorController extends Controller {

     Future<Response> index() async {
          return Response.json({'message':'Hello World'});
     }

     Future<Response> create(Request request) async {
      try {
        final vendorData = request.input();

        await Vendors().query().insert(vendorData);
        return Response.json(
          {
            "message": "Data vendor berhasil ditambahkan",
            "data": vendorData
          }, 201
        );
      } catch (e) {
        return Response.json(
          {
            "message": "Gagal input data vendor",
            "error": e.toString()
          },500,
        );
      }
     }

     Future<Response> store(Request request) async {
          return Response.json({});
     }

     Future<Response> show(Request request) async {
          try {
            final vendorData = await Vendors().query().get();

            return Response.json(
              {
                "message":"list data vendor",
                "data": vendorData
              },201,
            );
          } catch (e) {
            return Response.json(
              {
                "message":"Permintaan gagal di proses",
                "error": e.toString()
              },500,
            );
          }

     }

     Future<Response> edit(int id) async {
          return Response.json({});
     }

     Future<Response> update(Request request,int id) async {
      try {
        
        final body = await request.input();
        final vendor = body['vend_name'];
        final address = body['vend_address'];
        final city = body['vend_kota'];
        final state = body['vend_state'];
        final zip = body['vend_zip'];
        final country = body['vend_country'];

        final result = await Vendors().query()
        .where('vend_id','=', id)
        .update(
          {
            "vend_name": vendor,
            "vend_address": address,
            "vend_kota": city,
            "vend_state": state,
            "vend_zip": zip,
            "vend_country": country
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
            'message': 'Data vendor tidak ditemukan atau tidak ada perubahan',
          }, 404, // Not Found
        );
      }

      } catch (e) {
        return Response.json(
          {
            'message':'Terjadi kesalahan saat update data vendor',
            'error':e.toString(),
          },500
        );
      }
     }

     Future<Response> destroy(Request request, int id) async {
          try {
            await Vendors().query().where('vend_id', '=',id).delete();

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

final VendorController vendorController = VendorController();

