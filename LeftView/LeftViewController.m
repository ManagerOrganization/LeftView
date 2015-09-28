//
//  LeftViewController.m
//  LeftView
//
//  Created by qianfeng on 15/9/28.
//  Copyright (c) 2015年 jydong. All rights reserved.
//

#import "LeftViewController.h"
#import "UIView+Addition.h"
#import "MyHelper.h"

static LeftViewController *lvc = nil;

@interface LeftViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    UIView *_backView;
}
@end

@implementation LeftViewController

+ (LeftViewController *)shareSingleton {
    @synchronized (self) {
        if (!lvc) {
            lvc = [[LeftViewController alloc] init];
        }
    }
    return lvc;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createView];
}
- (void)createView {
    _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width,self.view.frame.size.height - 64)];
    _backView.backgroundColor = RGBA(0, 0, 0, 0.5f);
    [self.view addSubview:_backView];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.backgroundColor = RGB(230, 230, 230);
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //先不添加到self.view上
}

//显示
- (void)showView {
    
    //取出画板
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    //把当前控制器的view贴在画板上
    [window addSubview:self.view];
    //将tableView准备好，并且贴在屏幕外边
    [_tableView setFrame:CGRectMake(0 - ScreenWidth, 64, ScreenWidth - LeftDistance * 5, ScreenHeight - 64)];
    [self.view addSubview:_tableView];
    //移动入屏幕
    [UIView animateWithDuration:0.5 animations:^{
        [_tableView setXOffset:0];
    }];
}

//隐藏
- (void)hideView {
    //动画还原tableView移出屏幕
    [UIView animateWithDuration:0.5 animations:^{
        [_tableView setXOffset:0 - ScreenWidth];
    } completion:^(BOOL finished) {
        //动画结束后移除tableView和self.view
        [_tableView removeFromSuperview];
        [UIView animateWithDuration:0.1 animations:^{
            _backView.backgroundColor = RGBA(0, 0, 0, 0);
        } completion:^(BOOL finished) {
            [self.view removeFromSuperview];
            _backView.backgroundColor = RGBA(0, 0, 0, 0.5);
        }];
    }];
}
//隐藏
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self hideView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"CategoryIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.contentView.backgroundColor = RGB(230, 230, 230);
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    /*
     可以写点击之后回调的参数 或者 需要实现的功能
     */
    
    [self hideView];//点击支护隐藏
}

@end
