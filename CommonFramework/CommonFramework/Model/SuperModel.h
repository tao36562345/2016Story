//
//  SuperModel.h
//  CommonFramework
//
//  Created by dengtao on 16/3/29.
//  Copyright © 2016年 shengzhong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mantle.h"
#import "MTLFMDBAdapter.h"

@interface SuperModel : MTLModel<MTLJSONSerializing, MTLFMDBSerializing>

@end