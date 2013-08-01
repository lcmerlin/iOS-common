//
//  LC_XMLElement.h
//  LC Manager
//
//  Created by Jesse Coats on 5/8/13.
//  Copyright (c) 2013 Jesse Coats. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LC_XMLElement : NSObject <NSCopying>

// property

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSMutableArray *subElements; // LC_XMLElement*
@property (nonatomic, retain) NSMutableDictionary *attributesDict;
@property (nonatomic, retain) NSString *textValue;

// init

- (id) initWithName:(NSString*)name;

// class

- (NSMutableString*) attributesStringValue;

- (NSMutableString*) fullStringValue:(NSMutableDictionary*)attributeDuplicates; // the root element and entire subtree
- (NSMutableString*) fullStringValue:(NSMutableDictionary*)attributeDuplicates atDepth:(NSInteger)depth; // the element and entire subtree
- (void) addAttribute:(NSString*)attributeKey withValue:(NSString*)attributeValue;
- (void) addAttributes:(NSMutableDictionary*)attributesDict;
- (void) addSubElement:(LC_XMLElement*)subElement;
- (void) addTextValue:(NSString*)textValue;

// NSCopying

- (id) copyWithZone:(NSZone *)zone;

@end
