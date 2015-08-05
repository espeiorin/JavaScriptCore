//
//  ContactStore.h
//  JSCore
//
//  Created by Andre Gustavo on 7/17/15.
//  Copyright (c) 2015 Andre Gustavo. All rights reserved.
//

@import Foundation;

@protocol ContactStore <NSObject>

- (void) storeContacts:(NSArray *)contacts;
- (NSArray *) retrieveContacts;

@end