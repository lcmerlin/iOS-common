//
//  Constants.h
//  Small Business Manager
//
//  Created by Jesse on 5/30/13.
//  Copyright (c) 2013 Lunar Creations. All rights reserved.
//

#import <Foundation/Foundation.h>

#define FONTNAME_MAIN @"Cabin"
#define FONTSIZE_MAIN 20
#define DEBUG_INVENTORY_FILENAME @"Inventory Data.xml"
#define DEBUG_INVENTORY_FILENAME_SAVE @"Inventory Data.xml"
#define DEBUG_METADATA_FILENAME @"Inventory Metadata.xml"

#define MAX_IMAGE_WIDTH 200
#define TAG_OFFSET_CELL 10000
#define POPOVER_WIDTH 400.0
#define TYPE_WIDTH 200
#define TYPE_HEIGHT 30

#define KEY_NAME @"1"
#define KEY_DESCRIPTION @"2"

typedef enum dataTypes
{
    DataType_unknown,
    DataType_empty,
    DataType_string,
    DataType_number,
    DataType_amount,
    DataType_data,
    DataType_date,
    DataType_view,
    DataType_image,
    DataType_video,
} DataType;

typedef enum undoAction
{
    UndoAction_unknown,
    UndoAction_delete,
    UndoAction_insert,
    UndoAction_edit,
    UndoAction_reorder
} UndoAction;


typedef enum inventoryObjectType
{
    InventoryObjectType_Unknown,
    InventoryObjectType_Inventory,
    InventoryObjectType_Detail,
    InventoryObjectType_Level
} InventoryObjectType;

typedef enum alertType_AddItemDiscard
{
    AlertType_Unknown,
    AlertType_Information,
    AlertType_AddItemDiscard,
    AlertType_LevelDelete
} AlertType;


@interface Constants : NSObject

+ (DataType)dataTypeFromString:(NSString*)dataTypeString;
+ (NSString*)dataTypeToString:(DataType)dataType;
+ (NSString *)uuid;

@end
