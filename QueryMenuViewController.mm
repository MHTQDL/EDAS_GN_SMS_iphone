//
//  QueryMenuViewController.m
//  查询菜单
//  Created by guan mofeng on 11-12-15.
//  Copyright 2011 北京. All rights reserved.
//

#import "QueryMenuViewController.h"
#import "Constants.h"
#include "GlobalData.h"

@implementation QueryMenuViewController

@synthesize menuList;
 

- (void)dealloc
{
	if (self.menuList != nil)
		[menuList release];
	if (menuTableView != nil)
		[menuTableView release];
	[super dealloc];
}

/*
- (void)viewDidLoad
{
	 	
	self.menuList = [NSMutableArray array];	
	 
	[self.menuList addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
							  @"显示参数", kTitleKey,
							  @"显示参数", kDetailKey,
							  @"SetStationViewController", kViewControllerNameKey,
							  nil
							  ]];

	[self.menuList addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
							  @"台站参数", kTitleKey,
							  @"台站参数", kDetailKey,
							  @"QueryinfoViewController", kViewControllerNameKey,
							  nil
							  ]];
	
	[self.menuList addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
							  @"采集参数", kTitleKey,
							  @"采集参数", kDetailKey,
							  @"QueryinfoViewController", kViewControllerNameKey,
							  nil
							 ]];
	[self.menuList addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
							  @"网络地址", kTitleKey,
							  @"网络地址", kDetailKey,
							  @"QueryinfoViewController", kViewControllerNameKey,
							  nil
							  ]];
	[self.menuList addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
							  @"环境参数", kTitleKey,
							  @"环境参数",kDetailKey,
							  @"QueryinfoViewController", kViewControllerNameKey,
							  nil
							  ]];	
	[self.menuList addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
							  @"地震计零点", kTitleKey,
							  @"地震计零点", kDetailKey,
							  @"QueryinfoViewController", kViewControllerNameKey,
							  nil
							  ]];
	[self.menuList addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
							  @"取消", kTitleKey,
							  @"取消" kDetailKey,
							  @"", kViewControllerNameKey,
							  nil
							  ]];
	
	menuTableView.dataSource = self;
	menuTableView.delegate = self;
	
    [menuTableView reloadData];
	
}

*/

- (void)viewDidLoad
{
	self.menuList = [NSMutableArray array];
	[self.menuList addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
							  @"显示参数", kTitleKey,
							  @"显示参数", kDetailKey,
							  @"QueryinfoViewController", kViewControllerNameKey,
							  nil
							  ]];
	[self.menuList addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
							  @"台站参数", kTitleKey,
							  @"台站参数", kDetailKey,
							  @"QueryinfoViewController", kViewControllerNameKey,
							  nil
							  ]];
	[self.menuList addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
							  @"采集参数", kTitleKey,
							  @"采集参数", kDetailKey,
							  @"QueryinfoViewController", kViewControllerNameKey,
							  nil
							  ]];
	[self.menuList addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
							  @"网络地址", kTitleKey,
							  @"网络地址", kDetailKey,
							  @"QueryinfoViewController", kViewControllerNameKey,
							  nil
							  ]];
	[self.menuList addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
							  @"环境参数", kTitleKey,
							  @"环境参数", kDetailKey,
							  @"QueryinfoViewController", kViewControllerNameKey,
							  nil
							  ]];
	[self.menuList addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
							  @"地震计零点", kTitleKey,
							  @"地震计零点", kDetailKey,
							  @"QueryinfoViewController", kViewControllerNameKey,
							  nil
							  ]];
    [self.menuList addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                              @"网络授时服务", kTitleKey,
                              @"网络授时服务", kDetailKey,
                              @"QueryinfoViewController", kViewControllerNameKey,
                              nil
                              ]];
    [self.menuList addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                              @"标定参数", kTitleKey,
                              @"标定参数", kDetailKey,
                              @"QueryinfoViewController", kViewControllerNameKey,
                              nil
                              ]];
    [self.menuList addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                              @"数据服务", kTitleKey,
                              @"数据服务", kDetailKey,
                              @"QueryinfoViewController", kViewControllerNameKey,
                              nil
                              ]];

	[self.menuList addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:
							  @"取消", kTitleKey,
							  @"取消", kDetailKey,
							  @"", kViewControllerNameKey,
							  nil
							  ]];
	
	menuTableView.dataSource = self;
	menuTableView.delegate = self;
	
    [menuTableView reloadData];
	
}

- (void)viewDidUnload
{
	
}





#pragma mark -
#pragma mark UITableViewDelegate and UITableViewDatasource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [menuList count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{        
	return 1;
}	

