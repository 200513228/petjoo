import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petjoo/infrastructure/model/transport_advert_model.dart';
import 'package:petjoo/infrastructure/model/transport_reservation_model.dart';
import 'package:petjoo/modules/home/view/welcome_view.dart';
import 'package:petjoo/presentation/animal_advert/advert_image_input/advert_image_input_view.dart';
import 'package:petjoo/presentation/animal_advert/advert_map_input/view/advert_map_input_view.dart';
import 'package:petjoo/presentation/animal_advert/view/advert_detail_view.dart';
import 'package:petjoo/presentation/animal_advert/view/advert_input_view.dart';
import 'package:petjoo/presentation/animal_advert/view/advert_search_view.dart';
import 'package:petjoo/presentation/animal_advert/view/advert_user_list_view.dart';
import 'package:petjoo/presentation/animal_transport/view/transport_advert_booking_view.dart';
import 'package:petjoo/presentation/animal_transport/view/transport_advert_detail_owner_view.dart';
import 'package:petjoo/presentation/animal_transport/view/transport_advert_detail_view.dart';
import 'package:petjoo/presentation/animal_transport/view/transport_advert_image_input_view.dart';
import 'package:petjoo/presentation/animal_transport/view/transport_advert_input_view.dart';
import 'package:petjoo/presentation/animal_transport/view/transport_advert_map_view.dart';
import 'package:petjoo/presentation/animal_transport/view/transport_advert_shift_input_view.dart';
import 'package:petjoo/presentation/auth/view/auth_view.dart';
import 'package:petjoo/infrastructure/model/advert_model.dart';
import 'package:petjoo/presentation/auth/view/forgot_password_view.dart';
import 'package:petjoo/presentation/auth/view/login_view.dart';
import 'package:petjoo/presentation/auth/view/register_view.dart';
import 'package:petjoo/presentation/auth/view/tutorial_view.dart';
import 'package:petjoo/presentation/chat/view/chat_list_view.dart';
import 'package:petjoo/presentation/chat/view/chat_message_list_view.dart';
import 'package:petjoo/presentation/common/profile/profile_view.dart';
import 'package:petjoo/presentation/settings/view/about_view.dart';
import 'package:petjoo/presentation/settings/view/account_settings_view.dart';
import 'package:petjoo/presentation/settings/view/app_settings_view.dart';
import 'package:petjoo/presentation/settings/view/document_detail_view.dart';
import 'package:petjoo/presentation/settings/view/settings_view.dart';
import 'package:petjoo/presentation/transport_reservation/view/transport_reservation_detail_view.dart';
import 'package:petjoo/presentation/transport_reservation/view/transport_reservation_list_view.dart';
import 'package:petjoo/presentation/transport_reservation/view/transport_reservation_request_list_view.dart';
import 'package:petjoo/product/models/chat_model.dart';
import 'docs.dart';

class Routes {
  static const String tutorial = "/";
  static const String auth = "auth";
  static const String login = "auth/login";
  static const String register = "auth/register";
  static const String forgotPassword = "auth/login/forgotPassword";
  static const String navigation = "navigation";
  static const String reservationList = "navigation/reservationList";
  static const String reservationRequestList =
      "navigation/reservationRequestList";
  static const String reservationDetail =
      "navigation/reservationList/reservationDetail";
  static const String advertUserList = "navigation/advertUserList";
  static const String advertInput = "navigation/advertUserList/advertInput";
  static const String advertMapInput =
      "navigation/advertUserList/advertInput/advertMapInput";
  static const String advertImageInput =
      "navigation/advertUserList/advertInput/advertMapInput/advertImageInput";
  static const String advertSearch = "navigation/advertSearch";
  static const String advertDetail = "navigation/advertDetail";
  static const String chats = "navigation/chats";
  static const String messages = "navigation/chats/messages";
  static const String profile = "navigation/profile";
  static const String transportAdvertDetail =
      "navigation/transportAdvertDetail";
  static const String transportAdvertBooking =
      "navigation/transportAdvertDetail/transportAdvertBooking";
  static const String transportAdvertDetailOwner =
      "navigation/transportAdvertDetailOwner";
  static const String transportAdvertInput =
      "navigation/transportAdvertDetailOwner/transportAdvertInput";
  static const String transportAdvertShiftInput =
      "navigation/transportAdvertDetailOwner/transportAdvertShiftInput";
  static const String transportAdvertImageInput =
      "navigation/transportAdvertDetailOwner/transportAdvertInput/transportAdvertImageInput";
  static const String transportAdvertMapInput =
      "navigation/transportAdvertDetailOwner/transportAdvertInput/transportAdvertMapInput";
  static const String settings = "navigation/settings";
  static const String appSettings = "navigation/settings/appSettings";
  static const String accountSettings = "navigation/settings/accountSettings";
  static const String privacyPolicy = "navigation/settings/privacyPolicy";
  static const String termsOfUse = "navigation/settings/termsOfUse";
  static const String about = "navigation/settings/about";

