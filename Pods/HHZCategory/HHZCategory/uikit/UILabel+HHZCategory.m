//
//  UILabel+HHZCategory.m
//  iOS-HHZUniversal
//
//  Created by 陈哲#376811578@qq.com on 16/11/19.
//  Copyright © 2016年 陈哲是个好孩子. All rights reserved.
//

#import "UILabel+HHZCategory.h"

@implementation UILabel (HHZ_AddTarget)
-(void)hhz_addTarget:(id)labelTarget andSelector:(SEL)selector
{
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:labelTarget action:selector];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tap];
}
@end
