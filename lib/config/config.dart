import 'package:flutter_expired_app/env.dart';

// 开发环境
// const SERVER_HOST_DEV = 'http://127.0.0.1:9292/api/v1/expire/';
const SERVER_HOST_DEV = 'https://api.syc.im/api/v1/expire/';

// 生产环境
const SERVER_HOST_PROD = 'https://api.syc.im/api/v1/expire/';

const SERVER_API_URL = ENV == "DEV" ? SERVER_HOST_DEV : SERVER_HOST_PROD;
