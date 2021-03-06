//
//  QcMessageFrame.m
//  160830_qq
//
//  Created by QChris on 16/9/1.
//  Copyright © 2016年 Chrisqc. All rights reserved.
//

#import "QcMessageFrame.h"
#import "QcMessage.h"
#import "NSString+Extension.h"

@implementation QcMessageFrame

- (void)setMessage:(QcMessage *)message {
    _message = message;
    
    CGFloat padding = 10;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    //1. time
    if (_message.hideTime == NO) {
        CGFloat timeX = 0;
        CGFloat timeY = 0;
        CGFloat timeW = screenWidth;;
        CGFloat timeH = 40;
        
        _timeF = CGRectMake(timeX, timeY, timeW, timeH);
    }
    
    //2. icon
    CGFloat iconX;
    CGFloat iconY = CGRectGetMaxY(_timeF) + padding;
    CGFloat iconW = 40;
    CGFloat iconH = 40;
    
    if (message.type == QcMessageTypeOther) {
        iconX = padding;
    }else {
        iconX = screenWidth - padding - iconW;
    }
    _iconF = CGRectMake(iconX, iconY, iconW, iconH);
    
    
    //3. text
    CGFloat textX ;
    
    CGFloat textY = iconY;
    
    CGSize textMaxSize = CGSizeMake(200, MAXFLOAT);
    CGSize textRealSize = [message.text sizeWithFont:[UIFont systemFontOfSize:15] maxSize:textMaxSize];
    
    CGSize textBtnSize = CGSizeMake(textRealSize.width + padding *2, textRealSize.height + padding*2);
    
    if (message.type == QcMessageTypeOther) {
        textX = CGRectGetMaxX(_iconF) + padding;
    }else {
        textX = iconX - padding - textBtnSize.width;
    }
    _textF = (CGRect){{textX,textY},textBtnSize};
    
    //4. cell
    CGFloat textMaxY = CGRectGetMaxY(_textF);
    CGFloat iconMaxY = CGRectGetMaxY(_iconF);
    _cellHeight = MAX(textMaxY,iconMaxY) +padding;
    
}

@end
