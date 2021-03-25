import 'dart:async';
import 'dart:io';

import 'package:fdottedline/fdottedline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get.dart' as get2;
import 'package:provider/provider.dart';
import 'package:siresep/cubit/cubit.dart';
import 'package:siresep/models/models.dart';
import 'package:siresep/services/services.dart';
import 'package:siresep/shared/shared.dart';
import 'package:siresep/extensions/extensions.dart';
import 'package:siresep/ui/widgets/widgets.dart';

part 'detail_resep/detail_resep_page.dart';
part 'detail_resep/update_resep_page.dart';
part 'main_page/main_page.dart';
part 'main_page/list_my_favorite_page.dart';
part 'main_page/list_my_resep_page.dart';
part 'main_page/list_resep.dart';
part 'main_page/profil_page.dart';
part 'login_page.dart';
part 'wrapper.dart';
part 'main_splash_screen.dart';
