//
//  SetPulseViewController.m
// 脉冲标定
//  Created by guan mofeng on 12-3-29.
//  Copyright 2012 北京. All rights reserved.
//

#import "SetPulseViewController.h"
#include "GlobalData.h"
#define NUMBERSINT @"0123456789\n"
#define NUMBERSFLOAT @"-0123456789.\n"

extern char sens_id[];

@implementation SetPulseViewController


- (void) initUI {
	
	int i = 0;
	char temp[100];
	NSMutableArray *comboSensData = [NSMutableArray array];
	for(i=0;i<siteDoc.m_das.stnpar.sens_num;i++)
	{
		sprintf(temp,"地震计 %c",  sens_id[i]);
		[comboSensData addObject:[[NSString alloc] initWithUTF8String:temp]];
	}
	
	if(siteDoc.m_das.stnpar.sens_num != 0) {
		[cmboSens setItems:comboSensData];
		[self comboBox:cmboSens selectItemAtIndex:0];
		//[comboSensData release];
	}
	
	
	
	
}
- (void) initUI1: (NSInteger)m_sensid
{
	//int m_sensid = [cmboSens getSelectIndex];
	char temp[1024];
	[ckBTimer setChecked:siteDoc.m_das.sens[m_sensid].pulse.btimer];
	sprintf(temp,"%d", siteDoc.m_das.sens[m_sensid].pulse.amp);
	txtAmp.text = [[NSString alloc]initWithUTF8String : temp];
	[cmboAmpType setSelectIndex:siteDoc.m_das.sens[m_sensid].pulse.amptype]; 
	
	//m_type=m_das->sens[m_sensid].pulse.amptype;
	//m_dur=m_das->sens[m_sensid].pulse.dur/10.f;
	
	sprintf(temp,"%f", siteDoc.m_das.sens[m_sensid].pulse.dur/10.f);
	txtDur.text = [[NSString alloc]initWithUTF8String : temp];
	
	//m_tm_method=m_das->sens[m_sensid].pulse.method;
	[cmbMethod setSelectIndex:siteDoc.m_das.sens[m_sensid].pulse.method];
	
	if(siteDoc.m_das.sens[m_sensid].pulse.method==0)
	{
		[cmboHour setSelectIndex:siteDoc.m_das.sens[m_sensid].pulse.tm_start1];
		[cmboMin setSelectIndex:siteDoc.m_das.sens[m_sensid].pulse.tm_start2];
		labDay.text = @"日：";
		//m_tm_hr=m_das->sens[m_sensid].pulse.tm_start1;
		//m_tm_min=m_das->sens[m_sensid].pulse.tm_start2;
		//m_static_date.LoadString(IDS_TMLABEL1); "日：
		
	}else if(siteDoc.m_das.sens[m_sensid].pulse.method==1)
	{
		
		[cmboDay setSelectIndex:siteDoc.m_das.sens[m_sensid].pulse.tm_start1 - 1];
		[cmboHour setSelectIndex:siteDoc.m_das.sens[m_sensid].pulse.tm_start2];
		[cmboMin setSelectIndex:siteDoc.m_das.sens[m_sensid].pulse.tm_start3];
		labDay.text = @"星期：";
		//m_tm_date=m_das->sens[m_sensid].pulse.tm_start1-1;
		//m_tm_hr=m_das->sens[m_sensid].pulse.tm_start2;
		//m_tm_min=m_das->sens[m_sensid].pulse.tm_start3;
		//m_static_date.LoadString(IDS_TMLABEL2); //"星期："
	}else if(siteDoc.m_das.sens[m_sensid].pulse.method==2){
		
		[cmboDay setSelectIndex:siteDoc.m_das.sens[m_sensid].pulse.tm_start1 - 1];
		[cmboHour setSelectIndex:siteDoc.m_das.sens[m_sensid].pulse.tm_start2];
		[cmboMin setSelectIndex:siteDoc.m_das.sens[m_sensid].pulse.tm_start3];
		labDay.text = @"日：";
		//m_tm_date=m_das->sens[m_sensid].pulse.tm_start1-1;
		//m_tm_hr=m_das->sens[m_sensid].pulse.tm_start2;
		//m_tm_min=m_das->sens[m_sensid].pulse.tm_start3;
		//m_static_date.LoadString(IDS_TMLABEL1); "日：
	}else if(siteDoc.m_das.sens[m_sensid].pulse.method==3){
		
		[cmboMon setSelectIndex:siteDoc.m_das.sens[m_sensid].pulse.tm_start1 - 1];
		[cmboDay setSelectIndex:siteDoc.m_das.sens[m_sensid].pulse.tm_start2 - 1];
		[cmboHour setSelectIndex:siteDoc.m_das.sens[m_sensid].pulse.tm_start3];
		[cmboMin setSelectIndex:siteDoc.m_das.sens[m_sensid].pulse.tm_start4];
		labDay.text = @"日：";
		//m_tm_mon=m_das->sens[m_sensid].pulse.tm_start1-1;
		//m_tm_date=m_das->sens[m_sensid].pulse.tm_start2-1;
		//m_tm_hr=m_das->sens[m_sensid].pulse.tm_start3;
		//m_tm_min=m_das->sens[m_sensid].pulse.tm_start4;
		
		//m_static_date.LoadString(IDS_TMLABEL1);"日：
	}/*else{
	  m_interval=m_das->sens[m_sensid].pulse.tm_start1;
	  m_static_date.LoadString(IDS_TMLABEL1);
	  }
	  CTime t;
	  if(m_das->sens[m_sensid].pulse.time>=0)
	  t=m_das->sens[m_sensid].pulse.time;
	  else t=CTime::GetCurrentTime();
	  
	  m_date=t;
	  m_time=t;
	  */
	if(siteDoc.m_das.sens[m_sensid].pulse.amptype == 0){
		labUnit.text = @"(count)";
	}else
		labUnit.text = @"(uA)";
	
	[self EnableCtl:siteDoc.m_das.sens[m_sensid].pulse.method];
	//UpdateData(FALSE);
}



