//
//  LQImageCoViewController.m
//  Spice
//
//  Created by lanou3g on 16/4/20.
//  Copyright © 2016年 spice. All rights reserved.
//

#import "LQImageCoViewController.h"
#import "LQModel.h"
#import "LQJokeTableViewController.h"
@interface LQImageCoViewController ()

@property(nonatomic,assign)NSInteger currentScale;
@end

@implementation LQImageCoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *image = [[UIImageView alloc ]init];
    [image sd_setImageWithURL:[NSURL URLWithString:self.str]];
    image.frame = CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height-120);
    [self.view addSubview:image];
    self.view.backgroundColor =[UIColor blackColor];
    UIPinchGestureRecognizer *pinch =[[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(scaleimage:)];
    [image addGestureRecognizer:pinch];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    LQJokeTableViewController *joke =[[LQJokeTableViewController alloc]init];
//    self.str = [NSString stringWithString:joke.string];
   
    
    [self dismissModalViewControllerAnimated:YES];
}
-(void)scaleimage:(id)sender{


        [self.view bringSubviewToFront:[(UIPinchGestureRecognizer*)sender view]];

        //当手指离开屏幕时,将lastscale设置为1.0

        if([(UIPinchGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {

            self.currentScale = 1.0;

            return;
        }
        CGFloat scale = 1.0 - (self.currentScale - [(UIPinchGestureRecognizer*)sender scale]);

        CGAffineTransform currentTransform = [(UIPinchGestureRecognizer*)sender view].transform;

        CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, scale, scale);

        [[(UIPinchGestureRecognizer*)sender view] setTransform:newTransform];

        self.currentScale = [(UIPinchGestureRecognizer*)sender scale];

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
