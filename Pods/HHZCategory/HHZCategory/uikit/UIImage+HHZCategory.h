//
//  UIImage+HHZCategory.h
//  iOS-HHZUniversal
//
//  Created by 陈哲#376811578@qq.com on 16/11/19.
//  Copyright © 2016年 陈哲是个好孩子. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UIImage (HHZ_ImageEffects)

NS_ASSUME_NONNULL_BEGIN

#pragma mark ImageEffects
// 模糊效果(渲染很耗时间,建议在子线程中渲染)
- (UIImage *)blurImage;
- (UIImage *)blurImageWithMask:(UIImage *)maskImage;
- (UIImage *)blurImageWithRadius:(CGFloat)radius;
- (UIImage *)blurImageAtFrame:(CGRect)frame;

// 灰度效果
- (UIImage * _Nullable)grayScale;

// 固定宽度与固定高度
- (UIImage *)scaleWithFixedWidth:(CGFloat)width;
- (UIImage *)scaleWithFixedHeight:(CGFloat)height;

// 平均的颜色
- (UIColor *)averageColor;

// 裁剪图片的一部分
- (UIImage *)croppedImageAtFrame:(CGRect)frame;

// 将自身填充到指定的size
- (UIImage *)fillClipSize:(CGSize)size;

@end


#pragma mark 获取bundle里面图片信息
@interface UIImage (HHZ_Bundle)
/**
 *  获取当前App的Icon图片Image对象
 *
 *  @return
 */
+(UIImage *)hhz_getAppIcon;
@end


#pragma mark 对图片进行压缩大小，拉伸，离屏渲染等等操作
@interface UIImage (HHZ_Transform)

/**
 *  压缩当前图片Image成指定大小Image
 *
 *  @param size 指定尺寸
 */
-(UIImage *)hhz_compressToSize:(CGSize)size;

/**
 *  根据传入的图片最大宽高参数，计算出图片容器的Size
 *
 *  @param image 传入的图片
 *
 *  @return
 */
-(CGSize)hhz_getContainerSizeWithLimitWidth:(CGFloat)limitWidth limitHeight:(CGFloat)limitHeight;

/**
 *  拉伸Image矩形范围内视图(仅拉伸区域内，类型QQ聊天框)
 *
 *  @param edgeInset 指定矩形区域
 *
 *  @return
 */
-(UIImage *)hhz_resizeImageWithEdge:(UIEdgeInsets)edgeInset;


-(UIImage*)hhz_imageRotatedByDegrees:(CGFloat)degrees;

@end

@interface UIImage (HHZ_Watermark)
/**
 *  添加水印文字到图片上(默认字体大小40,颜色黑色)
 *
 *  @param text  水印文字
 *  @param rect  坐标地址
 *
 *  @return 
 */
-(nullable UIImage *)hhz_addWatermarkText:(NSString *)text rect:(CGRect)rect;

/**
 *  添加水印文字到图片上
 *
 *  @param text      水印文字
 *  @param rect      坐标地址
 *  @param attribute 字体属性
 *
 *  @return 
 */
-(nullable UIImage *)hhz_addWatermarkText:(NSString *)text rect:(CGRect)rect attribute:(nullable NSDictionary *)attribute;

/**
 *  添加水印图片
 *
 *  @param image  水印图片
 *  @param rect   水印图片Rect
 *  @param bgRect 底部画布的Rect
 *
 *  @return
 */
-(nullable UIImage *)hhz_addWatermarkImage:(UIImage *)image rect:(CGRect)rect BGRect:(CGRect)bgRect;

/**
 *  合并两个图片
 *
 *  @param imageOne 图片1
 *  @param imageTwo 图片2
 *  @param oneRect  图片1Rect
 *  @param twoRect  图片2Rect
 *  @param bgRect   底部画布的Rect
 *
 *  @return 
 */
+(nullable UIImage *)hhz_mergeImage:(UIImage *)imageOne BImage:(UIImage *)imageTwo oneRect:(CGRect)oneRect twoRect:(CGRect)twoRect BGRect:(CGRect)bgRect;
@end


@interface UIImage (HHZ_Circle)

/**
 *  将图片转换为圆形图片
 *
 */
-(UIImage *)hhz_drawCircleImage;

/**
 *  获取纯色的Image对象
 *
 *  @param rect Image尺寸
 *  @param color Image颜色
 *
 */
+(UIImage *)hhz_gainPureColorImageRect:(CGRect)rect color:(UIColor *)color;

@end
NS_ASSUME_NONNULL_END