- (void) EnableCtl: (NSInteger)index 
{
	//int m_tm_method = [cmbMethod getSelectIndex];
	int m_tm_method = (int)index;
	if(m_tm_method==0)
	{
		[cmboMon setEnabled:FALSE];
		[cmboDay setEnabled:FALSE];
		[cmboHour setEnabled:TRUE];
		[cmboMin setEnabled:TRUE];
		/*
		m_combo_mon.EnableWindow(FALSE);
		m_combo_date.EnableWindow(FALSE);
		m_combo_hr.EnableWindow(TRUE);
		m_combo_min.EnableWindow(TRUE);
		*/
		
	}else if(m_tm_method==1 || m_tm_method==2){
		
		[cmboMon setEnabled:FALSE];
		[cmboDay setEnabled:TRUE];
		[cmboHour setEnabled:TRUE];
		[cmboMin setEnabled:TRUE];
		/*
		m_combo_mon.EnableWindow(FALSE);
		m_combo_date.EnableWindow(TRUE);
		m_combo_hr.EnableWindow(TRUE);
		m_combo_min.EnableWindow(TRUE);
		 */
		//		m_edit_interval.EnableWindow(FALSE);
	}else if(m_tm_method==3)
	{
		[cmboMon setEnabled:TRUE];
		[cmboDay setEnabled:TRUE];
		[cmboHour setEnabled:TRUE];
		[cmboMin setEnabled:TRUE];
		/*
		m_combo_mon.EnableWindow(TRUE);
		m_combo_date.EnableWindow(TRUE);
		m_combo_hr.EnableWindow(TRUE);
		m_combo_min.EnableWindow(TRUE);
		 */
		//		m_edit_interval.EnableWindow(FALSE);
	}else if(m_tm_method==4){
		[cmboMon setEnabled:FALSE];
		[cmboDay setEnabled:FALSE];
		[cmboHour setEnabled:FALSE];
		[cmboMin setEnabled:FALSE];
		/*
		m_combo_mon.EnableWindow(FALSE);
		m_combo_date.EnableWindow(FALSE);
		m_combo_hr.EnableWindow(FALSE);
		m_combo_min.EnableWindow(FALSE);
		 */
		//		m_edit_interval.EnableWindow(TRUE);
	}
	
	//m_combo_date.ResetContent();
	if(m_tm_method==1){
		NSArray *cmboDay1 = [[NSArray alloc] initWithObjects: @"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期日",nil];
		[cmboDay setItems:cmboDay1];
	}else {
		NSMutableArray *cmboDay2 = [NSMutableArray array];
		char temp[1024];
		for(int i=1;i<=31;i++)
		{
			sprintf(temp,"  %d  ",  i);
			[cmboDay2 addObject:[[NSString alloc] initWithUTF8String:temp]];
		}
		
		[cmboDay setItems:cmboDay2];
	}
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	[self initUI];
	[cmboSens setSelectIndex:0];
	[self initUI1:0];
	 
	
	
}

