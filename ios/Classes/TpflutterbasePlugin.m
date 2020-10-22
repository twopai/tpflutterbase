#import "TpflutterbasePlugin.h"
#if __has_include(<tpflutterbase/tpflutterbase-Swift.h>)
#import <tpflutterbase/tpflutterbase-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "tpflutterbase-Swift.h"
#endif

@implementation TpflutterbasePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftTpflutterbasePlugin registerWithRegistrar:registrar];
}
@end
