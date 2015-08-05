//
//  DefaultContactStore.h
//  JSCore
//
//  Created by Andre Gustavo on 7/17/15.
//  Copyright (c) 2015 Andre Gustavo. All rights reserved.
//

@import Foundation;
#import "ContactStore.h"

@interface DefaultContactStore : NSObject <ContactStore>

- (instancetype) initWithUserDefaults:(NSUserDefaults *)defaults;

@end