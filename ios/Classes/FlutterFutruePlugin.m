#import "FlutterFutruePlugin.h"
#if __has_include(<flutter_futrue/flutter_futrue-Swift.h>)
#import <flutter_futrue/flutter_futrue-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_futrue-Swift.h"
#endif

@implementation FlutterFutruePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterFutruePlugin registerWithRegistrar:registrar];
}
@end
