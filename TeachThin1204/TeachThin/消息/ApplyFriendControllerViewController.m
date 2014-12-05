//
//  ApplyFriendControllerViewController.m
//  TeachThin
//
//  Created by myStyle on 14-11-28.
//  Copyright (c) 2014年 巩鑫. All rights reserved.
//
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define IS_IOS7 SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")
#import "ApplyFriendControllerViewController.h"
#import "ApplyFriendCell.h"
#import "ApplyEntity.h"
#import "ChatViewController.h"
#import "ChatListCell.h"
#import "NSDateFormatter+Category.h"
#import "NSDate+Category.h"
#import "ConvertToCommonEmoticonsHelper.h"

static ApplyFriendControllerViewController *controller = nil;

@interface ApplyFriendControllerViewController ()<ApplyFriendCellDelegate>
{
    NSInteger rowCount;
    ApplyFriendCell *applyFriendCell;
}
@end

@implementation ApplyFriendControllerViewController

+ (instancetype)shareController
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        controller = [[self alloc] init];
    });
    
    return controller;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
    [self refreshDataSource];
    [self registerNotifications];
    
    self.navigationController.navigationBarHidden = NO;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"消息";
    self.dataArray = [NSMutableArray array];
    self.dataSource = [NSMutableArray array];
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [backButton setImage:[UIImage imageNamed:@"back_arow"] forState:UIControlStateNormal];
    [backButton addTarget:self.navigationController action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
    backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -25, 0, 0);
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:backItem];
    [self loadDataSourceFromLocalDB];
    [self initTableView];
}

#pragma mark -  初始化tableView
-(void)initTableView{
    if (IS_IOS7) {
        self.edgesForExtendedLayout =UIRectEdgeNone ;
    }
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WEIGHT, VIEW_HEIGHT-64) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
}

- (NSString *)loginUsername
{
    NSDictionary *loginInfo = [[[EaseMob sharedInstance] chatManager] loginInfo];
    return [loginInfo objectForKey:kSDKUsername];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0) {
        return [self.dataSource count];;
    }
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *CellIdentifier = @"ApplyFriendCell";
        ApplyFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[ApplyFriendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.delegate = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        
        NSInteger count = [[[ApplyFriendControllerViewController shareController] dataSource] count];
        
        if (count == 0) {
            cell.notifLabel.hidden = YES;
        }
        else
        {
            cell.notifLabel.hidden = NO;
            NSString *tmpStr = [NSString stringWithFormat:@"%li", count];
            cell.notifLabel.text = tmpStr;
            
        }
        if(self.dataSource.count > indexPath.row)
        {
            ApplyEntity *entity = [self.dataSource objectAtIndex:indexPath.row];
            if (entity) {
                cell.indexPath = indexPath;
                ApplyStyle applyStyle = [entity.style longValue];
                if(applyStyle == ApplyStyleFriend){
                    NSInteger count = [[[ApplyFriendControllerViewController shareController] dataSource] count];
                    if (count == 0) {
                        cell.notifLabel.hidden = YES;
                    }
                    else
                    {
                        cell.notifLabel.hidden = NO;
                        NSString *tmpStr = [NSString stringWithFormat:@"%ld", count];
                        cell.notifLabel.text = tmpStr;
                       
                    }
                    cell.nameLabel.text = entity.applicantUsername;
                }
                else{
                }
                cell.contentLabel.text = entity.reason;
            }
        }
        return cell;
    }else if (indexPath.section == 1){
        static NSString *identify = @"chatListCell";
        ChatListCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
        
        if (!cell) {
            cell = [[ChatListCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identify];
        }
        EMConversation *conversation = [self.dataArray objectAtIndex:indexPath.row];
        cell.name = conversation.chatter;
        cell.placeholderImage = [UIImage imageNamed:@"bei_ying.jpeg"];
        cell.detailMsg = [self subTitleMessageByConversation:conversation];
        cell.time = [self lastMessageTimeByConversation:conversation];
        cell.unreadCount = [self unreadMessageCountByConversation:conversation];
        if (indexPath.row % 2 == 1) {
            cell.contentView.backgroundColor = RGBACOLOR(246, 246, 246, 1);
        }else{
            cell.contentView.backgroundColor = [UIColor whiteColor];
        }
        return cell;
    }
    
    return nil;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0 && applyFriendCell == [tableView cellForRowAtIndexPath:indexPath]) {
        [applyFriendCell hideMenuView:YES Animated:YES ];
        [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:YES];
    }else if (indexPath.section == 1){
        
        EMConversation *conversation = [self.dataArray objectAtIndex:indexPath.row];
        
        ChatViewController *chatController;
        NSString *title = conversation.chatter;
        if (conversation.isGroup) {
            NSArray *groupArray = [[EaseMob sharedInstance].chatManager groupList];
            for (EMGroup *group in groupArray) {
                if ([group.groupId isEqualToString:conversation.chatter]) {
                    title = group.groupSubject;
                    break;
                }
            }
        }
        
        NSString *chatter = conversation.chatter;
        chatController = [[ChatViewController alloc] initWithChatter:chatter isGroup:conversation.isGroup];
        chatController.title = title;
        [conversation markMessagesAsRead:YES];
        [self.navigationController pushViewController:chatController animated:YES];
    }
}

