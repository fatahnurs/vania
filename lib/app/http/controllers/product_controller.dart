import 'package:paml_serve/app/models/product.dart';
import 'package:vania/vania.dart';

class ProductController extends Controller {

     Future<Response> index() async {
          return Response.json({'message':'Hello World'});
     }

     Future<Response> create(Request request) async {
      try {
        final productData = request.input();

        await Product().query().insert(productData);

        return Response.json(
          {
            'message': 'Product berhasil ditambahkan',
            'data': productData,
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

     Future<Response> store(Request request) async {
          return Response.json({});
     }

     Future<Response> show(Request request) async {
      try {
         final productData = await Product().query().get();

         return Response.json(
          {
            "message": 'Data Product',
            "data": productData,
            
          },201
         );
       } catch (e) {
         return Response.json(
          {
            'message': "Tidak dapat mengambil data Product, coba lagi nanti"
          }, 500
         );
       }
     }

     Future<Response> edit(int id) async {
          return Response.json({});
     }

     Future<Response> update(Request request,int id) async {
        try {

        final body = await request.input();
        final vend_id = body['vend_id'];
        final name = body['prod_name'];
        final price = body['prod_price'];
        final desc = body['prod_desc'];

        final result = await Product()
        .query()
        .where('prod_id', '=', id)
        .update(
          {
            "vend_id": vend_id,
            "prod_name": name,
            "prod_price": price,
            "prod_desc": desc
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
        await Product().query().where('prod_id','=',id).delete();

        return Response.json(
          {
            'message': 'produk berhasil di hapus'
          }
        );
      } catch (e) {
        return Response.json(
        {
          'message':'Gagal menghapus produk',
          'error': e.toString()
        }
      );
      }
     }
}

final ProductController productController = ProductController();

