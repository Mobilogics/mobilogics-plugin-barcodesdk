/*
 * MLBarcodeScannerPlugIn.m
 *
 * Authors:
 *   Mikimoto <mikimoto@mobilogics.com.tw>
 *
 * Copyright (C) 2013  Authors
 *
 * Released under Creative Commons Attribution-ShareAlike 4.0 International,
 * read the file 'LICENSE.pdf' for more information.
 */

#import "MLBarcodeScannerPlugIn.h"


@implementation MLBarcodeScannerPlugIn

- (void)start:(CDVInvokedUrlCommand *)command {
  [[MLScanner sharedInstance] setup];

  [[MLScanner sharedInstance] addAccessoryDidConnectNotification:self];
  [[MLScanner sharedInstance] addAccessoryDidDisconnectNotification:self];
  [[MLScanner sharedInstance] addReceiveCommandHandler:self];

  NSLog(@"Mobilogics Barcode Scanner start");
  CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];

  [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)stop:(CDVInvokedUrlCommand *)command {
  [[MLScanner sharedInstance] removeAccessoryDidConnectNotification:self];
  [[MLScanner sharedInstance] removeAccessoryDidDisconnectNotification:self];
  [[MLScanner sharedInstance] removeReceiveCommandHandler:self];

  NSLog(@"Mobilogics Barcode Scanner stop");
  CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];

  [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)monitorConnection:(CDVInvokedUrlCommand *)command {
  connectionStatusCallBackId = command.callbackId;
}

- (void)scan:(CDVInvokedUrlCommand *)command {
  receiveCallBackId = command.callbackId;
  [[MLScanner sharedInstance] scan];

  NSLog(@"Mobilogics Barcode Scanner fire a scan shot.");
}

- (void)connectNotify {
  CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"Mobilogics Scanner connected!"];

  [self.commandDelegate sendPluginResult:pluginResult callbackId:connectionStatusCallBackId];
}

- (void)disconnectNotify {
  CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"Mobilogics Scanner disconnected!"];

  [self.commandDelegate sendPluginResult:pluginResult callbackId:connectionStatusCallBackId];
}

- (void)handleInformationUpdate {

}

- (BOOL)isHandler:(NSObject <ReceiveCommandProtocol> *)command {
  if ([command isKindOfClass:[ReceiveCommand class]]) {
    return TRUE;
  }

  return FALSE;
}

- (void)handleRequest:(NSObject <ReceiveCommandProtocol> *)command {
  if ([[command receiveString] isEqualToString:@""]) {
    return;
  }

  CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:[command receiveString]];

  [self.commandDelegate sendPluginResult:pluginResult callbackId:receiveCallBackId];

//    NSString *jsString = [result toSuccessCallbackString:callbackId];
//    [self.webView stringByEvaluatingJavaScriptFromString:jsString];
}

@end