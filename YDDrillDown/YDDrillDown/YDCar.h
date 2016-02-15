//
//  YDCar.h
//  YDDrillDown
//
//  Created by badman on 16/2/15.
//  Copyright © 2016年 dengtao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YDCar : NSObject

@property (nonatomic, strong) NSString *make;
@property (nonatomic, strong) NSString *model;
@property (nonatomic, strong) NSString *imageName;

- (id)initWithMake:(NSString *)carMake model:(NSString *)carModel imageName:(NSString *)carImageName;

@end
