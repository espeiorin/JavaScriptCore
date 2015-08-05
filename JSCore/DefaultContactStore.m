//
//  DefaultContactStore.m
//  JSCore
//
//  Created by Andre Gustavo on 7/17/15.
//  Copyright (c) 2015 Andre Gustavo. All rights reserved.
//

#import "DefaultContactStore.h"

static NSString *const kContactStoreKey = @"contacts";

@interface DefaultContactStore ()

@property (nonatomic, strong) NSUserDefaults *defaults;

@end

@implementation DefaultContactStore

- (instancetype) initWithUserDefaults:(NSUserDefaults *)defaults {
  self = [super init];
  if (!self) {
    return nil;
  }
  
  self.defaults = defaults;
  
  return self;
}

- (void) storeContacts:(NSArray *)contacts {
  NSData *data = [NSKeyedArchiver archivedDataWithRootObject:contacts];
  [self.defaults setObject:data forKey:kContactStoreKey];
  [self.defaults synchronize];
}

- (NSArray *) retrieveContacts {
  NSData *data = [self.defaults dataForKey:kContactStoreKey];
  NSArray *contacts = [NSKeyedUnarchiver unarchiveObjectWithData:data];
  return contacts ?: @[];
}

@end