//
//  ContactManager.m
//  JSCore
//
//  Created by Andre Gustavo on 7/16/15.
//  Copyright (c) 2015 Andre Gustavo. All rights reserved.
//

#import "DefaultContactManager.h"
#import "Contact.h"
@import AddressBook;

@implementation DefaultContactManager

@synthesize contacts = _contacts;
@synthesize store = _store;

- (NSMutableArray *) contacts {
  if (_contacts) {
    return _contacts;
  }
  
  _contacts = [[self.store retrieveContacts] mutableCopy];
  return _contacts;
}

- (BOOL) contactExists:(id<Contact>)contact {
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@ and phone = %@", contact.name, contact.phone];
  NSArray *filtered = [self.contacts filteredArrayUsingPredicate:predicate];
  return filtered.count > 0;
}

- (BOOL) addContact:(id<Contact>)contact {
  if (contact.name.length == 0 ||
      contact.phone.length == 0 ||
      [self contactExists:contact]) {
    
    return NO;
  }
  
  [self.contacts addObject:contact];
  
  [self.store storeContacts:[self.contacts copy]];
  
  return YES;
}

- (void) deleteContact:(id<Contact>)contact {
  [self.contacts removeObject:contact];
  [self.store storeContacts:[self.contacts copy]];
}

@end