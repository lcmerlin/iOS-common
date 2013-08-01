//
//  LC_XMLElement.m
//  LC Manager
//
//  Created by Jesse Coats on 5/8/13.
//  Copyright (c) 2013 Jesse Coats. All rights reserved.
//

#import "LC_XMLElement.h"
#import "LC_DataValue.h"

@implementation LC_XMLElement

#pragma mark - init

- (id) init
{
    self = [super init];
    if (self)
    {
        _attributesDict = [NSMutableDictionary dictionaryWithCapacity:1];
        self.textValue = nil;
    }
    return self;
}

- (id) initWithName:(NSString*)name
{
    self = [self init];
    if (self)
    {
        _name = [name copy];
    }
    return self;
}

#pragma mark - class

- (void) addTextValue:(NSString*)textValue
{
    self.textValue = [textValue copy];
}

- (NSMutableString*) attributesStringValueFilterDuplicates:(NSMutableDictionary*)attributeDuplicates
{
    NSMutableString *attributesString = [NSMutableString stringWithString:@""];
    
    for (NSString* key in self.attributesDict)
    {
        LC_DataValue *value = [self.attributesDict objectForKey:key];
        if (value == [attributeDuplicates valueForKey:key])
        {
        }
        else
        {
            [attributesString appendFormat:@" %@=\"%@\"", key, value];
        }
    }
    
    return attributesString;
}


- (NSMutableString*) attributesStringValue
{
    NSMutableString *attributesString = [NSMutableString stringWithString:@""];
    
    for (NSString* key in self.attributesDict)
    {
        NSString *value = [self.attributesDict objectForKey:key];
        [attributesString appendFormat:@" %@=\"%@\"", key, value];
    }
    
    return attributesString;
}

- (NSMutableString*) fullStringValue:(NSMutableDictionary*)attributeDuplicates
{
    return [self fullStringValue:attributeDuplicates atDepth:0];
}

- (NSMutableString*) fullStringValue:(NSMutableDictionary*)attributeDuplicates atDepth:(NSInteger)depth
{
    NSMutableString *indent = [NSMutableString stringWithString:@""];
    for (int i = 0; i < depth; i++)
    {
        [indent appendString:@"\t"];
    }
    
    NSMutableString *elementString = [NSMutableString stringWithFormat:@"%@<%@%@>", indent, self.name, [self attributesStringValueFilterDuplicates:attributeDuplicates]];

    if (self.textValue)
    {
        [elementString appendString:[NSMutableString stringWithFormat:@"%@", self.textValue]];
    }
    
    if (self.subElements.count)
    {
        [elementString appendString:@"\n"];
        for (int subTree = 0; subTree < self.subElements.count; subTree += 1)
        {
            LC_XMLElement *subElement = [self.subElements objectAtIndex:subTree];
            [elementString appendString:[subElement fullStringValue:self.attributesDict atDepth:depth+1]];
        }
    }

    if (self.subElements.count)
    {
        [elementString appendString:[NSMutableString stringWithFormat:@"%@</%@>\n", indent, self.name]];
    }
    else
    {
        [elementString appendString:[NSMutableString stringWithFormat:@"</%@>\n", self.name]];
    }
    
    return elementString;
}

- (void) addAttribute:(NSString*)attributeKey withValue:(NSString*)attributeValue
{
    [self.attributesDict setValue:attributeValue forKey:attributeKey];
}

- (void) addAttributes:(NSMutableDictionary *)attributesDict
{
    [self.attributesDict addEntriesFromDictionary:attributesDict];
}

- (void) addSubElement:(LC_XMLElement*)subElement
{
    if (self.subElements)
    {
        [self.subElements addObject:subElement];
    }
    else
    {
        self.subElements = [NSMutableArray arrayWithObject:subElement];
    }
}

#pragma mark - NSCopying

- (id) copyWithZone:(NSZone *)zone
{
    LC_XMLElement *copy = [[LC_XMLElement allocWithZone:zone] initWithName:self.name];
    copy.textValue = [self.textValue copyWithZone:zone];
    copy.attributesDict = [self.attributesDict mutableCopyWithZone:zone];
    copy.subElements = [self.subElements mutableCopyWithZone:zone];

    return copy;
}

@end
