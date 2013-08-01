//
//  LC_DataValue.h
//  Small Business Manager
//
//  Created by Jesse on 6/2/13.
//  Copyright (c) 2013 Lunar Creations. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Constants.h"
#import "LC_Amount.h"
#import "LC_XMLElement.h"

@interface LC_DataValue : NSObject

// property

@property (nonatomic, assign) DataType dataType;

@property (nonatomic, retain) NSString *stringValue;
@property (nonatomic, retain) LC_Amount *amountValue;
@property (nonatomic, assign) double numberValue;
@property (nonatomic, retain) NSDate *dateValue;
@property (nonatomic, retain) NSMutableData *dataValue;

@property (nonatomic, retain) NSString *rangeString;
@property (nonatomic, assign) NSInteger displayDigits;

// init

- (id) init;
- (id) initWithType:(DataType)dataType;

// static

+ (LC_DataValue*)dataValueFromString:(NSString*)stringValue;
+ (LC_DataValue*)dataValueFromNumber:(double)number;
+ (LC_DataValue*)dataValueFromAmount:(LC_Amount*)amountValue;
+ (LC_DataValue*)dataValueFromDate:(NSDate*)dateValue;
+ (LC_DataValue*)dataValueFromData:(NSData*)dataValue;
+ (LC_DataValue*)dataValueEmpty;

// class

- (LC_XMLElement*)valueAsXMLChildNode:(NSString*)key;
- (LC_XMLElement*)valueAsXMLNode:(NSString*)elementName;
- (NSString*) valueAsString;
- (LC_Amount*) valueAsAmount;
- (NSDate*) valueAsDate;
- (NSData*) valueAsData;
- (NSNumber*) valueAsNumber;

// NSObject

- (NSString *)description;
- (BOOL)isEqual:(id)object;

// NSCopying

- (id) copyWithZone:(NSZone *)zone;


@end
