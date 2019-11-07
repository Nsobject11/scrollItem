//
//  CustomProperty.h
//  ZhiDi
//
//  Created by john on 2019/7/19.
//  Copyright © 2019 qt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomSegment.h"
#import "CustomPageView.h"
NS_ASSUME_NONNULL_BEGIN
@interface CustomProperty : NSObject
@property (nonatomic,strong)UIColor * normalTitleColor;//标题未选中时的颜色
@property (nonatomic,strong)UIColor * SelectTitleColor;//标题选中时的颜色

@property (nonatomic,assign)BOOL isScrollTitle;//是否需要滚动
@property (nonatomic,assign)NSInteger normalFont;//未选中时的字体大小
@property (nonatomic,assign)CGFloat titleMargin;//滚动时的间距 默认40
@property (nonatomic,assign)BOOL isAutoAdjustTitlesWidth;//是否需要自适应标题宽度
@property (nonatomic,assign)BOOL ScrollItem;//是否需要手势拖动滑动
@property (nonatomic,assign)NSInteger left_margin;//拒左的间距
@property (nonatomic,assign)NSInteger indexAddWidth;//第几个左右间距
/**选中第几个 默认第一个*/
@property (nonatomic,assign)NSInteger selectIndex;
@end
NS_ASSUME_NONNULL_END
