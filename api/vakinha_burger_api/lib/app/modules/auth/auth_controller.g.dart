// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_controller.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$AuthControllerRouter(AuthController service) {
  final router = Router();
  router.add('GET', r'/', service.find);
  router.add('POST', r'/register', service.register);
  router.add('POST', r'/', service.login);
  return router;
}
