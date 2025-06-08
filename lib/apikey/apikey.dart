import 'package:flutter_dotenv/flutter_dotenv.dart';

final String api_key = dotenv.env['API_KEY'] ?? '';
