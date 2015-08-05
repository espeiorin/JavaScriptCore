//
//  ViewController.m
//  JSCore
//
//  Created by Andre Gustavo on 7/16/15.
//  Copyright (c) 2015 Andre Gustavo. All rights reserved.
//

#import "ViewController.h"
@import JavaScriptCore;
#import "DefaultContactManager.h"
#import "DefaultContact.h"
#import "DefaultContactStore.h"

@interface ViewController () <UIWebViewDelegate>

@property (nonatomic, weak) IBOutlet UIWebView *webView;
@property (nonatomic, strong, readonly) DefaultContactManager *contactManager;
@property (nonatomic, strong) JSValue *rightBarButtonItemValue;
@property (nonatomic, strong) JSValue *leftBarButtonItemValue;

@end

@implementation ViewController

@synthesize contactManager = _contactManager;

- (void)viewDidLoad {
  [super viewDidLoad];
  
  NSString *filePath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
  NSURL *fileURL = [NSURL URLWithString:filePath];
  NSURLRequest *request = [NSURLRequest requestWithURL:fileURL];
  [self.webView loadRequest:request];
}

#pragma mark - UI Web View Delegate
- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
  NSLog(@"%@", error);
}

- (void) webViewDidFinishLoad:(UIWebView *)webView {
  JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
  self.title = [[context evaluateScript:@"document.title"] toString];
  
  self.rightBarButtonItemValue = [context evaluateScript:@"rightBarButtonItem"];
  self.leftBarButtonItemValue = [context evaluateScript:@"leftBarButtonItem"];
  
  // debug
  [context setExceptionHandler:^(JSContext *context, JSValue *value) {
    NSLog(@"JS Exception %@", value);
  }];
  
  context[@"contactManager"] = self.contactManager;
  context[@"Contact"] = [DefaultContact class];
  
  context[@"callNumber"] = ^(NSString *phoneNumber) {
    phoneNumber = [NSString stringWithFormat:@"tel:%@", phoneNumber];
    NSURL *url = [NSURL URLWithString:phoneNumber];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
      [[UIApplication sharedApplication] openURL:url];
    } else {
      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning"
                                                      message:@"Invalid number or the device can't make phone calls"
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
      [alert show];
    }
  };
  
  [context evaluateScript:@"pageDidLoad()"];
}

#pragma mark -
- (void) setLeftBarButtonItemValue:(JSValue *)leftBarButtonItemValue {
  _leftBarButtonItemValue = leftBarButtonItemValue;
  self.navigationItem.leftBarButtonItem = nil;
  
  NSString *title = [[_leftBarButtonItemValue valueForProperty:@"title"] toString];
  if (![title isEqualToString:@"undefined"]) {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:title
                                                                             style:UIBarButtonItemStyleDone
                                                                            target:self
                                                                            action:@selector(performLeftBarButtonItemAction)];
  }
}

- (void) setRightBarButtonItemValue:(JSValue *)rightBarButtonItemValue {
  _rightBarButtonItemValue = rightBarButtonItemValue;
  self.navigationItem.rightBarButtonItem = nil;
  NSString *title = [[_rightBarButtonItemValue valueForProperty:@"title"] toString];
  
  if (![title isEqualToString:@"undefined"]) {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:title
                                                                              style:UIBarButtonItemStyleDone
                                                                             target:self
                                                                             action:@selector(performRightBarButtonItemAction)];
  }
}

- (void) performRightBarButtonItemAction {
  [[self.rightBarButtonItemValue valueForProperty:@"callback"] callWithArguments:nil];
}

- (void) performLeftBarButtonItemAction {
  [[self.leftBarButtonItemValue valueForProperty:@"callback"] callWithArguments:nil];
}

#pragma mark -
- (DefaultContactManager *) contactManager {
  if (_contactManager) {
    return _contactManager;
  }
  
  _contactManager = [[DefaultContactManager alloc] init];
  _contactManager.store = [self store];
  
  return _contactManager;
}

- (DefaultContactStore *) store {
  return [[DefaultContactStore alloc] initWithUserDefaults:[NSUserDefaults standardUserDefaults]];
}

@end