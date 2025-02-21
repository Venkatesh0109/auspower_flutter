import 'package:auspower_flutter/constants/keys.dart';
import 'package:auspower_flutter/providers/auth_provider.dart';
import 'package:auspower_flutter/providers/company_provider.dart';
import 'package:auspower_flutter/providers/filter_store_provider.dart';
import 'package:auspower_flutter/providers/info_provider.dart';
import 'package:auspower_flutter/providers/power_consumption_provider.dart';
import 'package:auspower_flutter/providers/profile_provider.dart';
import 'package:auspower_flutter/providers/sql_db_provider.dart';
import 'package:auspower_flutter/providers/subscription_provider.dart';
import 'package:auspower_flutter/providers/table_provider.dart';
import 'package:auspower_flutter/theme/theme_manager.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

/// Declaration for all providers
List<SingleChildWidget> providers = [
  ChangeNotifierProvider<ThemeManager>(create: (context) => ThemeManager()),
  ChangeNotifierProvider<AuthProvider>(create: (context) => AuthProvider()),
  ChangeNotifierProvider<InfoProvider>(create: (context) => InfoProvider()),
  ChangeNotifierProvider<ProfileProvider>(
      create: (context) => ProfileProvider()),
  ChangeNotifierProvider<SubscriptionProvider>(
      create: (context) => SubscriptionProvider()),
  ChangeNotifierProvider<TableProvider>(create: (context) => TableProvider()),
  ChangeNotifierProvider<PowerConsumptionProvider>(
      create: (context) => PowerConsumptionProvider()),
  ChangeNotifierProvider<CompanyProvider>(
      create: (context) => CompanyProvider()),
  ChangeNotifierProvider<SqlDbProvider>(
      create: (context) => SqlDbProvider()),
  ChangeNotifierProvider<FilterStoreProvider>(
      create: (context) => FilterStoreProvider()),
];

var themeManager =
    Provider.of<ThemeManager>(mainKey.currentContext!, listen: false);

var authProvider =
    Provider.of<AuthProvider>(mainKey.currentContext!, listen: false);

var infoProvider =
    Provider.of<InfoProvider>(mainKey.currentContext!, listen: false);

var profileProvider =
    Provider.of<ProfileProvider>(mainKey.currentContext!, listen: false);

var subscriptionProvider =
    Provider.of<SubscriptionProvider>(mainKey.currentContext!, listen: false);
var tableProvider =
    Provider.of<TableProvider>(mainKey.currentContext!, listen: false);
var powerProvider = Provider.of<PowerConsumptionProvider>(
    mainKey.currentContext!,
    listen: false);
var companyProvider =
    Provider.of<CompanyProvider>(mainKey.currentContext!, listen: false);
var sqlProvider =
    Provider.of<SqlDbProvider>(mainKey.currentContext!, listen: false);
var filterProvider =
    Provider.of<FilterStoreProvider>(mainKey.currentContext!, listen: false);
