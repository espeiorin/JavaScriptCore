//
//  ContactManager.h
//  JSCore
//
//  Created by Andre Gustavo on 7/16/15.
//  Copyright (c) 2015 Andre Gustavo. All rights reserved.
//

@import JavaScriptCore;
#import "Contact.h"
#import "ContactStore.h"

typedef void(^ContactManagerAddCompletion)(NSError *error);

@protocol ContactManager <JSExport>

@property (nonatomic, strong, readonly) NSMutableArray *contacts;
@property (nonatomic, strong) id<ContactStore> store;

- (BOOL) addContact:(id<Contact>)contact;
- (void) deleteContact:(id<Contact>)contact;

@end