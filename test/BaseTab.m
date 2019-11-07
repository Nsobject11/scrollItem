//
//  BaseTab.m
//  test
//
//  Created by john on 2019/11/6.
//  Copyright © 2019 qt. All rights reserved.
//

#import "BaseTab.h"

@implementation BaseTab

/**
 同时识别多个手势
 
 @param gestureRecognizer gestureRecognizer description
 @param otherGestureRecognizer otherGestureRecognizer description
 @return return value description
 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}
@end
