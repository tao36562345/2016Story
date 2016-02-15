//
//  YDCar.m
//  YDDrillDown
//
//  Created by badman on 16/2/15.
//  Copyright © 2016年 dengtao. All rights reserved.
//

#import "YDCar.h"

@implementation YDCar

- (id)initWithMake:(NSString *)carMake model:(NSString *)carModel imageName:(NSString *)carImageName
{
    self = [super init];
    if (self)
    {
        self.make = [carMake copy];
        self.model = [carModel copy];
        self.imageName = [carImageName copy];
    }
    return self;
}

@end
