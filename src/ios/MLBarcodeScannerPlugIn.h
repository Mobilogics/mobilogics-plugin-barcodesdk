#import <Foundation/Foundation.h>
#import <Cordova/CDVPlugin.h>
#import <Barcode/Framework.h>


@interface MLBarcodeScannerPlugIn : CDVPlugin <ReceiveCommandHandler, NotificationHandler> {
  NSString *receiveCallBackId;
  NSString *connectionStatusCallBackId;
}

- (void)start:(CDVInvokedUrlCommand *)command;
- (void)stop:(CDVInvokedUrlCommand *)command;

- (void)monitorConnection:(CDVInvokedUrlCommand *)command;
- (void)scan:(CDVInvokedUrlCommand *)command;

@end