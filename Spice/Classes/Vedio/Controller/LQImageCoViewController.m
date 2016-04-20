//
//  LQImageCoViewController.m
//  Spice
//
//  Created by lanou3g on 16/4/20.
//  Copyright © 2016年 spice. All rights reserved.
//

#import "LQImageCoViewController.h"
#import "LQModel.h"
@interface LQImageCoViewController ()

@end

@implementation LQImageCoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissModalViewControllerAnimated:YES];
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
