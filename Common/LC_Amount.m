//
//  Amount.m
//  LC Manager
//
//  Created by Jesse Coats on 4/21/13.
//  Copyright (c) 2013 Jesse Coats. All rights reserved.
//

#import "LC_Amount.h"

@implementation LC_Amount

#pragma mark - init

- (id)initWithAmount:(NSNumber*)amount andUnits:(NSString*)units
{
    self = [super init];
    if (self)
    {
        _amount = amount;
        _units = [units copy];
    }
    return self;
}

#pragma mark - static

+ (id)amountWithValue:(NSString*)value
{
    NSNumber *number;
    NSString *units;

    NSScanner *scanner = [NSScanner scannerWithString:value];
    units = [[scanner string] substringFromIndex:[scanner scanLocation]];
    double doubleVal = 0.0;
    number = [NSNumber numberWithDouble:[scanner scanDouble:&doubleVal]];
    
    LC_Amount *amount = [[LC_Amount alloc] initWithAmount:number andUnits:units];
    
    return amount;
}

- (NSString*)stringValue
{
    NSMutableString* unitStringValue = [NSMutableString stringWithFormat:@"%@ %@", self.amount, self.units];
    return unitStringValue;
}

- (NSString*)stringValueInParens
{
    return [NSString stringWithFormat:@"(%@)", [self stringValue]];
}

#pragma mark - NSObject

- (BOOL)isEqual:(id)object
{
    if ([object isKindOfClass:[LC_Amount class]])
    {
        LC_Amount *amount = object;
        return (self.amount == amount.amount && [self.units isEqual:amount.units]);
    }
    
    return NO;
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone*)zone
{
    LC_Amount* amountCopy = [[LC_Amount allocWithZone:zone] init];
    amountCopy.amount = self.amount;
    amountCopy.units = self.units;
    
    return amountCopy;
}

@end
