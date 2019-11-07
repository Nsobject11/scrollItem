//
//  CustomSegment.m
//  ZhiDi
//
//  Created by john on 2019/7/18.
//  Copyright © 2019 qt. All rights reserved.
//

#import "CustomSegment.h"
#import "UIView+Extension.h"
#import "NSString+Justu.h"
static CGFloat const contentSizeXOff = 20.0; 
static CGFloat const lineWidth = 18;
static CGFloat const lineHeight = 3;
@interface CustomSegment()<UIScrollViewDelegate>
{
    CGFloat _currentWidth;
    NSUInteger _currentIndex;
    NSUInteger _oldIndex;
}
//滚动view
@property (nonatomic,strong)UIScrollView * scroBottom;
//滚动条
@property (strong, nonatomic) UIView *scrollLine;
@property (nonatomic,copy)NSArray * titles;
/** 缓存所有标题label */
@property (nonatomic, strong) NSMutableArray *titleViews;
// 缓存计算出来的每个标题的宽度
@property (nonatomic, strong) NSMutableArray *titleWidths;
/**属性设置*/
@property (nonatomic,strong)CustomProperty * cusProper;
@end

@implementation CustomSegment
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles property:(CustomProperty *)property{
    if (self = [super initWithFrame:frame]) {
        _currentIndex = 0;
        _oldIndex = 0;
        _currentWidth = frame.size.width;
        self.titles = titles;
        self.cusProper = property;
        [self initSet];
        [self setUI];
    }
    return self;
}
-(void)initSet{
    self.titleViews = [NSMutableArray array];
    self.titleWidths = [NSMutableArray array];
}
-(void)setUI{
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.scroBottom];
    [self setTitlesUI];//添加滑动的title
    [self setUpTitleViewsPosition];
    [self setupScrollLineAndCover];
    [self.scroBottom addSubview:self.scrollLine];
    if (self.cusProper.isScrollTitle) { // 设置滚动区域
        CusTomSegBtn *lastTitleView = (CusTomSegBtn *)self.titleViews.lastObject;
        if (lastTitleView) {
            self.scroBottom.contentSize = CGSizeMake(CGRectGetMaxX(lastTitleView.frame) + contentSizeXOff, 0.0);
        }
    }
}
-(void)setTitlesUI{
    if (self.titles.count == 0) return;
    for (int index=0; index<self.titles.count; index++)  {
        NSString * title = self.titles[index];
        CusTomSegBtn *titleView = [[CusTomSegBtn alloc] initWithFrame:CGRectZero];
        titleView.proper = self.cusProper;
        titleView.tag = index;
        titleView.selected = YES;
        [titleView setTitle:title forState:UIControlStateNormal];
        [titleView setTitleColor:self.cusProper.normalTitleColor forState:UIControlStateNormal];
        [titleView setTitleColor:self.cusProper.SelectTitleColor forState:UIControlStateSelected];
        titleView.titleLabel.font = [UIFont systemFontOfSize:self.cusProper.normalFont];
        [titleView addTarget:self action:@selector(titleLabelOnClick:) forControlEvents:UIControlEventTouchUpInside];
        CGFloat titleViewWidth = [title widthWithFont:titleView.titleLabel.font constrainedToHeight:self.frame.size.height]+10;
        [self.titleWidths addObject:@(titleViewWidth)];
        [self.titleViews addObject:titleView];
        [self.scroBottom addSubview:titleView];
    }
}
-(void)titleLabelOnClick:(UIButton *)sender{
    _currentIndex = sender.tag;
    
    if (self.CDelegate && [self.CDelegate respondsToSelector:@selector(setUpTitleView:index:lastIndex:)]) {
        [self.CDelegate setUpTitleView:sender index:_currentIndex lastIndex:_oldIndex];
    }
    [self adjustUIWhenBtnOnClickWithAnimate:true taped:YES];
}
#pragma mark - public helper
- (void)adjustUIWhenBtnOnClickWithAnimate:(BOOL)animated taped:(BOOL)taped {
    if (_currentIndex == _oldIndex && taped) { return; }
    CusTomSegBtn *oldTitleView = (CusTomSegBtn *)self.titleViews[_oldIndex];
    CusTomSegBtn *currentTitleView = (CusTomSegBtn *)self.titleViews[_currentIndex];
    CGFloat animatedTime = animated ? 0.1 : 0.0;
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:animatedTime animations:^{
        oldTitleView.selected = NO;
        currentTitleView.selected = YES;
        if (weakSelf.scrollLine) {
            weakSelf.scrollLine.x = currentTitleView.x + (currentTitleView.width/2-lineWidth/2)  - ((self.cusProper.indexAddWidth==1&&self->_currentIndex==0)?5:0);
            weakSelf.scrollLine.width = lineWidth;
        }
    } completion:^(BOOL finished) {
        [weakSelf adjustTitleOffSetToCurrentIndex:self->_currentIndex];
    }];
    _oldIndex = _currentIndex;
}
/***滑动changeLine**/
- (void)changeIndicatorFrameByStretch:(CGFloat)scrollX {
 
}

