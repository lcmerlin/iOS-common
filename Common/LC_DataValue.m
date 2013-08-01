//
//  LC_DataValue.m
//  Small Business Manager
//
//  Created by Jesse on 6/2/13.
//  Copyright (c) 2013 Lunar Creations. All rights reserved.
//

#import "LC_DataValue.h"

@implementation LC_DataValue
//

#pragma mark - init

- (id)init
{
    if (self = [super init])
    {
        self.amountValue = [[LC_Amount alloc] init];
    }
    
    return self;
}

- (id) initWithType:(DataType)dataType
{
    if (self = [self init])
    {
        self.dataType = dataType;
    }
    
    return self;
}


#pragma mark - static

+ (LC_DataValue*)dataValueFromString:(NSString*)stringValue
{
    LC_DataValue *returnDataValue = [[LC_DataValue alloc] init];
    returnDataValue.stringValue = [stringValue copy];
    returnDataValue.dataType = DataType_string;
    return returnDataValue;
}

+ (LC_DataValue*)dataValueFromNumber:(double)number
{
    LC_DataValue *returnDataValue = [[LC_DataValue alloc] init];
    returnDataValue.numberValue = number;
    returnDataValue.dataType = DataType_number;
    return returnDataValue;
}

+ (LC_DataValue*)dataValueFromAmount:(LC_Amount*)amountValue
{
    LC_DataValue *returnDataValue = [[LC_DataValue alloc] init];
    returnDataValue.amountValue = [amountValue copy];
    returnDataValue.dataType = DataType_amount;
    return returnDataValue;
}

+ (LC_DataValue*)dataValueFromDate:(NSDate*)dateValue
{
    LC_DataValue *returnDataValue = [[LC_DataValue alloc] init];
    returnDataValue.dateValue = [dateValue copy];
    returnDataValue.dataType = DataType_date;
    return returnDataValue;
}
+ (LC_DataValue*)dataValueFromData:(NSData*)dataValue
{
    LC_DataValue *returnDataValue = [[LC_DataValue alloc] init];
    returnDataValue.dataValue = [NSData dataWithData:dataValue];
    returnDataValue.dataType = DataType_data;
    return returnDataValue;
}

+ (LC_DataValue*)dataValueEmpty
{
    LC_DataValue *returnDataValue = [[LC_DataValue alloc] init];
    returnDataValue.dataType = DataType_empty;
    return returnDataValue;
}

#pragma mark - NSCopying

- (id) copyWithZone:(NSZone *)zone
{
    LC_DataValue *copyItem;
    switch (self.dataType)
    {
        case DataType_amount:
            copyItem = [LC_DataValue dataValueFromAmount:self.amountValue];
            break;

        case DataType_data:
            copyItem = [LC_DataValue dataValueFromData:self.dataValue];

        case DataType_date:
            copyItem = [LC_DataValue dataValueFromDate:self.dateValue];
            break;
            
        case DataType_number:
            copyItem = [LC_DataValue dataValueFromNumber:self.numberValue];
            break;
            
        case DataType_string:
            copyItem = [LC_DataValue dataValueFromString:self.stringValue];
            break;
            
            
        default:
            break;
    }

    copyItem.rangeString = [self.rangeString mutableCopyWithZone:zone];
    
    return copyItem;
}


#pragma mark - class

- (LC_XMLElement*) valueAsXMLChildNode:(NSString*)key
{
    LC_XMLElement *node = [[LC_XMLElement alloc] initWithName:[Constants dataTypeToString:self.dataType]];
    [node setAttributesDict:[NSMutableDictionary dictionaryWithObject:key forKey:@"key"]];
    switch (self.dataType)
    {
        case DataType_amount:
        case DataType_string:
        case DataType_date:
        case DataType_number:
            [node setTextValue:[self valueAsString]];
            break;
            
         case DataType_data:
            break;
            
        default:
            break;
    }
    
    return node;
}

