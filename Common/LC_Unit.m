//
//  Unit.m
//  LC Manager
//
//  Created by Jesse Coats on 4/21/13.
//  Copyright (c) 2013 Jesse Coats. All rights reserved.
//

#import "LC_Unit.h"

@implementation LC_Unit
//

#pragma mark - init

- (id) initWithName:(NSString*)unitName
{
    self = [super init];
    if (self)
    {
        _unitName = unitName;
    }
    return self;
}

- (NSString*) stringValue
{
    return self.unitName;
}

#pragma mark - NSObject

- (BOOL)isEqual:(id)object
{
    if ([object isKindOfClass:[LC_Unit class]])
    {
        LC_Unit *unit = object;
        return (self.unitName == unit.unitName && self.unitType == unit.unitType);
    }
    
    return NO;
}


#pragma mark - NSCopying

- (id) copyWithZone:(NSZone*)zone
{
    LC_Unit* copyUnit = [[LC_Unit allocWithZone:zone] initWithName:self.unitName];
    copyUnit.unitType = self.unitType;
    
    return copyUnit;
}

@end
