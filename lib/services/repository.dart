import 'package:http/http.dart' as http;



class Repository {

http_postHotcars(data) async {
  return await http.post(Uri.parse('https://cotraceweb.vercel.app/api/Hot_cars/gethotcars'), body: data);
}


http_postReport(data) async {
  return await http.post(Uri.parse('https://cotraceweb.vercel.app/api/reported/addreport'), body: data);
}


http_postLocation(data) async {
  return await http.post(Uri.parse('https://cotraceweb.vercel.app/api/location/addlocation'), body: data);
}





}


// http_postLocation(String url) async {
//   return await http.post(Uri.parse('https://dx00sw.deta.dev/checkplatenumber?url=' + url));
// }