  static Route<dynamic>? onGenerateRoute(RouteSettings routeSettings) {
    late Widget page;
    switch (routeSettings.name) {
      case tutorial:
        page = const TutorialView();
        break;
      case auth:
        page = const AuthView();
        break;
      case login:
        page = const LoginView();
        break;
      case register:
        page = const RegisterView();
        break;
      case forgotPassword:
        page = ForgotPasswordView(routeSettings.arguments as String);
        break;
      case navigation:
        // page = const NavigationView();
        page = const WelcomeView();

        break;
      case reservationList:
        page = const TransportReservationListView();
        break;
      case reservationRequestList:
        page = const TransportReservationRequestListView();
        break;
      case reservationDetail:
        page = TransportReservationDetailView(
            routeSettings.arguments as TransportReservationModel);
        break;
      case advertUserList:
        page = const AdvertUserListView();
        break;
      case advertInput:
        page = AdvertInputView(routeSettings.arguments as AdvertModel?);
        break;
      case advertMapInput:
        page = AdvertMapInputView(routeSettings.arguments as AdvertModel);
        break;
      case advertImageInput:
        page = AdvertImageInputView(routeSettings.arguments as AdvertModel);
        break;
      case advertSearch:
        page = const AdvertSearchView();
        break;
      case advertDetail:
        page = AdvertDetailView(routeSettings.arguments as AdvertModel);
        break;
      case transportAdvertDetail:
        page = TransportAdvertDetailView(
            routeSettings.arguments as TransportAdvertModel);
        break;
      case transportAdvertBooking:
        page = TransportAdvertBookingView(
            routeSettings.arguments as TransportAdvertModel);
        break;
      case profile:
        page = const ProfileView();
        break;
      case transportAdvertDetailOwner:
        page = const TransportAdvertDetailOwnerView();
        break;
      case transportAdvertInput:
        page = TransportAdvertInputView(
            routeSettings.arguments as TransportAdvertModel);
        break;
      case transportAdvertShiftInput:
        page = TransportAdvertShiftInputView(
            routeSettings.arguments as TransportAdvertModel);
        break;
      case transportAdvertImageInput:
        page = TransportAdvertImageInputView(
            routeSettings.arguments as TransportAdvertModel);
        break;
      case transportAdvertMapInput:
        page = TransportAdvertMapView(
            geoPoint: routeSettings.arguments as GeoPoint);
        break;
      case settings:
        page = const SettingsView();
        break;
      case appSettings:
        page = const AppSettingsView();
        break;
      case accountSettings:
        page = const AccountSettingsView();
        break;
      case termsOfUse:
        page = DocumentDetailView(Docs.termsOfUse);
        break;
      case privacyPolicy:
        page = DocumentDetailView(Docs.privacyPolicy);
        break;
      case about:
        page = const AboutView();
        break;
      case chats:
        page = const ChatListView();
        break;
      case messages:
        page = ChatMessageListView(routeSettings.arguments as ChatModel);
        break;
    }
    log(routeSettings.name ?? "Unknown", name: "Route");
    return MaterialPageRoute(
        builder: (context) => page, settings: routeSettings);
  }
}
