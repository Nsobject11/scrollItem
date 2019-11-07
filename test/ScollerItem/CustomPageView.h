//
//  CustomPageView.h
//  ZhiDi
//
//  Created by john on 2019/7/18.
//  Copyright © 2019 qt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomProperty.h"
@class CustomProperty;
NS_ASSUME_NONNULL_BEGIN
typedef void(^itemCutBlock)(NSInteger index);
typedef void(^showPopView)(void);

@interface CustomPageDelegate : NSObject
-(void)willPageDrag;
@end

@interface CustomPageView : UIView
- (instancetype)initWithFrame:(CGRect)frame property:(CustomProperty *)property titles:(NSArray *)titles controlls:(NSArray *)controllS con:(UIViewController *)con;
@property (nonatomic,strong)UIScrollView * mainScro;
@property (nonatomic ,copy) itemCutBlock block;
@property (nonatomic,assign)NSInteger SelectIndex;
@property (nonatomic,assign) BOOL rightChooseItem;
@property (nonatomic ,copy) showPopView showblock;
- (void)updateBrandBtnType;
@end

NS_ASSUME_NONNULL_END
