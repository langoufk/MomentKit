//
//  Utility.m
//  MomentKit
//
//  Created by LEA on 2017/12/12.
//  Copyright © 2017年 LEA. All rights reserved.
//

#import "Utility.h"

@implementation Utility

// 时间戳转换
+ (NSString *)getMomentTime:(long long)timestamp
{
    NSTimeInterval nowTimestamp = [[NSDate date] timeIntervalSince1970] ;
    long long timeDifference = nowTimestamp - timestamp;
    long long second = timeDifference;
    long long minute = second/60;
    long long hour = minute/60;
    long long day = hour/24;
    long long month = day/30;
    long long year = month/12;
    
    if (1 <= year) {
        return [NSString stringWithFormat:@"%lld年前",year];
    } else if(1 <= month) {
        return [NSString stringWithFormat:@"%lld月前",month];
    } else if(1 <= day) {
        return [NSString stringWithFormat:@"%lld天前",day];
    } else if(1 <= hour) {
        return [NSString stringWithFormat:@"%lld小时前",hour];
    } else if(1 <= minute) {
        return [NSString stringWithFormat:@"%lld分钟前",minute];
    } else if(1 <= second) {
        return [NSString stringWithFormat:@"%lld秒前",second];
    } else {
        return @"刚刚";
    }
}

+ (NSString *)getMessageTime:(long long)timeStemp
{
    // 入参日期
    NSTimeZone * timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    [dateFormatter setTimeZone:timeZone];
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:timeStemp];
    // 当前日期
    NSDate * curDate = [NSDate date];
    // 日历
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitDay;
    // 获取日期差
    NSDateComponents * delta = [calendar components:unit fromDate:curDate toDate:date options:0];
    NSInteger day = delta.day;
    NSString * temString = nil;
    if (day == 0) { // 今天
        [dateFormatter setDateFormat:@"HH:mm"];
        temString = [dateFormatter stringFromDate:date];
    } else if (day == 1) { // 昨天
        return @"昨天";
    } else {
        [dateFormatter setDateFormat:@"yyyy/M/d"];
        temString = [dateFormatter stringFromDate:date];
    }
    return temString;
}

// 获取单张图片的实际size
+ (CGSize)getSingleSize:(CGSize)singleSize
{
    CGFloat maxWidth = k_screen_width - 150;
    CGFloat maxHeight = k_screen_width - 130;
    CGFloat width = singleSize.width;
    CGFloat height = singleSize.height;
    
    CGFloat outWidth = 0;
    CGFloat outHeight = 0;
    if (height / width > 3.0) { // 细长图
        outHeight = maxHeight;
        outWidth = outHeight / 2.0;
    } else  {
        outWidth = maxWidth;
        outHeight = maxWidth * height / width;
        if (outHeight > maxHeight) {
            outHeight = maxHeight;
            outWidth = maxHeight * width / height;
        }
    }
    return CGSizeMake(outWidth, outHeight);
}

// 颜色转图片
+ (UIImage *)imageWithRenderColor:(UIColor *)color renderSize:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    [color setFill];
    UIRectFill(CGRectMake(0, 0, size.width, size.height));
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
