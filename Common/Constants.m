//
//  Constants.m
//  Small Business Manager
//
//  Created by Jesse on 5/30/13.
//  Copyright (c) 2013 Lunar Creations. All rights reserved.
//

#import "Constants.h"

@implementation Constants

#pragma mark - static

+ (NSString *)uuid
{
    CFUUIDRef uuidRef = CFUUIDCreate(NULL);
    CFStringRef uuidStringRef = CFUUIDCreateString(NULL, uuidRef);
    CFRelease(uuidRef);

    return (__bridge NSString *)uuidStringRef;
}

+ (DataType) dataTypeFromString:(NSString*)dataTypeString
{
    if (dataTypeString)
    {
        if ([dataTypeString isEqualToString:@"string"])
        {
            return DataType_string;
        }
        if ([dataTypeString isEqualToString:@"date"])
        {
            return DataType_date;
        }
        if ([dataTypeString isEqualToString:@"number"])
        {
            return DataType_number;
        }
        if ([dataTypeString isEqualToString:@"amount"])
        {
            return DataType_amount;
        }
        if ([dataTypeString isEqualToString:@"view"])
        {
            return DataType_view;
        }
        if ([dataTypeString isEqualToString:@"image"])
        {
            return DataType_image;
        }
        if ([dataTypeString isEqualToString:@"video"])
        {
            return DataType_video;
        }
    }
    else
    {
        NSLog(@"dataTypeFromString: parameter nil");
    }
    return DataType_unknown;
}

+ (NSString*) dataTypeToString:(DataType)dataType
{
    NSString* dataTypeString;
    
    switch (dataType)
    {
        case DataType_string:
            dataTypeString = @"string";
            break;
            
        case DataType_date:
            dataTypeString = @"date";
            break;
            
        case DataType_number:
            dataTypeString = @"number";
            break;
            
        case DataType_amount:
            dataTypeString = @"amount";
            break;
            
        case DataType_view:
            dataTypeString = @"view";
            break;
            
        case DataType_image:
            dataTypeString = @"image";
            break;
            
        case DataType_video:
            dataTypeString = @"video";
            break;
            
        default:
            dataTypeString = @"unknown";
            break;
    }
    return dataTypeString;
}

@end