#pragma mark ------------------- 滚动的line-----------------------
- (void)setupScrollLineAndCover {
    CusTomSegBtn *firstLabel = (CusTomSegBtn *)self.titleViews[0];
    CGFloat coverCenter = firstLabel.centerX;
    if (self.scrollLine) {
        self.scrollLine.frame = CGRectMake(coverCenter-lineWidth/2, self.height - lineHeight, lineWidth , lineHeight);
    }
}

//重置其他按钮效果
- (void)adjustTitleOffSetToCurrentIndex:(NSInteger)currentIndex {
    _oldIndex = currentIndex;
    // 重置渐变/缩放效果附近其他item的缩放和颜色
    int index = 0;
    for (CusTomSegBtn *titleView in _titleViews) {
        if (index != currentIndex) {
//            titleView.selected = NO;
            [titleView setTitleColor:self.cusProper.normalTitleColor forState:UIControlStateNormal];
        } else {
//            titleView.selected = YES;
            [titleView setTitleColor:self.cusProper.SelectTitleColor forState:UIControlStateNormal];
        }
        index++;
    }
    if (self.scroBottom.contentSize.width != self.scroBottom.bounds.size.width + contentSizeXOff){// 需要滚动
        CusTomSegBtn *currentTitleView = (CusTomSegBtn *)_titleViews[currentIndex];
        CGFloat offSetx = currentTitleView.center.x - _currentWidth * 0.5;
        if (offSetx < 0) {
            offSetx = 0;
        }
        CGFloat maxOffSetX = self.scroBottom.contentSize.width - (_currentWidth);
        if (maxOffSetX < 0) {
            maxOffSetX = 0;
        }
        if (offSetx > maxOffSetX) {
            offSetx = maxOffSetX;
        }
        [self.scroBottom setContentOffset:CGPointMake(offSetx, 0.0) animated:YES];
    }
}

- (void)setUpTitleViewsPosition {
    CGFloat titleX = 0.0;
    CGFloat titleY = 0.0;
    CGFloat titleW = 0.0;
    CGFloat titleH = self.height - 2;
    if (!self.cusProper.isScrollTitle) {// 标题不能滚动, 平分宽度
        titleW = self.scroBottom.bounds.size.width / self.titleViews.count;
        NSInteger index = 0;
        for (CusTomSegBtn *titleView in self.titleViews) {
            titleX = index * titleW;
            titleView.frame = CGRectMake(titleX, titleY, titleW, titleH);
            index++;
//            titleView.backgroundColor = kRandomColor;
        }
    } else {
        NSInteger index = 0;
        float lastLableMaxX = self.cusProper.titleMargin;
        float addedMargin = 0.0f;
        if (self.cusProper.isAutoAdjustTitlesWidth) {
            float allTitlesWidth = self.cusProper.titleMargin;
            for (int i = 0; i<self.titleWidths.count; i++) {
                allTitlesWidth = allTitlesWidth + [self.titleWidths[i] floatValue] + self.cusProper.titleMargin;
            }
            addedMargin = allTitlesWidth < self.scroBottom.bounds.size.width ? (self.scroBottom.bounds.size.width - allTitlesWidth)/self.titleWidths.count : 0 ;
        }
        for (CusTomSegBtn *titleView in self.titleViews) {
            titleW = [self.titleWidths[index] floatValue];
            titleX = lastLableMaxX + addedMargin/2;
            lastLableMaxX += (titleW + addedMargin + self.cusProper.titleMargin);
            titleView.frame = CGRectMake(titleX, titleY, titleW, titleH);
            index++;
        }
    }
    CusTomSegBtn *currentTitleView = (CusTomSegBtn *)self.titleViews[_currentIndex];
     if (currentTitleView) {
        // 设置初始状态文字的颜色
         [currentTitleView setTitleColor:self.cusProper.normalTitleColor forState:UIControlStateNormal];
    }
}

- (void)setSelectedIndex:(NSInteger)index animated:(BOOL)animated {
    NSAssert(index >= 0 && index < self.titles.count, @"设置的下标不合法!!");
    if (index < 0 || index >= self.titles.count) {
        return;
    }
    _currentIndex = index;
    [self adjustUIWhenBtnOnClickWithAnimate:animated taped:NO]; 
}
/**设置index的选中**/
-(void)setSelectIndex:(NSInteger)selectIndex{
    _selectIndex = selectIndex;
    CusTomSegBtn * sBtn = self.titleViews[selectIndex];
    sBtn.selected = YES;
    for (CusTomSegBtn * btn in self.titleViews) {
        if (sBtn.tag != btn.tag) {
            btn.selected = NO;
        }
    }
}

- (UIScrollView *)scroBottom {
    if (!_scroBottom) {
        _scroBottom = [[UIScrollView alloc] init];
        _scroBottom.showsHorizontalScrollIndicator = NO;
        _scroBottom.scrollsToTop = NO;
        _scroBottom.bounces = NO;
        _scroBottom.pagingEnabled = NO;
        _scroBottom.delegate = self;
        _scroBottom.frame = CGRectMake(0.0, 0.0, self.width, self.height);
    }
    return _scroBottom;
}
- (UIView *)scrollLine {
    if (!_scrollLine) {
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = [UIColor blueColor];
        _scrollLine = lineView;
    }
    return _scrollLine;
}

@end

@implementation CusTomSegBtn
- (void)setSelected:(BOOL)selected{
    if (!selected) {
        self.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:self.proper.normalFont];
    }else{
        self.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:22];
    }
}
@end
