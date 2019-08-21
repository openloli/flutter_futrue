#import "FlutterFutruePlugin.h"
#import <flutter_futrue/flutter_futrue-Swift.h>

@implementation FlutterFutruePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterFutruePlugin registerWithRegistrar:registrar];
}
@end
