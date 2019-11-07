//
//  NSString+Justu.h
//  CategoryDemo
//
//  Created by zhubo on 15/12/10.
//  Copyright © 2015年 zhubo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Justu)

#pragma mark - 设备信息
/**
 返回一个新的 UUID 字符串
 e.g. "D1178E50-2A4D-4F1F-9BD3-F6AAB00E06B1"
 */
+ (NSString *)stringWithUUID;

#pragma mark - md5加密
/**
 *  md5加密
 *
 *  @return return value description
 */
- (NSString*)md5;

#pragma mark - JSON字符串转成NSDictionary
/**
 *  @brief  JSON字符串转成NSDictionary
 *
 *  @return NSDictionary
 */
- (NSDictionary *)dictionaryValue;
/**
 *  把字典或数组转成JSON字符串
 *
 *  @param object 字典或数组
 *
 *  @return JSON
 */
- (NSString *)jsonWithObject:(id)object;

#pragma mark - Unicode编码的字符串转成NSString
/**
 *  @brief  Unicode编码的字符串转成NSString
 *
 *  @return NSString
 */
- (NSString *)makeUnicodeToString;

#pragma mark - size(计算文本高度或宽度)

/**
 *  @brief 计算文字的高度
 *
 *  @param font  字体(默认为系统字体)
 *  @param width 约束宽度
 */
- (CGFloat)heightWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width;
/**
 *  @brief 计算文字的宽度
 *
 *  @param font   字体(默认为系统字体)
 *  @param height 约束高度
 */
- (CGFloat)widthWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height;

/**
 *  @brief 计算文字的大小
 *
 *  @param font  字体(默认为系统字体)
 *  @param width 约束宽度
 */
- (CGSize)sizeWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width;
/**
 *  @brief 计算文字的大小
 *
 *  @param font   字体(默认为系统字体)
 *  @param height 约束高度
 */
- (CGSize)sizeWithFont:(UIFont *)font constrainedToHeight:(CGFloat)height;


#pragma mark - 反转字符串
/**
 *  @brief  反转字符串
 *
 *  @param strSrc 被反转字符串
 *
 *  @return 反转后字符串
 */
+ (NSString *)reverseString:(NSString *)strSrc;

#pragma mark - 去除空格
/**
 *  @brief  去除两端空格
 *
 *  @return 去除空格后的字符串
 */
- (NSString *)trimmingWhitespace;
/**
 *  @brief  去除两端字符串与空行
 *
 *  @return 去除字符串与空行的字符串
 */
- (NSString *)trimmingWhitespaceAndNewlines;

/**
 *  去除所有空格
 *
 *  @return return value description
 */
- (NSString *)trimmingAllspace;


#pragma mark - url query转成NSDictionary
/**
 *  @brief  url query转成NSDictionary
 *
 *  @return NSDictionary
 */
- (NSDictionary *)dictionaryFromURLParameters;

#pragma mark - 拨打电话
/**
 *  拨打电话
 *
 *  @param PhoneNumber 电话号码
 */
+ (void)callPhoneWithPhoneNumber:(NSString *)PhoneNumber;

#pragma mark - 正则验证

/**
 *  手机号码的有效性:分电信、联通、移动和小灵通
 */
- (BOOL)isMobileNumberClassification;
/**
 *  手机号有效性
 */
- (BOOL)isMobileNumber;

/**
 *  隐藏手机号中间四位 159****1234
 */
- (NSString *)mobileNumberSuitScanf;

/**
 *密码（8～12）位字符或者数字
 */
- (BOOL)isPassword;

/*
 *  邮箱的有效性
 */
- (BOOL)isEmailAddress;

/**
 *  简单的身份证有效性
 *
 */
- (BOOL)simpleVerifyIdentityCardNum;

/**
 *  精确的身份证号码有效性检测
 *
 *  @param value 身份证号
 */
+ (BOOL)accurateVerifyIDCardNumber:(NSString *)value;

/**
 *  车牌号的有效性
 */
- (BOOL)isCarNumber;

/**
 *  银行卡的有效性
 */
- (BOOL)bankCardluhmCheck;

/**
 *  IP地址有效性
 */
- (BOOL)isIPAddress;

/**
 *  Mac地址有效性
 */
- (BOOL)isMacAddress;

/**
 *  网址有效性
 */
- (BOOL)isValidUrl;

/**
 *  纯汉字
 */
- (BOOL)isValidChinese;

/**
 *  是否为整形
 */
+ (BOOL)isPureInt:(NSString *)string;

/**
 *  邮政编码
 */
- (BOOL)isValidPostalcode;

/**
 *  工商税号
 */
- (BOOL)isValidTaxNo;

/**
 @brief     是否符合最小长度、最长长度，是否包含中文,首字母是否可以为数字
 @param     minLenth 账号最小长度
 @param     maxLenth 账号最长长度
 @param     containChinese 是否包含中文
 @param     firstCannotBeDigtal 首字母不能为数字
 @return    正则验证成功返回YES, 否则返回NO
 */
- (BOOL)isValidWithMinLenth:(NSInteger)minLenth
                   maxLenth:(NSInteger)maxLenth
             containChinese:(BOOL)containChinese
        firstCannotBeDigtal:(BOOL)firstCannotBeDigtal;

/**
 @brief     是否符合最小长度、最长长度，是否包含中文,数字，字母，其他字符，首字母是否可以为数字
 @param     minLenth 账号最小长度
 @param     maxLenth 账号最长长度
 @param     containChinese 是否包含中文
 @param     containDigtal   包含数字
 @param     containLetter   包含字母
 @param     containOtherCharacter   其他字符
 @param     firstCannotBeDigtal 首字母不能为数字
 @return    正则验证成功返回YES, 否则返回NO
 */
- (BOOL)isValidWithMinLenth:(NSInteger)minLenth
                   maxLenth:(NSInteger)maxLenth
             containChinese:(BOOL)containChinese
              containDigtal:(BOOL)containDigtal
              containLetter:(BOOL)containLetter
      containOtherCharacter:(NSString *)containOtherCharacter
        firstCannotBeDigtal:(BOOL)firstCannotBeDigtal;





/**
 是否是集装箱号

 @return 正则验证成功返回YES, 否则返回NO
 */
- (BOOL)isCntrNumber;

/**获取当前时间时间戳*/
+(NSInteger)getCurrentTimes;

// UTC时间转成本地时间
-(NSString *)an_utcTimeToLocalTime;

/**
 转换时间戳为 指定格式的时间
 
 @param fmt 时间格式
 @return 指定格式的时间
 */
- (NSString *)an_transformTimeStampToDateWithFmt:(NSString *)fmt;

/**
 把字符串时间 转换成时间戳
 
 @param fmtStr 时间格式
 @return 时间戳
 */
- (NSInteger )an_transformDateStrToStampWithFmt:(NSString *)fmtStr;


/**
 把字符串时间有旧格式转换为新格式
 
 @param oldFmt 旧格式
 @param toFmt 新格式
 @return 新时间
 */
- (NSString *)an_transformTimeFromOldFmt:(NSString *)oldFmt toFmt:(NSString *)toFmt;

/**
 隐藏手机号中间四位
 
 @return SecretPhone
 */
- (NSString *)an_transfomSecretPhone;

/**
 隐藏身份中中间八位
 
 @return SecretIdCard
 */
- (NSString *)an_transformSecretIdCard;



//用户名校验
- (BOOL)isUserName;

//日期字符串转日期
-(NSDate *)stringByDate;

@end
