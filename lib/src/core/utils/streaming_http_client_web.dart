import 'package:fetch_client/fetch_client.dart' as fetch;

fetch.FetchClient createClient() =>
    fetch.FetchClient(mode: fetch.RequestMode.cors);
