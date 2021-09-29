import 'dart:convert';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:keluarga_bintoro/models/models.dart';
import 'package:keluarga_bintoro/shared/shareds.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_provider.dart';
part 'leave_provider.dart';

const API_URL = "https://hr.bintorocorp.co.id/api";