- (NSString *)tableView:(UITableView *)aTableView titleForHeaderInSection:(NSInteger)section 
{        
	return nil;
} 

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(0.0f,0.0f, 120.0f,20.0f)]autorelease];  
	label.backgroundColor = [UIColor clearColor];
	label.text = @"查询菜单";
	label.textColor = [UIColor grayColor];
	label.font =  [UIFont systemFontOfSize:10];
	label.textAlignment = NSTextAlignmentCenter;  
	return label;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *kCellIdentifier = @"cellID";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
	if (!cell)
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kCellIdentifier] autorelease];
        
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        cell.textLabel.backgroundColor = [UIColor clearColor];
		cell.textLabel.opaque = NO;
		cell.textLabel.textColor = [UIColor blackColor];
		cell.textLabel.highlightedTextColor = [UIColor whiteColor];
		cell.textLabel.font = [UIFont boldSystemFontOfSize:18];
		
		cell.detailTextLabel.backgroundColor = [UIColor clearColor];
		cell.detailTextLabel.opaque = NO;
		cell.detailTextLabel.textColor = [UIColor grayColor];
		cell.detailTextLabel.highlightedTextColor = [UIColor whiteColor];
		cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    }
    
	// get the view controller's info dictionary based on the indexPath's row
    NSDictionary *dataDictionary = [menuList objectAtIndex:indexPath.row];
    cell.textLabel.text = [dataDictionary valueForKey:kTitleKey];
    cell.detailTextLabel.text = [dataDictionary valueForKey:kDetailKey];
	
	return cell;
	
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {        
	return 40.0f;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {        
	
	/*
	 if(selectRowData != nil)
	 {
	 [selectRowData release];
	 selectRowData = nil;
	 }
	 */
	 if(siteDoc.IsConnected())
	 {
		 siteDoc.m_bshow_allmsg=FALSE;
		 switch (indexPath.row) {
			 case 0://显示全部参数
				 siteDoc.m_bshow_allmsg=TRUE;
				 break;
			 case 1://台站，地震计，仪器响应
				 siteDoc.m_msg="";
				 siteDoc.OnInqSite();
				 siteDoc.OnInqInst();
				 break;
			 case 2://采样率，量程
				 siteDoc.m_msg="";
				 siteDoc.OnInqDas();
				 break;
			 case 3://ip地址，网关
				 siteDoc.m_msg="";
				 siteDoc.OnInqNet();
				 break;
			 case 4://环境信息 ， 磁盘状态
				 siteDoc.m_msg="";
				 siteDoc.OnInqEnv();
				 siteDoc.OnInqHdstat();
				 break;
			 case 5://地震计零点
				 siteDoc.m_msg="";
				 siteDoc.OnInqSensoff();
				 break;
             case 6://网络授时服务器
                 siteDoc.m_msg="";
                 siteDoc.OnInqNTPsrvfrm();
                 break;
             case 7://标定参数
                 siteDoc.m_msg="";
                 siteDoc.OnInqCal();
                 break;
             case 8://数据服务
                 siteDoc.m_msg="";
                 siteDoc.OnInqDatasrv();
                 break;

		 }
	 }
	
	//}
	//selectRowData = [self.menuList objectAtIndex:indexPath.row];
	selectRowData = [self.menuList objectAtIndex:indexPath.row];
	NSString *viewControllerName1 = [selectRowData objectForKey:kViewControllerNameKey];
	if([viewControllerName1 length] == 0){
//		[self.parentViewController dismissModalViewControllerAnimated:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
		selectRowData = nil;
		return;
	} 
	
	
	selectRowData = [self.menuList objectAtIndex:0];
	UIViewController *targetViewController = [selectRowData objectForKey:kViewControllerKey];
	if (!targetViewController)
	{
        // The view controller has not been created yet, create it and set it to our menuList array
        NSString *viewControllerName = [selectRowData objectForKey:kViewControllerNameKey];
		if([viewControllerName length] == 0){
//			[self.parentViewController dismissModalViewControllerAnimated:YES];
            [self dismissViewControllerAnimated:YES completion:nil];
			selectRowData = nil;
			return;
		} 
		
        targetViewController = [[NSClassFromString(viewControllerName) alloc] initWithNibName:viewControllerName bundle:nil];
        [selectRowData setValue:targetViewController forKey:kViewControllerKey];
        [targetViewController release];
    }
//	[self.parentViewController dismissModalViewControllerAnimated:NO];
    [self dismissViewControllerAnimated:NO completion:nil];
	tempSelectRowData = selectRowData;
}

- (UIViewController *) getSelectViewController {
	if(tempSelectRowData == nil){
		return nil;
	}
	UIViewController *targetViewController  = [tempSelectRowData objectForKey:kViewControllerKey];
	tempSelectRowData = nil;
	selectRowData = nil;
	return targetViewController;
	
}




- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscapeLeft;
}
@end
