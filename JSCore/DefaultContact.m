//
//  DefaultContact.m
//  JSCore
//
//  Created by Andre Gustavo on 7/16/15.
//  Copyright (c) 2015 Andre Gustavo. All rights reserved.
//

#import "DefaultContact.h"

@implementation DefaultContact

@synthesize name = _name;
@synthesize company = _company;
@synthesize phone = _phone;

- (instancetype) initWithCoder:(NSCoder *)aDecoder {
  self = [super init];
  if (!self) {
    return nil;
  }
  
  self.name = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(name))];
  self.company = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(company))];
  self.phone = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(phone))];
  
  return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeObject:self.name forKey:NSStringFromSelector(@selector(name))];
  [aCoder encodeObject:self.company forKey:NSStringFromSelector(@selector(company))];
  [aCoder encodeObject:self.phone forKey:NSStringFromSelector(@selector(phone))];
}


+ (instancetype) contactWithName:(NSString *)name
                         company:(NSString *)company
                           phone:(NSString *)phone {
  
  DefaultContact *contact = [[DefaultContact alloc] init];
  contact.name = name;
  contact.company = company;
  contact.phone = phone;
  
  return contact;
}

@end