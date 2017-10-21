//
//  UIImageView+HHZCategory.m
//  iOS-HHZUniversal
//
//  Created by 陈哲#376811578@qq.com on 16/11/19.
//  Copyright © 2016年 陈哲是个好孩子. All rights reserved.
//

#import "UIImageView+HHZCategory.h"

@implementation UIImageView (HHZ_AddTarget)
-(void)hhz_addTarget:(id)target andSelector:(SEL)selector
{
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:selector];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tap];
}
@end
