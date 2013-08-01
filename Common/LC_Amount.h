//
//  Amount.h
//  LC Manager
//
//  Created by Jesse Coats on 4/21/13.
//  Copyright (c) 2013 Jesse Coats. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LC_Unit.h"

@interface LC_Amount : NSObject <NSCopying>

@property (nonatomic, retain) NSNumber *amount;
@property (nonatomic, retain) LC_Unit *units;

// init

- (id)initWithAmount:(NSNumber*)amount andUnits:(NSString*)units;

// static

+ (id)amountWithValue:(NSString*)value;

// class

- (NSString*)stringValue;
- (NSString*)stringValueInParens;

// NSObject

- (BOOL)isEqual:(id)object;

// NSCopying

- (id)copyWithZone:(NSZone*)zone;

@end
