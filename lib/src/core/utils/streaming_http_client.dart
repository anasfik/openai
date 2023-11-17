import 'package:fetch_client/fetch_client.dart' as fetch;
import 'package:http/http.dart' as http;

fetch.FetchClient createWebClient() =>
    fetch.FetchClient(mode: fetch.RequestMode.cors);

http.Client createIoClient() => http.Client();
