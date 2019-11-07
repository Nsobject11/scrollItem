//
//  CustomPageView.m
//  ZhiDi
//
//  Created by john on 2019/7/18.
//  Copyright © 2019 qt. All rights reserved.
//

#import "CustomPageView.h"
#import "CustomSegment.h"
#import "UIView+Extension.h"
@interface CustomPageView()<CustomDelegate,UIScrollViewDelegate>
@property (nonatomic,copy)NSArray * titles;
@property (nonatomic,copy)NSArray * controllers;
@property (nonatomic,strong)CustomSegment * cusSeg;
@property (nonatomic,strong)CustomProperty * cusProperty;
@property (nonatomic,strong)UIViewController * con;
@property (nonatomic,strong)UIButton * brandBtn;
@end

@implementation CustomPageView
- (instancetype)initWithFrame:(CGRect)frame property:(CustomProperty *)property titles:(NSArray *)titles controlls:(NSArray *)controllS con:(UIViewController *)con
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titles = titles;
         self.controllers = controllS;
        self.cusProperty = property;
        self.con = con;
        [self setUI];
    }
    return self;
}
-(void)setUI{
    [self addSubview:self.cusSeg];
    [self addSubview:self.mainScro];
    [self addChildViews];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.cusSeg.frame = CGRectMake(self.cusProperty.left_margin, 0, self.width-(self.cusProperty.indexAddWidth * self.cusProperty.left_margin), 50);
    self.mainScro.frame = CGRectMake(0, self.cusSeg.height, self.width, self.height-self.cusSeg.height);
}
#pragma mark -----------------CustomDelegate------------
-(void)setUpTitleView:(UIButton *)btn index:(NSInteger)indexS lastIndex:(NSInteger)lastIndex{
    if (self.block) {
        self.block(indexS);
    }
    
    [self.mainScro setContentOffset:CGPointMake(self.width*indexS, 0) animated:NO];
}

 

#pragma mark -----------------UIScrollViewDelegate--------
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self.cusSeg setSelectedIndex:index animated:YES];
    if (self.block) {
        self.block(index);
    }
 }

-(void)setSelectIndex:(NSInteger)SelectIndex{
    _SelectIndex = SelectIndex;
    [self.cusSeg setSelectedIndex:SelectIndex animated:YES];
    [self.mainScro setContentOffset:CGPointMake(self.width*SelectIndex, 0) animated:NO];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    [self.cusSeg changeIn dicatorFrameByStretch:scrollView.contentOffset.x];
}
///**
// *  添加子控制器
// */
- (void)addChildViews
{
    for (int i=0; i<self.controllers.count; i++) {
        if ([self.controllers[i] isKindOfClass:[UIViewController  class]]) {
            UIViewController * controller = (UIViewController *)self.controllers[i];
            controller.view.frame = CGRectMake(i*self.width, self.mainScro.y, self.width, self.height-self.cusSeg.height);
            [self.con addChildViewController:controller];
            [self.mainScro addSubview:controller.view];
        }else if([self.controllers[i] isKindOfClass:[UIView class]]){
            UIView * view = (UIView *)self.controllers[i];
            view.frame = CGRectMake(i*self.width, self.mainScro.y, self.width, self.height-self.cusSeg.height);
            [self.mainScro addSubview:view];
        }
    }
    self.mainScro.contentSize = CGSizeMake(self.controllers.count*self.width, 0);
}
-(UIScrollView *)mainScro{
    if (!_mainScro) {
        // 不要自动调整inset
        _mainScro = [[UIScrollView alloc] initWithFrame: CGRectZero]; 
        _mainScro.pagingEnabled = YES;
        _mainScro.delegate = self;
        _mainScro.bounces = NO;
        _mainScro.contentSize = CGSizeMake(self.controllers.count*self.width, 0);
         _mainScro.contentOffset = CGPointMake(0, 0);
         _mainScro.showsHorizontalScrollIndicator = NO;
        _mainScro.scrollEnabled = self.cusProperty.ScrollItem;
        [self.mainScro setContentOffset:CGPointMake(self.width*self.cusProperty.selectIndex, 0) animated:NO];
    }
    return _mainScro;
}
-(CustomSegment *)cusSeg{
    if (!_cusSeg) {
        _cusSeg = [[CustomSegment alloc] initWithFrame:CGRectMake(self.cusProperty.left_margin, 0, self.width-2*self.cusProperty.left_margin, 50) titles:self.titles property:self.cusProperty];
        _cusSeg.CDelegate = self;
        [_cusSeg setSelectedIndex:self.cusProperty.selectIndex animated:YES];
    }
    return _cusSeg;
}
- (void)setRightChooseItem:(BOOL)rightChooseItem {
    _rightChooseItem = rightChooseItem;
    if (rightChooseItem) {
        [self.cusSeg updateLastBtnUI];
    }
}
@end