- (void)viewDidLoad
{
	self.title = @"设置脉冲标定";
	
	int xW = 270;
	int yH = 80;
	
	//-------------------------------------------- 
	UILabel *labSens = [[UILabel alloc] initWithFrame : CGRectMake ( 50+xW , 30+yH , 180 , 30 )];
	labSens.text = @"选择地震计：";
	[scrollView addSubview:labSens];[labSens release];
	

	cmboSens= [[ UIComboBox alloc ] initWithFrame : CGRectMake ( 165+xW , 30+yH , 200 , 28 )];
	cmboSens.dropMaxHeigth  = 32*4;
	cmboSens.delegate = self;
	NSMutableArray *comboSensData = [NSMutableArray array];
	int i = 0;
	char temp[100];
	for(i=0;i<siteDoc.m_das.stnpar.sens_num;i++)
	{
		sprintf(temp,"地震计 %c",  sens_id[i]);
		[comboSensData addObject:[[NSString alloc] initWithUTF8String:temp]];
	}
	
	if(siteDoc.m_das.stnpar.sens_num != 0) {
		[cmboSens setItems:comboSensData];
		//[comboSensData release];
	}
	[scrollView addSubview :cmboSens];
	[cmboSens release];
	
	//-------------------------------------------- 
	ckBTimer = [[ UICheckButton alloc ] initWithFrame : CGRectMake ( 50+xW , 65+yH , 200 , 30 )];
	ckBTimer.label.text = @"定时标定" ;
	ckBTimer.value =[[ NSNumber alloc ] initWithInt:0 ];
	ckBTimer.style = CheckButtonStyleBox ;
	[scrollView addSubview :ckBTimer];
	[ckBTimer release];
	
	
	//-------------------------------------------- 
	UILabel *labMothed = [[UILabel alloc] initWithFrame : CGRectMake ( 50+xW , 100 +yH, 180 , 30 )];
	labMothed.text = @"定时方式：";
	[scrollView addSubview:labMothed];[labMothed release];

	cmbMethod= [[ UIComboBox alloc ] initWithFrame : CGRectMake ( 165+xW , 100+yH , 200 , 28 )];
	cmbMethod.dropMaxHeigth  = 32*4;
	cmbMethod.delegate = self;
	
	NSArray *cmbMethodData = [[NSArray alloc] initWithObjects:@"每日",@"每星期",@"每月", @"每年",nil];
	
	[cmbMethod setItems:cmbMethodData];
	[scrollView addSubview :cmbMethod];
	[cmbMethod release];
	[cmbMethodData release];
	
	
	//-------------------------------------------- 
	UILabel *labMon = [[UILabel alloc] initWithFrame : CGRectMake ( 50+xW , 135+yH , 180 , 30 )];
	labMon.text = @"月：";
	[scrollView addSubview:labMon];[labMon release];
	
	
	cmboMon= [[ UIComboBox alloc ] initWithFrame : CGRectMake ( 165+xW , 135+yH , 200 , 28 )];
	cmboMon.dropMaxHeigth  = 32*4;
	cmboMon.delegate = self;
	NSMutableArray *comboMonData = [NSMutableArray array];

	for(i=1;i<=12;i++)
	{
		sprintf(temp,"  %d  ",  i);
		[comboMonData addObject:[[NSString alloc] initWithUTF8String:temp]];
	}
	[cmboMon setItems:comboMonData];
	[scrollView addSubview :cmboMon];
	[cmboMon release];
	
	//-------------------------------------------- 
	labDay = [[UILabel alloc] initWithFrame : CGRectMake ( 50+xW , 170+yH , 180 , 30 )];
	labDay.text = @"日：";
	[scrollView addSubview:labDay];[labDay release];
	
	
	cmboDay= [[ UIComboBox alloc ] initWithFrame : CGRectMake ( 165+xW , 170+yH , 200 , 28 )];
	cmboDay.dropMaxHeigth  = 32*4;
	cmboDay.delegate = self;
	NSMutableArray *comboDayData = [NSMutableArray array];
	
	for(i=1;i<=31;i++)
	{
		sprintf(temp,"  %d  ",  i);
		[comboDayData addObject:[[NSString alloc] initWithUTF8String:temp]];
	}
	
	[cmboDay setItems:comboDayData];
	[scrollView addSubview :cmboDay];
	[cmboDay release];
	
	
	//----------------------------------------------------------------------------  
	UILabel *labHour = [[UILabel alloc] initWithFrame : CGRectMake ( 50+xW , 205+yH , 180 , 30 )];
	labHour.text = @"时：";
	[scrollView addSubview:labHour];[labHour release];
	
	
	cmboHour = [[ UIComboBox alloc ] initWithFrame : CGRectMake ( 165+xW , 205+yH , 200 , 28 )];
	cmboHour.dropMaxHeigth  = 32*4;
	cmboHour.delegate = self;
	NSMutableArray *comboHourData = [NSMutableArray array];
	
	for(i=0;i<=23;i++)
	{
		sprintf(temp,"  %d  ",  i);
		[comboHourData addObject:[[NSString alloc] initWithUTF8String:temp]];
	}
	
	[cmboHour setItems:comboHourData];
	[scrollView addSubview :cmboHour];
	[cmboHour release];
	
	//----------------------------------------------------------------------------  
	UILabel *labMin = [[UILabel alloc] initWithFrame : CGRectMake ( 50 +xW, 240+yH , 180 , 30 )];
	labMin.text = @"分：";
	[scrollView addSubview:labMin];[labMin release];
	
	
	cmboMin = [[ UIComboBox alloc ] initWithFrame : CGRectMake ( 165+xW , 240+yH , 200 , 28 )];
	cmboMin.dropMaxHeigth  = 32*4;
	cmboMin.delegate = self;
	NSMutableArray *comboMinData = [NSMutableArray array];
	
	for(i=0;i<=59;i++)
	{
		sprintf(temp,"  %d  ",  i);
		[comboMinData addObject:[[NSString alloc] initWithUTF8String:temp]];
	}
	
	[cmboMin setItems:comboMinData];
	[scrollView addSubview :cmboMin];
	[cmboMin release];
	
	
	//-------------------------------------------- 
	UILabel *labAmpType = [[UILabel alloc] initWithFrame : CGRectMake ( 50+xW , 275+yH , 180 , 30 )];
	labAmpType.text = @"幅度类型：";
	[scrollView addSubview:labAmpType];[labAmpType release];
	
	cmboAmpType= [[ UIComboBox alloc ] initWithFrame : CGRectMake ( 165+xW , 275+yH , 200 , 28 )];
	//cmboAmpType.dropMaxHeigth  = 32*4;
	cmboAmpType.delegate = self;
	
	NSArray *cmbAmpTypeData = [[NSArray alloc] initWithObjects:@"Count值",@"电流值(uA)",nil];
	
	[cmboAmpType setItems:cmbAmpTypeData];
	[scrollView addSubview :cmboAmpType];
	[cmboAmpType release];
	[cmbAmpTypeData release];
	
	//-------------------------------------------- 
	UILabel *labAmp = [[UILabel alloc] initWithFrame : CGRectMake ( 50+xW , 310+yH , 180 , 30 )];
	labAmp.text = @"脉冲幅度：";
	[scrollView addSubview:labAmp];[labAmp release];
	
	txtAmp = [[UITextField alloc] initWithFrame:CGRectMake(165+xW, 310+yH, 200, 30)];
	txtAmp.borderStyle =  UITextBorderStyleRoundedRect;
	txtAmp.delegate =self;
	[scrollView addSubview:txtAmp];
	
	labUnit = [[UILabel alloc] initWithFrame : CGRectMake ( 365+xW , 310+yH , 80 , 30 )];
	labUnit.text = @"(count)";
	[scrollView addSubview:labUnit];[labUnit release];
	
	//-------------------------------------------- 
	UILabel *labDur = [[UILabel alloc] initWithFrame : CGRectMake ( 50+xW , 345+yH , 180 , 30 )];
	labDur.text = @"脉冲宽度：";
	[scrollView addSubview:labDur];[labDur release];
	
	txtDur = [[UITextField alloc] initWithFrame:CGRectMake(165+xW, 345+yH, 200, 30)];
	txtDur.borderStyle =  UITextBorderStyleRoundedRect;
	txtDur.delegate =self;
	[scrollView addSubview:txtDur];
	
	
	
}	


