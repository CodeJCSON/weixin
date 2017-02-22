//
//  ViewController.m
//  微信小眼睛
//
//  Created by LJP on 17/1/4.
//  Copyright © 2017年 Mumu. All rights reserved.
//

#import "ViewController.h"
#import "MUWeConst.h"
#import "EyeView.h"

static const CGFloat contentV_Y = -100;
static const CGFloat contenV_H = 100;

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    CGFloat _originY;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) EyeView *eyeView;

@end



@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    [self.view addSubview:self.tableView];
    
    
    EyeView *eyeV = [[EyeView alloc] initWithFrame:CGRectMake(SCREENWIDTH * 0.25, contentV_Y, SCREENWIDTH * 0.5, contenV_H)];
    [self.view addSubview:eyeV];
    self.eyeView = eyeV;
    _originY = eyeV.frame.origin.y;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark - getter && setter

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor blackColor];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:UITableViewCellID];
    }
    return _tableView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    CGRect frame = self.eyeView.frame;
    frame.origin.y = _originY - offsetY;
    self.eyeView.frame = frame;
    
    [self.eyeView animationWith:offsetY];
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:UITableViewCellID];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.contentView.backgroundColor = [UIColor blackColor];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


@end
