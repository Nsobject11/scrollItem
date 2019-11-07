//
//  CustomProperty.m
//  ZhiDi
//
//  Created by john on 2019/7/19.
//  Copyright © 2019 qt. All rights reserved.
//

#import "CustomProperty.h"

@implementation CustomProperty
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isScrollTitle = YES;
        self.titleMargin = 40;
        self.isAutoAdjustTitlesWidth = NO;
        self.normalTitleColor = [UIColor blackColor];
        self.SelectTitleColor = [UIColor orangeColor];
        self.selectIndex = 0;
        self.left_margin = 0;
        self.ScrollItem = YES;
        self.normalFont = 18;
        self.indexAddWidth = 2;
    }
    return self;
}
@end