- (void)loadDataSourceFromLocalDB
{
//    [self.dataSource removeAllObjects];
    NSDictionary *loginInfo = [[[EaseMob sharedInstance] chatManager] loginInfo];
    NSString *loginName = [loginInfo objectForKey:kSDKUsername];
    NSLog(@">>>loadDataSourceFromLocalDB>>>>>%@",loginName);
    if(loginName && [loginName length] > 0)
    {
        NSPredicate *deletePredicate = [NSPredicate predicateWithFormat:@"receiverUsername = %@ and style = %d", loginName, ApplyStyleFriend];
        NSLog(@">>>loadDataSourceFromLocalDB>>>>>%@",loginName);
        
        [ApplyEntity deleteAllMatchingPredicate:deletePredicate];
        
        NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:@"receiverUsername = %@", loginName];
        NSLog(@">>>searchPredicate>>>>>%@",searchPredicate);
        
        NSFetchRequest *request = [ApplyEntity requestAllWithPredicate:searchPredicate];
        NSLog(@">>>request>>>>>%@",request);
        
        NSArray *applyArray = [ApplyEntity executeFetchRequest:request];
        NSLog(@">>>applyArray>>>>>%@",applyArray);
        [self.dataSource addObjectsFromArray:applyArray];
        NSLog(@">>>self.dataSource>>>>>%ld",self.dataSource.count);
        [self.tableView reloadData];
    }
}
#pragma mark - ApplyFriendCellDelegate

- (void)applyCellAddFriendAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < [self.dataSource count]) {
        [self showHudInView:self.view hint:@"正在发送申请..."];
        
        ApplyEntity *entity = [self.dataSource objectAtIndex:indexPath.row];
        ApplyStyle applyStyle = [entity.style integerValue];
        EMError *error;
        
        if (applyStyle == ApplyStyleGroupInvitation) {
            [[EaseMob sharedInstance].chatManager acceptInvitationFromGroup:entity.groupId error:&error];
        }
        else if (applyStyle == ApplyStyleJoinGroup)
        {
            [[EaseMob sharedInstance].chatManager acceptApplyJoinGroup:entity.groupId groupname:entity.groupSubject applicant:entity.applicantUsername error:&error];
        }
        else if(applyStyle == ApplyStyleFriend){
            [[EaseMob sharedInstance].chatManager acceptBuddyRequest:entity.applicantUsername error:&error];
        }
        
        [self hideHud];
        if (!error) {
            [self.dataSource removeObject:entity];
            [entity deleteEntity];
            [self.tableView reloadData];
            [self save];
        }
        else{
            [self showHint:@"接受失败"];
        }
    }
}