- (LC_XMLElement*)valueAsXMLNode:(NSString*)elementName
{
    LC_XMLElement *node = [[LC_XMLElement alloc] initWithName:elementName];
    switch (self.dataType)
    {
        case DataType_amount:
        case DataType_string:
        case DataType_date:
        case DataType_number:
            [node setTextValue:[self valueAsString]];
            break;
            
        case DataType_data:
            break;
            
        default:
            break;
    }
    
    return node;
}


- (NSString*) valueAsString
{
    NSString* stringValue;
    
    switch (self.dataType)
    {
        case DataType_amount:
            stringValue = [self.valueAsAmount stringValue];
            break;
            
        case DataType_string:
            stringValue = self.stringValue;
            break;
            
        case DataType_date:
        {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
            stringValue = [dateFormatter stringFromDate:self.dateValue];
            break;
        }
            
        case DataType_number:
        {
            NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
            stringValue = [numberFormatter stringFromNumber:self.valueAsNumber];
            break;
        }
            
        default:
            stringValue = @"";
            break;
    }
    return stringValue;
}

- (LC_Amount*) valueAsAmount
{
    if (self.dataType == DataType_amount)
    {
        LC_Amount *amountValue = self.amountValue;
        return amountValue;
    }
    return nil;
}

- (NSDate*) valueAsDate
{
    if (self.dataType == DataType_date)
    {
        return self.dateValue;
    }
    return nil;
}

- (NSData*) valueAsData
{
    if (self.dataType == DataType_data)
    {
        return self.dataValue;
    }
    return nil;
}

- (NSNumber*) valueAsNumber
{
    if (self.dataType == DataType_number)
    {
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        return [numberFormatter numberFromString:self.stringValue];
    }
    return nil;
}

- (NSNumber*) rangeMin
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    NSRange separatorRange = [self.rangeString rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:@"="]];
    return [numberFormatter numberFromString:[self.rangeString substringToIndex:separatorRange.location]];
}

- (NSNumber*) rangeMax
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    NSRange separatorRange = [self.rangeString rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:@"="]];
    return [numberFormatter numberFromString:[self.rangeString substringFromIndex:separatorRange.location + 1]];
}

- (void) setAmountValue:(LC_Amount*)amountValue
{
    self->_amountValue = amountValue;
    self->_dataType = DataType_amount;
}

- (void) setStringValue:(NSMutableString*)stringValue
{
    self->_stringValue = [stringValue copy];
    self->_dataType = DataType_string;
}

- (void) setDateValue:(NSDate*)dateValue
{
    self->_dateValue = dateValue;
    self->_dataType = DataType_date;
}

- (void) setDataValue:(NSData*)dataValue
{
    self->_dataValue = [NSMutableData dataWithData:dataValue];
}

- (void) setNumberValue:(double)numberValue
{
    self->_numberValue = numberValue;
    self->_dataType = DataType_number;
}

#pragma mark - NSObject

- (BOOL)isEqual:(id)object
{
    if ([object isKindOfClass:[LC_DataValue class]])
    {
        LC_DataValue *dataValue = object;
        if (self.dataType == dataValue.dataType)
        {
            switch (self.dataType)
            {
                case DataType_amount:
                    return [self.amountValue isEqual:dataValue.amountValue];
                    break;
                    
                case DataType_string:
                    return [self.stringValue isEqualToString:dataValue.stringValue];
                    break;
                    
                case DataType_date:
                {
                    return [self.dateValue isEqualToDate:dataValue.dateValue];
                    break;
                }
                    
                case DataType_number:
                {
                    return (self.numberValue == dataValue.numberValue);
                    break;
                }
                    
                case DataType_empty:
                    return YES;
                    break;
                    
                default:
                    NSLog(@"LC_DataValue isEqual not implemented for type %@", [Constants dataTypeToString:self.dataType]);
                    return NO;
                    break;
            }
        }
    }
    
    return NO;
}

- (NSString *)description
{
    return [self valueAsString];
}

@end
