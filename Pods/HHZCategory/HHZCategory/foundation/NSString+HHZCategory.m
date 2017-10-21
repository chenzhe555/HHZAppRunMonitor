//
//  NSString+HHZCategory.m
//  iOS-HHZUniversal
//
//  Created by 陈哲#376811578@qq.com on 16/11/19.
//  Copyright © 2016年 陈哲是个好孩子. All rights reserved.
//

#import "NSString+HHZCategory.h"
#import <objc/runtime.h>

@implementation NSString (HHZ_AttributString)

-(NSMutableAttributedString *)hhz_addCustomAttributeFont:(UIFont *)font andColor:(UIColor *)color andRange:(NSRange)range
{
    NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc]initWithString:self];
    if (font)
    {
        [attStr addAttribute:NSFontAttributeName value:font range:range];
    }
    if (color)
    {
        [attStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    }
    return attStr;
}

-(NSMutableAttributedString *)hhz_addCustomAttributeFont:(UIFont *)font andColor:(UIColor *)color andText:(NSString *)searchText
{
    if ([self rangeOfString:searchText].location == NSNotFound)
    {
        return [[NSMutableAttributedString alloc]initWithString:self];
    }
    NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc]initWithString:self];
    NSMutableArray * mutaArr = [NSMutableArray array];
    NSRange searchRange = NSMakeRange(0, self.length);
    NSRange resultRange;
    while ((resultRange = [self rangeOfString:searchText options:0 range:searchRange]).location != NSNotFound)
    {
        [mutaArr addObject:[NSValue valueWithRange:resultRange]];
        searchRange = NSMakeRange(NSMaxRange(resultRange), self.length - NSMaxRange(resultRange));
    }
    for (int i = 0; i < mutaArr.count; i++)
    {
        if (font)
        {
            [attStr addAttribute:NSFontAttributeName value:font range:[[mutaArr objectAtIndex:i] rangeValue]];
        }
        if (color)
        {
            [attStr addAttribute:NSForegroundColorAttributeName value:color range:[[mutaArr objectAtIndex:i] rangeValue]];
        }
    }
    return attStr;
}

-(NSMutableAttributedString *)hhz_addLineAttributerWithTextWithColor:(UIColor *)color
{
    return [self hhz_addLineAttributerWithRange:NSMakeRange(0, self.length) andColor:color];
}

-(NSMutableAttributedString *)hhz_addLineAttributerWithRange:(NSRange)range andColor:(UIColor *)color
{
    NSMutableAttributedString * str = [[NSMutableAttributedString alloc] initWithString:self];
    //加入下划线
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:range];
    //如果传入颜色，则加上下划线颜色
    if (color != nil)
    {
        [str addAttribute:NSUnderlineColorAttributeName value:color range:range];
    }
    return str;
}

@end

@implementation NSString (HHZ_ClassBuild)

-(Class)hhz_getObjClass
{
    const char * className = [self cStringUsingEncoding:NSASCIIStringEncoding];
    Class objClass = objc_getClass(className);
    //如果木有,则注册创建一个
    if (objClass == nil)
    {
        Class superClass = [NSObject class];
        objClass = objc_allocateClassPair(superClass, className, 0);
        objc_registerClassPair(objClass);
    }
    return objClass;
}

@end

@implementation NSString (HHZ_Emoji)

-(BOOL)hhz_isIncludeEmoji:(EmojiType)type
{
    switch (type) {
        case EmojiTypeNormal:
        {
            return [self hhz_isIncludeNormalEmoji];
        }
            break;
            
        default:
            break;
    }
}

-(BOOL)hhz_isIncludeNormalEmoji
{
    BOOL __block result = NO;
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
        if ([substring hhz_isNormalEmoji]) {
            *stop = YES;
            result = YES;
        }
    }];
    return result;
}

-(BOOL)hhz_isNormalEmoji
{
    const unichar hs = [self characterAtIndex:0];
    // surrogate pair
    if (0xd800 <= hs && hs <= 0xdbff) {
        if (self.length > 1) {
            const unichar ls = [self characterAtIndex:1];
            const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
            if (0x1d000 <= uc && uc <= 0x1f77f) {
                return YES;
            }
            if (hs == 0xd83e) {
                return YES;
            }
        }
    } else if (self.length > 1) {
        const unichar ls = [self characterAtIndex:1];
        if (ls == 0x20e3 || ls == 0xfe0f) {
            return YES;
        }
        
    } else {
        // non surrogate
        if (0x2100 <= hs && hs <= 0x27ff) {
            return YES;
        } else if (0x2B05 <= hs && hs <= 0x2b07) {
            return YES;
        } else if (0x2934 <= hs && hs <= 0x2935) {
            return YES;
        } else if (0x3297 <= hs && hs <= 0x3299) {
            return YES;
        } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
            return YES;
        } else {
            return NO;
        }
    }
    
    return NO;
}

-(instancetype)hhz_removedEmojiString:(EmojiType)type
{
    switch (type) {
        case EmojiTypeNormal:
        {
            return [self hhz_removedNormalEmojiString];
        }
            break;
            
        default:
            break;
    }
}

-(instancetype)hhz_removedNormalEmojiString
{
    NSMutableString * __block buffer = [NSMutableString stringWithCapacity:[self length]];
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
        [buffer appendString:([substring hhz_isNormalEmoji])? @"": substring];
    }];
    return buffer;
}

@end

@implementation NSString (HHZ_Regular)

+(BOOL)hhz_isEmptyValue:(NSString *)value
{
    if ([value isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    else if (value == nil)
    {
        return YES;
    }
    return NO;
}

-(BOOL)hhz_isEmptyOrAllSpace
{
    if (self.length > 0)
    {
        NSString * trimedString = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([trimedString length] > 0) return false;
    }
    return true;
}

-(BOOL)hhz_matchingWithMatchingStringWithRegularExpression:(NSString *)expression
{
    NSPredicate * regularPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", expression];
    return [regularPredicate evaluateWithObject:self];
}

-(BOOL)hhz_matchingPhoneNumber
{
    return [self hhz_matchingWithMatchingStringWithRegularExpression:@"^1[3-8]\\d{9}$"];
}

-(BOOL)hhz_matchingEmailNumber
{
    return [self hhz_matchingWithMatchingStringWithRegularExpression:@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"];
}

-(BOOL)hhz_matchingIdentityCard
{
    return [self hhz_matchingWithMatchingStringWithRegularExpression:@"^(\\d{14}|\\d{17})(\\d|[xX])$"];
}

@end

