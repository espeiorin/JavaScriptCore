//
//  Contact.h
//  JSCore
//
//  Created by Andre Gustavo on 7/16/15.
//  Copyright (c) 2015 Andre Gustavo. All rights reserved.
//

@import JavaScriptCore;

@protocol Contact <JSExport>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *company;
@property (nonatomic, strong) NSString *phone;

+ (instancetype) contactWithName:(NSString *)name 
                         company:(NSString *)company
                           phone:(NSString *)phone;

@end