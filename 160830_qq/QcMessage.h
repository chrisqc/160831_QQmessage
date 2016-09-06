//
//  QcMessage.h
//  160830_qq
//
//  Created by QChris on 16/9/1.
//  Copyright © 2016年 Chrisqc. All rights reserved.
//  add message a 爱

#import <Foundation/Foundation.h>

typedef enum {
    QcMessageTypeMe = 0,
    QcMessageTypeOther
}QcMessageType;

@interface QcMessage : NSObject

@property (nonatomic,copy) NSString *text;
@property (nonatomic,copy) NSString *time;
@property (nonatomic,assign) QcMessageType type;

@property (nonatomic,assign) BOOL hideTime;

+ (instancetype)QcMessageWithDict:(NSDictionary  *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
