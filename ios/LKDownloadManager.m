#import <Foundation/Foundation.h>

#import "React/RCTBridgeModule.h"
#import "React/RCTEventEmitter.h"

@interface RCT_EXTERN_MODULE(LKDownloadManager, RCTEventEmitter) //To support event emitter

RCT_EXTERN_METHOD(
                  download:(NSString *)url
                  toFilePath:(NSString *)toFilePath
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter: (RCTPromiseRejectBlock)reject
                  )
RCT_EXTERN_METHOD(
                  downloadWithProgress:(NSString *)url
                  toFilePath:(NSString *)toFilePath
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter: (RCTPromiseRejectBlock)reject
                  )

@end
