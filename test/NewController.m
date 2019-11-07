//
//  NewController.m
//  test
//
//  Created by john on 2019/11/6.
//  Copyright © 2019 qt. All rights reserved.
//

#import "NewController.h"
#import "BaseTab.h"
@interface NewController ()<UITableViewDataSource,UITableViewDelegate>
{
    BOOL canMove;
}
@property (weak, nonatomic) IBOutlet BaseTab *tab_B;
@property (nonatomic,assign)CGFloat YLast;
@end

@implementation NewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(canMove) name:@"contentCanMove" object:nil];
    canMove = NO;
}

- (void)canMove{
    canMove = YES;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 100;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld个",self.indexCurrent];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (!canMove) {
        [scrollView setContentOffset:CGPointMake(0, 0)];
    }
    CGFloat offsetY = scrollView.contentOffset.y;
    if (fabs(offsetY-self.YLast)>50) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"DRAGMOVE" object:@{@"flag":@"NO"}];
    }
    if (offsetY <= 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"OtherCanMove" object:nil];
        canMove = self.indexCurrent!=0?YES:NO;
    }
    self.YLast = offsetY;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"DRAGMOVE" object:@{@"flag":@"YES"}];
}
@end