- (void)comboBox: (UIComboBox *)comboBox selectItemAtIndex: (NSInteger)index {
	if(comboBox == cmboSens){
		[self initUI1:index];
	}else if(comboBox == cmboAmpType){
		
		if(index== 0){
			labUnit.text = @"(count)";
		}else
		{labUnit.text = @"(uA)";}
		
	}else if(comboBox == cmbMethod){
		
		if(index==1){
			labDay.text = @"星期:";
		}else{
			labDay.text = @"日:";
		}
		[self EnableCtl:index];
		
	}
	
}




- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{	
	if(textField == txtAmp) {
		NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERSINT] invertedSet];
		NSString *filter = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
		BOOL basiTest = [string	isEqualToString:filter];
		if(!basiTest){
			UIAlertView *av = [[[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入数字" 
														 delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
			[av show];
			return NO;
		}else{
			return YES;
		}
		
		
	}else if(textField == txtDur) {
		NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUMBERSFLOAT] invertedSet];
		NSString *filter = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
		BOOL basiTest = [string	isEqualToString:filter];
		if(!basiTest){
			UIAlertView *av = [[[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入数字" 
														 delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
			[av show];
			return NO;
		}else{
			return YES;
		}
		
		
	}
	 
	return YES;
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	/*
	if(textField == txtComp){
		if([self CheckRangeFrom:textField.text Min:1 Max:3] == NO){
			return NO;
		}
	}
	*/
	
	[textField resignFirstResponder];
	return YES;
}


- (IBAction)btnOKClick:(id)sender {
	
	int m_tm_method = (int)[cmbMethod getSelectIndex];
	int m_tm_mon =(int)[cmboMon getSelectIndex];
	int m_tm_date =(int)[cmboDay getSelectIndex];
	int m_tm_hr = (int)[cmboHour getSelectIndex];
	int m_tm_min = (int)[cmboMin	getSelectIndex];
	short m_sensid = (short) [cmboSens getSelectIndex];
	short m_btimer = [ckBTimer isChecked];
	short m_type = [cmboAmpType getSelectIndex];
	short m_amp = (short)[txtAmp.text intValue];
	float m_dur = [txtDur.text floatValue];
					 
	long t=theApp.CalcStarttime(m_tm_method,m_tm_mon+1,m_tm_date+1,m_tm_hr,m_tm_min);
    
    CM_PULSEFRM frm;
    
	char m_cmd[sizeof(frm)+4];
	int m_cmd_len = sizeof(m_cmd);
	
	m_cmd[0]=0xbf;
	m_cmd[1]=0x13;
	m_cmd[2]=0x97;
	m_cmd[3]=0x74;
	
	memset(&frm,0,sizeof(frm));
    
	frm.head.cmd=0x6020;
	frm.head.sens_id=m_sensid;
	frm.head.length=26;//26
	
	frm.btimer=m_btimer;
	frm.amp=m_amp;
	frm.amptype=m_type;
	frm.dur=(unsigned short)(m_dur*10.0);
	frm.time=(unsigned int)t;
	frm.method=m_tm_method;
	
	
	if(m_tm_method==0)
	{
		frm.tm_start1=m_tm_hr;
		frm.tm_start2=m_tm_min;
		frm.tm_start3=frm.tm_start4=0;
	}else if(m_tm_method==1 || m_tm_method==2)
	{
		frm.tm_start1=m_tm_date+1;
		frm.tm_start2=m_tm_hr;
		frm.tm_start3=m_tm_min;
		frm.tm_start4=0;
	}else if(m_tm_method==3){
		frm.tm_start1=m_tm_mon+1;
		frm.tm_start2=m_tm_date+1;
		frm.tm_start3=m_tm_hr;
		frm.tm_start4=m_tm_min;
	}//else frm.tm_start1=m_interval;
	
	
	
	
	short *p=(short *)&frm;
	frm.chk_sum=0;
	
    for(int i=0;i<sizeof(frm)/2-2;i++){
        frm.chk_sum-=p[i];
    }
    
	frm.chk_sum-=frm.dur;
	
	memcpy(&m_cmd[4],(char *)&frm,sizeof(frm));
	
	if(!siteDoc.m_thd->Send(m_cmd,m_cmd_len))
	{	//SendErr();
		UIAlertView *av = [[[UIAlertView alloc] initWithTitle:@"错误" message:@"网路连接失败" 
													 delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
		[av show];	
	}else {
		UIAlertView *av = [[[UIAlertView alloc] initWithTitle:@"信息" message:@"设置脉冲标定成功" 
													 delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
		[av show];	
	}
	
    
}

- (IBAction)btnCancelClick:(id)sender {
	[self.navigationController popViewControllerAnimated:YES];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscapeLeft;
}
@end
