import 'package:http/http.dart' as http;



class DataHelper {
 //function for update or put
  void editarProduct(String _id, String activity) async {
  

    String myUrl = "http://192.168.1.56:3000/product/$_id";
    http.put(myUrl,
        body: {
         activity : true,
        }).then((response){
      print('Response status : ${response.statusCode}');
      print('Response body : ${response.body}');
    });
  }
}