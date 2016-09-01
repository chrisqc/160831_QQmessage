//
//  QcMessage.h
//  160830_qq
//
//  Created by QChris on 16/9/1.
//  Copyright © 2016年 Chrisqc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QcMessage : NSObject

@property (nonatomic,copy) NSString *text;
@property (nonatomic,copy) NSString *time;
@property (nonatomic,assign) NSInteger type;

+ (instancetype)QcMessageWithDict:(NSDictionary  *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
