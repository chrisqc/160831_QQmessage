//
//  ViewController.m
//  160830_qq
//
//  Created by QChris on 16/8/30.
//  Copyright © 2016年 Chrisqc. All rights reserved.
//

#import "ViewController.h"
#import "QcMessageFrame.h"
#import "QcMessage.h"
#import "QcMessageCell.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (nonatomic,strong) NSMutableArray *messageArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *inputView;

@property (nonatomic,strong) NSDictionary *autoreply;

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1. 表格设定
    //去除分割线
    self.tableView.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.allowsSelection = NO;
    // Do any additional setup after loading the view, typically from a nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    
    self.inputView.delegate = self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSMutableArray *)messageArray {
    if (_messageArray == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"messages.plist" ofType:nil];
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            QcMessage *message = [QcMessage QcMessageWithDict:dict];
            
            QcMessageFrame *lastMF = [array lastObject];
            QcMessage *lastMsg = lastMF.message;
            
            message.hideTime = [message.time isEqualToString:lastMsg.time];
            
            QcMessageFrame *messageframe = [[QcMessageFrame alloc] init];
            messageframe.message = message;
            [array addObject:messageframe];
        }
        _messageArray = array;
    }
    return _messageArray;
}

//addMessage方法接受文本栏传入的信息，处理自己发言和自动回复的标记
- (void)addMessage:(NSString *)text type:(NSInteger)type {
    //1 .数据类型
    QcMessage *msg = [[QcMessage alloc] init];
    msg.type = type;
    msg.text = text;
    
    //设置数据模型的时间
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"HH:mm";
    msg.time = [fmt stringFromDate:now];
    
    //查看是否要隐藏时间
    QcMessageFrame *lastMf = [self.messageArray lastObject];
    QcMessage *lastMsg =  lastMf.message;
    msg.hideTime = [msg.time isEqualToString:lastMsg.time];
    
    //2.frame模型
    QcMessageFrame *mf = [[QcMessageFrame alloc] init];
    mf.message = msg;
    [self.messageArray addObject:mf];
    
    //3. 刷新表格
    [self.tableView reloadData];
    
    //4. 自动滚动至最后一行
    NSIndexPath *lastPath = [NSIndexPath indexPathForRow:self.messageArray.count - 1 inSection:0];
    [self.tableView scrollToRowAtIndexPath:lastPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}


#pragma mark --实现数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messageArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    QcMessageCell *cell = [QcMessageCell cellWithTableView:tableView];
    
    cell.messageFrame = self.messageArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    QcMessageFrame *mf = self.messageArray[indexPath.row];
    
    return mf.cellHeight;
}

#pragma mark - 通知方法
- (void)keyboardWillChangeFrame:(NSNotification *)note {
    
    //self.view.window.backgroundColor = self.tableView.backgroundColor;
    
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    CGRect keyboradFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat transformY = keyboradFrame.origin.y - self.view.frame.size.height;
    
    [UIView animateWithDuration:duration animations:^{
        self.view.transform = CGAffineTransformMakeTranslation(0, transformY);
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    //1.自己发了条信息
    [self addMessage:textField.text type:QcMessageTypeMe];
    
    
    //自动回复
    NSString *reply= [self replayWithText:textField.text];
    [self addMessage:reply type:QcMessageTypeOther];
    
    self.inputView.text = nil;
    
    return YES;
}

- (NSString *)replayWithText:(NSString *)text {
    for ( int i=0 ; i<text.length; i++) {
        NSString *word = [text substringWithRange:NSMakeRange(i, 1)];
        if (self.autoreply[word]) {
            return self.autoreply[word];
        }
        
    }
    return @"aaaa";
}
- (NSDictionary *)autoreply {
    if (_autoreply == nil) {
        _autoreply = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"autoreply.plist" ofType:nil]];
    }
    return _autoreply;
}

@end
