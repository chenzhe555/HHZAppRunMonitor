//
//  UIScreen+Category.h
//  iOS-HHZUniversal
//
//  Created by 陈哲#376811578@qq.com on 16/11/24.
//  Copyright © 2016年 陈哲是个好孩子. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScreen (HHZUtils_UIScreen)
/**
 *  获取屏幕比例
 *
 *  @return 
 */
+(CGFloat)hhz_screenScale;

/**
 *  获取屏幕Rect
 *
 *  @return Rect
 */
-(CGRect)hhz_screenBoundsWithOrientation:(UIInterfaceOrientation)orientation;
@end

NS_ASSUME_NONNULL_END