- (void)applyCellRefuseFriendAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < [self.dataSource count]) {
        [self showHudInView:self.view hint:@"正在发送申请..."];
        ApplyEntity *entity = [self.dataSource objectAtIndex:indexPath.row];
        ApplyStyle applyStyle = [entity.style integerValue];
        EMError *error;
        
        if (applyStyle == ApplyStyleGroupInvitation) {
            [[EaseMob sharedInstance].chatManager rejectInvitationForGroup:entity.groupId toInviter:entity.applicantUsername reason:@""];
        }
        else if (applyStyle == ApplyStyleJoinGroup)
        {
            NSString *reason = [NSString stringWithFormat:@"被拒绝加入群组\'%@\'", entity.groupSubject];
            [[EaseMob sharedInstance].chatManager rejectApplyJoinGroup:entity.groupId groupname:entity.groupSubject toApplicant:entity.applicantUsername reason:reason];
        }
        else if(applyStyle == ApplyStyleFriend){
            [[EaseMob sharedInstance].chatManager rejectBuddyRequest:entity.applicantUsername reason:@"" error:&error];
        }
        
        [self hideHud];
        if (!error) {
            [self.dataSource removeObject:entity];
            [entity deleteEntity];
            [self.tableView reloadData];
            [self save];
        }
        else{
            [self showHint:@"拒绝失败"];
        }
    }
}


#pragma mark - public

- (void)addNewApply:(NSDictionary *)dictionary
{
    NSLog(@">>>>>>>>apply  dictionary>>>>>%@",dictionary);
    if (dictionary && [dictionary count] > 0) {
        NSString *applyUsername = [dictionary objectForKey:@"username"];
        ApplyStyle style = [[dictionary objectForKey:@"applyStyle"] intValue];
        
        if (applyUsername && applyUsername.length > 0) {
            for (int i = ([self.dataSource count] - 1); i >= 0; i--) {
                ApplyEntity *oldEntity = [self.dataSource objectAtIndex:i];
                ApplyStyle oldStyle = [oldEntity.style intValue];
                if (oldStyle == style && [applyUsername isEqualToString:oldEntity.applicantUsername]) {
                    if(style != ApplyStyleFriend)
                    {
                        NSString *newGroupid = [dictionary objectForKey:@"groupname"];
                        if (newGroupid || [newGroupid length] > 0 || [newGroupid isEqualToString:oldEntity.groupId]) {
                            break;
                        }
                    }
                    
                    oldEntity.reason = [dictionary objectForKey:@"applyMessage"];
                    [self.dataSource removeObject:oldEntity];
                    [self.dataSource insertObject:oldEntity atIndex:0];
                    [self.tableView reloadData];
                    [self save];
                    
                    return;
                }
            }
            
            //new apply
            ApplyEntity *newEntity = [ApplyEntity createEntity];
            newEntity.applicantUsername = [dictionary objectForKey:@"username"];
            newEntity.style = [dictionary objectForKey:@"applyStyle"];
            newEntity.reason = [dictionary objectForKey:@"applyMessage"];
            
            NSDictionary *loginInfo = [[[EaseMob sharedInstance] chatManager] loginInfo];
            NSString *loginName = [loginInfo objectForKey:kSDKUsername];
            newEntity.receiverUsername = loginName;
            
            NSString *groupId = [dictionary objectForKey:@"groupId"];
            newEntity.groupId = (groupId && groupId.length > 0) ? groupId : @"";
            
            NSString *groupSubject = [dictionary objectForKey:@"groupname"];
            newEntity.groupSubject = (groupSubject && groupSubject.length > 0) ? groupSubject : @"";
            
            [self.dataSource insertObject:newEntity atIndex:0];
            [self.tableView reloadData];
            
            if (style != ApplyStyleFriend) {
                [self save];
            }
        }
    }
}


- (void)back
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"setupUntreatedApplyCount" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)save
{
    [[NSManagedObjectContext defaultContext] saveToPersistentStoreAndWait];
}

- (void)clear
{
    [self.dataSource removeAllObjects];
    [self.tableView reloadData];
}


#warning 处理cell的滑动效果
#pragma mark - 处理cell的滑动效果
-(void)setCanCustomEdit:(BOOL)canCustomEdit{
    if (_canCustomEdit != canCustomEdit) {
        _canCustomEdit = canCustomEdit;
        if (_canCustomEdit) {
            if (hitView == nil) {
                hitView = [[HitView alloc] init];
                hitView.delegate = self;
                hitView.frame = applyFriendCell.frame;
                NSString *vRectStr = NSStringFromCGRect(applyFriendCell.frame);
                NSLog(@"%@",vRectStr);
            }
            hitView.frame = applyFriendCell.frame;
            [self.view addSubview:hitView];
            
            self.tableView.scrollEnabled = NO;
        }else{
            applyFriendCell = nil;
            [hitView removeFromSuperview];
            self.tableView.scrollEnabled = YES;
        }
    }
}

