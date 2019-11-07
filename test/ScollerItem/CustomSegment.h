//
//  CustomSegment.h
//  ZhiDi
//
//  Created by john on 2019/7/18.
//  Copyright © 2019 qt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomProperty.h"
@class CustomProperty;
NS_ASSUME_NONNULL_BEGIN
@protocol CustomDelegate <NSObject>
@optional
-(void)setUpTitleView:(UIButton *)btn index:(NSInteger)indexS lastIndex:(NSInteger)lastIndex;
@end

@interface CustomSegment : UIView
@property (nonatomic,assign)id<CustomDelegate>CDelegate;
@property (nonatomic,assign)NSInteger selectIndex;

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles property:(CustomProperty *)property;
/**设置当前选中的index**/
- (void)setSelectedIndex:(NSInteger)index animated:(BOOL)animated;
/**滑动中底部view的偏移计算**/
- (void)changeIndicatorFrameByStretch:(CGFloat)scrollX;

- (void)updateLastBtnUI;

@end

@interface CusTomSegBtn : UIButton
@property (nonatomic,strong)CustomProperty * proper;
@end
NS_ASSUME_NONNULL_END
