//
//  ViewController.m
//  HHZAppRunMonitor
//
//  Created by 仁和Mac on 2017/8/9.
//  Copyright © 2017年 陈哲是个好孩子. All rights reserved.
//

#import "ViewController.h"
#import <HHZCategory/NSObject+HHZCategory.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor grayColor];
    
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    if (!window)
    {
        window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    }
    
    NSArray *children = [[[[UIApplication sharedApplication] valueForKeyPath:@"statusBar"]valueForKeyPath:@"foregroundView"]subviews];
    for (int i = 0; i < [children count]; i ++) {
        UIView *  vv = children[i];
        
        NSLog(@"输出:%@",vv);
        
    }
}

-(void)findSubViews:(UIView *)view
{
    for (UIView * vie in view.subviews)
    {
        if (vie.subviews.count > 0)
        {
            [self findSubViews:vie];
        }
        else
        {
            NSLog(@"找到一个:\n%@\n\n",vie);
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
