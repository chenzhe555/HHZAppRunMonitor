//
//  UISearchBar+HHZCategory.m
//  HHZCategory
//
//  Created by 仁和Mac on 2017/9/7.
//  Copyright © 2017年 陈哲是个好孩子. All rights reserved.
//

#import "UISearchBar+HHZCategory.h"

@implementation UISearchBar (HHZCategory)

-(void)hhz_clearAroundDottedLine
{
    //方法1
//    [self setBackgroundImage:[UIImage new]];
    
    //方法2
    for (UIView *subview in [[self.subviews firstObject] subviews])
    {
        if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")])
        {
            [subview removeFromSuperview];
        }
    }
}

@end
