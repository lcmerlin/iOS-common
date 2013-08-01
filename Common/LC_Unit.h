//
//  Unit.h
//  LC Manager
//
//  Created by Jesse Coats on 4/21/13.
//  Copyright (c) 2013 Jesse Coats. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LC_Unit : NSObject <NSCopying>

typedef enum unitType
{
    UNIT_WEIGHT,
    UNIT_SOLID_MEASURE,
    UNIT_LIQUID_MEASURE,
    UNIT_EACH
} UnitType;

@property (nonatomic, retain) NSString *unitName;
@property (nonatomic, assign) UnitType *unitType;

- (id) initWithName:(NSString*)unitName;

- (NSString*) stringValue;

// NSObject

- (BOOL)isEqual:(id)object;

// NSCopying

- (id) copyWithZone:(NSZone*)zone;

@end