-(void)didCellWillShow:(id)aSender{
    applyFriendCell = aSender;
    self.canCustomEdit = YES;
}

-(void)didCellWillHide:(id)aSender{
    applyFriendCell = nil;
    self.canCustomEdit = NO;
}

-(void)didCellHided:(id)aSender{
    applyFriendCell = nil;
    self.canCustomEdit = NO;
}

-(void)didCellShowed:(id)aSender{
    applyFriendCell = aSender;
    self.canCustomEdit = YES;
    NSLog(@"调用Delegate");
}

#pragma mark HitViewDelegate
-(UIView *)hitViewHitTest:(CGPoint)point withEvent:(UIEvent *)event TouchView:(UIView *)aView{
    BOOL vCloudReceiveTouch = NO;
    CGRect vSlidedCellRect = [applyFriendCell convertRect:applyFriendCell.frame fromView:self.tableView];
    vCloudReceiveTouch = CGRectContainsPoint(vSlidedCellRect, point);
    if (!vCloudReceiveTouch) {
        [applyFriendCell hideMenuView:YES Animated:YES];
    }
    return vCloudReceiveTouch ? [applyFriendCell hitTest:point withEvent:event] : aView;
}




#warning 未读消息

#pragma mark - private

- (NSMutableArray *)loadDataSource
{
    NSMutableArray *ret = nil;
    NSArray *conversations = [[EaseMob sharedInstance].chatManager conversations];
    NSArray* sorte = [conversations sortedArrayUsingComparator:
                      ^(EMConversation *obj1, EMConversation* obj2){
                          EMMessage *message1 = [obj1 latestMessage];
                          EMMessage *message2 = [obj2 latestMessage];
                          if(message1.timestamp > message2.timestamp) {
                              return(NSComparisonResult)NSOrderedAscending;
                          }else {
                              return(NSComparisonResult)NSOrderedDescending;
                          }
                      }];
    ret = [[NSMutableArray alloc] initWithArray:sorte];
    return ret;
}

// 得到最后消息时间
-(NSString *)lastMessageTimeByConversation:(EMConversation *)conversation
{
    NSString *ret = @"";
    EMMessage *lastMessage = [conversation latestMessage];;
    if (lastMessage) {
        ret = [NSDate formattedTimeFromTimeInterval:lastMessage.timestamp];
    }
    
    return ret;
}

// 得到未读消息条数
- (NSInteger)unreadMessageCountByConversation:(EMConversation *)conversation
{
    NSInteger ret = 0;
    ret = conversation.unreadMessagesCount;
    
    return  ret;
}

// 得到最后消息文字或者类型
-(NSString *)subTitleMessageByConversation:(EMConversation *)conversation
{
    NSString *ret = @"";
    EMMessage *lastMessage = [conversation latestMessage];
    if (lastMessage) {
        id<IEMMessageBody> messageBody = lastMessage.messageBodies.lastObject;
        switch (messageBody.messageBodyType) {
            case eMessageBodyType_Image:{
                ret = @"[图片]";
            } break;
            case eMessageBodyType_Text:{
                // 表情映射。
                NSString *didReceiveText = [ConvertToCommonEmoticonsHelper
                                            convertToSystemEmoticons:((EMTextMessageBody *)messageBody).text];
                ret = didReceiveText;
            } break;
            case eMessageBodyType_Voice:{
                ret = @"[声音]";
            } break;
            case eMessageBodyType_Location: {
                ret = @"[位置]";
            } break;
            case eMessageBodyType_Video: {
                ret = @"[视频]";
            } break;
            default: {
            } break;
        }
    }
    
    return ret;
}

#pragma mark - IChatMangerDelegate

