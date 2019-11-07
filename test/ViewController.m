//
//  ViewController.m
//  test
//
//  Created by john on 2019/11/6.
//  Copyright © 2019 qt. All rights reserved.
//

#import "ViewController.h"
#import "CustomProperty.h"
#import "CustomPageView.h"
#import "NewController.h"
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight  [UIScreen mainScreen].bounds.size.height
#define kRandomColor    [UIColor colorWithHue: (arc4random() % 256 / 256.0) saturation:((arc4random()% 128 / 256.0 ) + 0.5) brightness:(( arc4random() % 128 / 256.0 ) + 0.5) alpha:1]        //随机色生成

@interface ViewController ()<UIScrollViewDelegate>
{
    BOOL canMove;
}
@property (nonatomic,strong)NSArray * arr_Title;
@property (nonatomic,strong)UIScrollView * scrollBottom;
@property (nonatomic,strong)CustomPageView * page;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(canMove) name:@"OtherCanMove" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dragMove:) name:@"DRAGMOVE" object:nil];
    canMove = YES;
    [self setSegMent];
}

-(void)dragMove:(NSNotification *)noti{
    if ([noti.object[@"flag"] isEqualToString:@"NO"]) {
        self.page.mainScro.scrollEnabled = NO;
    }else{
        self.page.mainScro.scrollEnabled = YES;
    }
}

- (void)canMove{
    canMove = YES;
}

-(void)setSegMent{
    UIScrollView * scrollBottom = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64)];
    scrollBottom.backgroundColor = [UIColor cyanColor];
    scrollBottom.showsVerticalScrollIndicator = NO;
    scrollBottom.showsHorizontalScrollIndicator = NO;
    scrollBottom.delegate = self;
    scrollBottom.pagingEnabled = YES;
    [self.view addSubview:scrollBottom];
    self.scrollBottom = scrollBottom;
    self.arr_Title = @[@"团购",@"精装",@"品牌",@"清仓",@"家具",@"灯具",@"地毯",@"窗帘",@"布艺",@"配饰"];
    CustomProperty * pro = [[CustomProperty alloc] init];
    CustomPageView * page = [[CustomPageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-50) property:pro titles:self.arr_Title controlls:[self controlls] con:self];
    [scrollBottom addSubview:page];
    self.page = page;
    __block ViewController * weakSelf  = self;
    page.block = ^(NSInteger index) {
        weakSelf.scrollBottom.scrollEnabled =index==0?YES:NO;
    };
    scrollBottom.contentSize = CGSizeMake(kScreenWidth, 50+kScreenHeight);
}

-(NSArray *)controlls{
    NSMutableArray * arrC = [NSMutableArray array];
    for (int i=0; i<self.arr_Title.count; i++) {
        NewController * new = [NewController new];
        new.indexCurrent = i;
        new.view.backgroundColor = kRandomColor;
        [arrC addObject:new];
    }
    return [arrC copy];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    NSLog(@"scrollView的偏移量：===%f", contentOffsetY);
    CGFloat maxOffsetY = 50;///偏移量瞎写的
    if (contentOffsetY > maxOffsetY && canMove) {
        [scrollView setContentOffset:CGPointMake(0, maxOffsetY)];
         [[NSNotificationCenter defaultCenter] postNotificationName:@"contentCanMove" object:nil];
        canMove = NO;
    }
    if (canMove == NO) {
        [scrollView setContentOffset:CGPointMake(0, maxOffsetY)];
    }
}


@end
