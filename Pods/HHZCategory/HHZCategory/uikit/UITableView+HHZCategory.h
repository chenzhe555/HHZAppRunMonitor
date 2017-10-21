//
//  UITableView+HHZCategory.h
//  iOS-HHZUniversal
//
//  Created by 陈哲#376811578@qq.com on 16/11/19.
//  Copyright © 2016年 陈哲是个好孩子. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (HHZUtils_UITableView)
/**
 *  绑定HHZTableView的委托对象，并且初始化一些数据
 *
 *  @param target 委托对象目标
 */
-(void)hhz_bindDelegateWithTarget:(id)target;

/**
 *  更新组件
 *
 *  @param block 要更新的操作
 */
-(void)hhz_updateComponentBlock:(void (^)(UITableView * tableView))block;

#pragma mark SectionIndexView
/**
 *  设置SectionIndex视图背景透明
 *
 */
-(void)hhz_clearSectionIndexViewBGColor;

/**
 *  设置SectionIndex视图背景透明并且设置文本颜色
 *
 */
-(void)hhz_clearSectionIndexViewBGColorAndChangeTextColor:(UIColor *)textColor;



/*************************************   以下为便利方法   *************************************/
-(void)scrollToRow_hhz:(NSUInteger)row inSection:(NSUInteger)section atScrollPosition:(UITableViewScrollPosition)scrollPosition animated:(BOOL)animated;
-(void)insertRow_hhz:(NSUInteger)row inSection:(NSUInteger)section withRowAnimation:(UITableViewRowAnimation)animation;
-(void)reloadRow_hhz:(NSUInteger)row inSection:(NSUInteger)section withRowAnimation:(UITableViewRowAnimation)animation;
-(void)deleteRow_hhz:(NSUInteger)row inSection:(NSUInteger)section withRowAnimation:(UITableViewRowAnimation)animation;

-(void)insertSection_hhz:(NSUInteger)section withRowAnimation:(UITableViewRowAnimation)animation;
-(void)reloadSection_hhz:(NSUInteger)section withRowAnimation:(UITableViewRowAnimation)animation;
-(void)deleteSection_hhz:(NSUInteger)section withRowAnimation:(UITableViewRowAnimation)animation;

-(void)clearSelectedRowsAnimated_hhz:(BOOL)animated;
@end

NS_ASSUME_NONNULL_END
