//
//  LQHomeViewController.m
//  Spice
//
//  Created by lanou3g on 16/4/20.
//  Copyright © 2016年 spice. All rights reserved.
//

#import "LQHomeViewController.h"
#import "LQHomeListModel.h"
#import <UIImageView+WebCache.h>
#import "LQNetWoringRequestManager.h"
#import "LQHomeListTableViewCell.h"
@interface LQHomeViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *MainViewController;


//主题列表数据源

@property(nonatomic,strong)NSMutableArray *AllListArray;


@end

@implementation LQHomeViewController

- (NSMutableArray *)AllListArray{
    if (_AllListArray == nil) {
        _AllListArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _AllListArray;
}

#pragma mark - 数据请求
- (void)readData{
    
    [LQNetWoringRequestManager requestWithType:GET urlString:@"http://toutiao.com/ma/?media_id=5234320301&count=10&max_behot_time=0&callback=jsonp1&csrfmiddlewaretoken=undefined&_=1460604968522" parmas:nil success:^(NSData *data) {
        
        if (data == nil) {
            return ;
        }
        
        
        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        //字符串替换
        NSString *aString = [string stringByReplacingOccurrencesOfString:@"jsonp1(" withString:@""];
        //截取字符串
        NSString *bString = [aString substringToIndex:aString.length - 1];
        
        NSData *urlData = [bString dataUsingEncoding:NSUTF8StringEncoding];
        
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:urlData options:(NSJSONReadingAllowFragments) error:nil];
        
        //            获取主题列表数据
        NSArray *allListArr = dataDic[@"data"];
        for (NSDictionary *dic in allListArr) {
            LQHomeListModel *model = [[LQHomeListModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.AllListArray addObject:model];
            NSLog(@"%@",model);
            NSLog(@"allListArr = %@",self.AllListArray);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [_MainViewController reloadData];
            });
        }
        
        
    } error:^(NSError *error) {
        
    }];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = LQColor(100, 100, 100) ;
    
    //行高
    self.MainViewController.rowHeight = 280;
    self.MainViewController.delegate = self;
    self.MainViewController.dataSource = self;
    [self.MainViewController registerNib:[UINib nibWithNibName:@"LQHomeListTableViewCell" bundle:nil] forCellReuseIdentifier:@"homeCell"];
    
    [self.view addSubview:self.MainViewController];
    [self readData];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.AllListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LQHomeListModel *model = [_AllListArray objectAtIndex:indexPath.row];
    
    LQHomeListTableViewCell *cell = [LQHomeListTableViewCell cellWithTableView:tableView];
    
    cell.model = model;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