////
//- (void)didReceiveBuddyRequest:(NSString *)username
//                       message:(NSString *)message
//{
//#if !TARGET_IPHONE_SIMULATOR
//    [self playSoundAndVibration];
//    
//    BOOL isAppActivity = [[UIApplication sharedApplication] applicationState] == UIApplicationStateActive;
//    if (!isAppActivity) {
//        //发送本地推送
//        UILocalNotification *notification = [[UILocalNotification alloc] init];
//        notification.fireDate = [NSDate date]; //触发通知的时间
//        notification.alertBody = [NSString stringWithFormat:@"%@ %@", username, @"添加你为好友"];
//        notification.alertAction = @"打开";
//        notification.timeZone = [NSTimeZone defaultTimeZone];
//    }
//#endif
//
//}
#pragma mark - IChatManagerDelegate 好友变化

- (void)didReceiveBuddyRequest:(NSString *)username
                       message:(NSString *)message
{
    if (!username) {
        return;
    }
    if (!message) {
        message = [NSString stringWithFormat:@"%@ 添加你为好友", username];
    }
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:@{@"title":username, @"username":username, @"applyMessage":message, @"applyStyle":[NSNumber numberWithInteger:ApplyStyleFriend]}];
    [[ApplyFriendControllerViewController shareController] addNewApply:dic];
}

//
- (void)didUpdateBuddyList:(NSArray *)buddyList
            changedBuddies:(NSArray *)changedBuddies
                     isAdd:(BOOL)isAdd
{
    [[ApplyFriendControllerViewController shareController] reloadDataSource];
}

- (void)didRemovedByBuddy:(NSString *)username
{
    [[EaseMob sharedInstance].chatManager removeConversationByChatter:username deleteMessages:YES];
    [[ApplyFriendControllerViewController shareController] refreshDataSource];
    [[ApplyFriendControllerViewController shareController] reloadDataSource];
}
////
- (void)didAcceptedByBuddy:(NSString *)username
{
    [[ApplyFriendControllerViewController shareController] reloadDataSource];
}
//
- (void)didRejectedByBuddy:(NSString *)username
{
    NSString *message = [NSString stringWithFormat:@"你被'%@'无耻的拒绝了", username];
    TTAlertNoTitle(message);
}
//
- (void)didAcceptBuddySucceed:(NSString *)username{
    [[ApplyFriendControllerViewController shareController] reloadDataSource];
}

-(void)didUnreadMessagesCountChanged
{
    [self refreshDataSource];
}

- (void)didUpdateGroupList:(NSArray *)allGroups error:(EMError *)error
{
    [self refreshDataSource];
}

#pragma mark - dataSource

- (void)reloadDataSource
{
    [self showHudInView:self.view hint:@"刷新数据..."];
    [self.dataSource removeAllObjects];
    
    NSArray *buddyList = [[EaseMob sharedInstance].chatManager buddyList];
    for (EMBuddy *buddy in buddyList) {
        NSLog(@">>>>>>>>>%@",buddy.username);
    }
    for (EMBuddy *buddy in buddyList) {
        if (buddy.followState != eEMBuddyFollowState_NotFollowed) {
            [self.dataSource addObject:buddy];
        }
    }
    
    NSDictionary *loginInfo = [[[EaseMob sharedInstance] chatManager] loginInfo];
    NSString *loginUsername = [loginInfo objectForKey:kSDKUsername];
    if (loginUsername && loginUsername.length > 0) {
        EMBuddy *loginBuddy = [EMBuddy buddyWithUsername:loginUsername];
        [self.dataSource addObject:loginBuddy];
    }
    [self.tableView reloadData];
    [self hideHud];
}


#pragma mark - registerNotifications
-(void)registerNotifications{
    [self unregisterNotifications];
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
}

-(void)unregisterNotifications{
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
}

- (void)dealloc{
    [self unregisterNotifications];
}

#pragma mark - public

-(void)refreshDataSource
{
    [self.dataArray removeAllObjects];
    self.dataArray = [self loadDataSource];
    NSLog(@">>>>>>>>>>>%ld",self.dataArray.count);
    [self.tableView reloadData];
    [self hideHud];
}

- (void)isConnect:(BOOL)isConnect{
    if (!isConnect) {
    }
    else{
        self.tableView.tableHeaderView = nil;
    }
}

@end
