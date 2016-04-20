//
//  LQVedioViewController.m
//  Spice
//
//  Created by lanou3g on 16/4/14.
//  Copyright © 2016年 spice. All rights reserved.
//

#import "LQVedioViewController.h"
#import "LQVedioCell.h"
#import "LQVedion.h"
#import "MBProgressHUD+MJ.h"
#import "MJRefresh.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
@interface LQVedioViewController () <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong)UITableView *vedioTbaleView;

//存放数据的数组
@property(nonatomic, strong)NSMutableArray *dataArray;


@end

@implementation LQVedioViewController

#pragma mark - 懒加载数据数组
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        
    }
    return _dataArray;
}

- (UITableView *)vedioTbaleView{
    if (!_vedioTbaleView) {
        _vedioTbaleView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    }
    return _vedioTbaleView;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = LQColor(150, 150, 150);
    
    
    self.vedioTbaleView.delegate = self;
    self.vedioTbaleView.dataSource = self;
    
    [self.view addSubview:self.vedioTbaleView];
    
    self.vedioTbaleView.rowHeight = 300;
    
    

    
    [self.vedioTbaleView registerNib:[UINib nibWithNibName:@"LQVedioCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    //下拉刷新
    [self.vedioTbaleView addHeaderWithTarget:self action:@selector(loadMoreData)];
    //上拉加载更多
    [self.vedioTbaleView addFooterWithTarget:self action:@selector(loadMoreData)];
    
    [self.vedioTbaleView headerBeginRefreshing];
    
}

- (void)loadMoreData{
    
    //请求数据
    [self requestData];
}



- (void)requestData{
    
    [LQNetWoringRequestManager requestWithType:GET urlString:VEDIOLIST_URL parmas:nil success:^(NSData *data) {
//        NSLog(@"%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *vedios = [dict objectForKey:@"videos"];
        
            for (NSDictionary *dic in vedios) {
                LQVedion *video = [[LQVedion alloc] init];
                [video setValuesForKeysWithDictionary:dic];
                [self.dataArray addObject:video];

            }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.vedioTbaleView reloadData];
        });
        
        //结束刷新
        [self.vedioTbaleView headerEndRefreshing];
        [self.vedioTbaleView footerEndRefreshing];
    
        
    } error:^(NSError *error) {
        [MBProgressHUD showMessage:@"网络繁忙,请稍后再试!" toView:self.view];
    }];

    
}



#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    LQVedion *video = self.dataArray[indexPath.row];
    
    LQVedioCell *cell = [LQVedioCell cellWithTableView:tableView];
    
    cell.vedio = video;
   
    return cell;
}

//给出预估高度
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 300;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    id model = self.dataArray[indexPath.row];
//    return [self.vedioTbaleView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[LQVedioCell class] contentViewWidth:[self cellContentViewWith]];
//}

//
//- (CGFloat)cellContentViewWith
//{
//    CGFloat width = [UIScreen mainScreen].bounds.size.width;
//    
//    // 适配ios7
//    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
//        width = [UIScreen mainScreen].bounds.size.height;
//    }
//    return width;
//}







@end
