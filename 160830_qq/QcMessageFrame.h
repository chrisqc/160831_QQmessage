//
//  QcMessageFrame.h
//  160830_qq
//
//  Created by QChris on 16/9/1.
//  Copyright © 2016年 Chrisqc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class QcMessage;

@interface QcMessageFrame : NSObject

@property (nonatomic,assign) CGRect timeF;
@property (nonatomic,assign) CGRect iconF;
@property (nonatomic,assign) CGRect textF;
@property (nonatomic,assign) CGFloat cellHeight;

@property (nonatomic,strong) QcMessage *message;

@end
