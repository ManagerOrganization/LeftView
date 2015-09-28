//
//  ViewController.m
//  LeftView
//
//  Created by qianfeng on 15/9/28.
//  Copyright (c) 2015年 jydong. All rights reserved.
//

#import "ViewController.h"
#import "LeftViewController.h"

@interface ViewController ()
{
    LeftViewController *_lvc;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createView];
}

- (void)createView {
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 5, 40, 30)];
    [button setTitle:@"弹出" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(toShow) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftbutton = [[UIBarButtonItem alloc]initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftbutton;
    
    _lvc = [LeftViewController shareSingleton];
    
}

- (void)toShow {
    [_lvc showView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
