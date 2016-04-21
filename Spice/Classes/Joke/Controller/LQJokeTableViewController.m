//
//  LQJokeTableViewController.m
//  Spice
//
//  Created by lanou3g on 16/4/19.
//  Copyright © 2016年 spice. All rights reserved.
//

#import "LQJokeTableViewController.h"
#import "LQtJokeTableViewCell.h"
#import "LQModel.h"
#import "AppDelegate.h"
#import "MJRefresh.h"
#import "LQImageCoViewController.h"

#define URL(num) @"http://duanzi.duowan.com/index.php?r=duatopicList&page=1&pageSize=30&sort=2"
@interface LQJokeTableViewController ()
{
    BOOL isHave ;
}
@property(nonatomic,strong)NSMutableDictionary *dic;
@property(nonatomic,strong)NSMutableArray *sarry;
@property(nonatomic,strong)UIImageView *bigimage;
@property(nonatomic,assign)int num;
@property(nonatomic,assign)CGFloat currentScale;
@property(nonatomic,strong)UIWindow *window;
@property(nonatomic,strong)NSString *string;
//@property(nonatomic,strong)UIWindow window1;
@end

@implementation LQJokeTableViewController

-(NSMutableArray *)sarry{
    if (_sarry == nil) {
        _sarry = [NSMutableArray array];
    }
    return _sarry;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    isHave= YES;
    self.num = 2;
    self.tableView.rowHeight = 400;
    self.dic =[[NSMutableDictionary dictionary]mutableCopy];
    [self.tableView  addHeaderWithTarget:self action:@selector(AFHTTP)];
    [self.tableView addFooterWithTarget:self action:@selector(AFHTTPLOAD)];
    [self.tableView headerBeginRefreshing];

}
-(void)AFHTTPLOAD{
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",nil];//设置相应内容类型
    [manager GET:[NSString stringWithFormat:@"http://duanzi.duowan.com/index.php?r=duanzi/topicList&page=%d&pageSize=30&sort=2",self.num] parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableDictionary *dic2 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
            self.num++;
        NSArray *arry = [[dic2 objectForKey:@"result"]objectForKey:@"list"];
        for (NSDictionary *dic in arry) {
            LQModel *modellist =[[LQModel alloc]init];
            [modellist setValuesForKeysWithDictionary:dic];
            [self.sarry addObject:modellist];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            
        });
//        [self.tableView  headerEndRefreshing];
        [self.tableView  footerEndRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
-(void)AFHTTP{
    [self requestData];
}
-(void)requestData{
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",nil];//设置相应内容类型
    [manager GET:@"http://duanzi.duowan.com/index.php?r=duanzi/topicList&page=1&pageSize=30&sort=2" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSMutableDictionary *dic2 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        NSArray *arry = [[dic2 objectForKey:@"result"]objectForKey:@"list"];
        for (NSDictionary *dic in arry) {
            LQModel *modellist =[[LQModel alloc]init];
            [modellist setValuesForKeysWithDictionary:dic];
            [self.sarry addObject:modellist];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            
        });
        [self.tableView  headerEndRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    NSLog(@"%d",self.sarry.count);
    return self.sarry.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LQtJokeTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"mycell"];
    if (cell == nil) {
        cell =[[[NSBundle mainBundle]loadNibNamed:@"LQtJokeTableViewCell" owner:nil options:nil]lastObject];
    }
    
    LQModel *model = self.sarry[indexPath.row];
    cell.userName.text = model.nickname;
    [cell.headImage sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    cell.MainLabel.text = model.content;
    [cell.MainImage sd_setImageWithURL:[NSURL URLWithString:[[model.imagelist objectAtIndex:0] objectForKey:@"large"]]];
    
//    self.string  = [[model.imagelist objectAtIndex:0]objectForKey:@"large"];
    cell.MainImage.userInteractionEnabled =YES;
//    if (isHave == YES) {
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickimage:)];
        [cell.MainImage addGestureRecognizer:tap];
//        isHave = NO;
//    }
//    [UIApplication sharedApplication]keyWindow
    
    return cell;
}
-(void)clickimage:(UIGestureRecognizer *)ges{
//    UIView *subview =[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.window.frame.size.width, self.window.frame.size.height)];
//    UIWindow *window =[UIApplication sharedApplication].keyWindow;
//    if (!window) {
//        self.window1 = [UIApplication sharedApplication].keyWindow;
//    }
    UIImageView *view = (UIImageView *)ges.view;
//    view.frame = CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height-120);
    UITableViewCell *cell = (UITableViewCell *)[[view superview] superview];
    NSIndexPath *index = [self.tableView indexPathForCell:cell];
    NSString *str = [[[((LQModel *)[self.sarry objectAtIndex:index.row]) imagelist] objectAtIndex:0] objectForKey:@"large"];
//    [self.window1 addSubview:view];
//    UIGestureRecognizer *gges =[[UIGestureRecognizer alloc]initWithTarget:self action:@selector(fanhui)];
//    [view addGestureRecognizer:gges];
//    LQModel *model = self.sarry[indextpath.row];
////    self.string  = [[model.imagelist objectAtIndex:0]objectForKey:@"large"];
    LQImageCoViewController *lqimagec =[[LQImageCoViewController alloc]init];
    lqimagec.str = str;
    [self presentViewController:lqimagec animated:nil completion:^{
 
        
        
    }];

}
-(void)fanhui{
    
}

-(void)backToCell{
    NSLog(@"11111");

    
}





/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    LQModel *model = self.sarry[indexPath.row];
//     self.string  = [[model.imagelist objectAtIndex:0]objectForKey:@"large"];
}


// Override to support editing the table view.
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        // Delete the row from the data source
////        LQModel *model = self.sarry[indexPath.row];
////        self.string  = [[model.imagelist objectAtIndex:0]objectForKey:@"large"];
//
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }   
//}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
