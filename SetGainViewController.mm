//
//  SetGainViewController.m
//  量程
//  Created by guan mofeng on 12-3-12.
//  Copyright 2012 北京. All rights reserved.
//

#import "SetGainViewController.h"
#include "GlobalData.h"

extern char sens_id[];
@implementation SetGainViewController


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
		[comboSens setItems:comboSensData];
		//[comboSensData release];
	}
	
}
- (void) initUI1 :(NSInteger) index {
	
	//int m_sensid = [comboSens getSelectIndex];
	int m_sensid = index;
	short m_gain = siteDoc.m_das.sens[m_sensid].gain_id;
	
    if(m_gain==0){
		[radioGroup checkButtonClicked:radioV10];
    }else if(m_gain==1){
		[radioGroup checkButtonClicked:radioV20];
    }else if(m_gain==2){
		[radioGroup checkButtonClicked:radioV5];
    }else if(m_gain==3){
		[radioGroup checkButtonClicked:radioV2_5];
    }else{
		[radioGroup checkButtonClicked:radioV10];
    }
}
- (void)comboBox: (UIComboBox *)comboBox selectItemAtIndex: (NSInteger)index {
	if(comboBox == comboSens){
		[self initUI1:index];
	}
}


- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	[self initUI];
	[comboSens setSelectIndex:0];
	[self initUI1:0];
}
- (void)viewDidLoad
{
	//siteDoc.m_sitelst.at(selIndex);
	//siteDoc.GetDASInfo();
	//if(siteDoc.m_das == NULL){ return;}
	//txtNo.delegate = self;
	//txtNetid.
	//TRACE("txtNo.delegate = self;\n");
	
    int w=self.view.frame.size.width;
    int y=self.view.frame.size.height;
    
    NSLog(@"xW:%f",self.view.frame.size.width/2);
    NSLog(@"xW:%f",self.view.frame.size.height/2);
    int xW = (w/2)-(w/2*0.25)-40;//-(w*0.25);//110;
    int yH = (y/2)-(y/2*0.25)-40;//-(y*0.25);//50;
	
	radioGroup =[[ RadioGroup alloc ] init ];
	
	radioV2_5 =[[ UICheckButton alloc ] initWithFrame : CGRectMake ( 35+xW , 80+yH , 200 , 32 )];
	radioV2_5.label.text = @"2.5 伏" ;
	radioV2_5.value =[[ NSNumber alloc ] initWithInt:3 ];	
	radioV2_5.style = CheckButtonStyleRadio ;
	[radioGroup add :radioV2_5];
	[ self.view addSubview :radioV2_5];
	[radioV2_5 release];
	
	radioV5 =[[ UICheckButton alloc ] initWithFrame : CGRectMake ( 200+xW , 80+yH , 200 , 32 )];
	radioV5.label.text = @"5 伏" ;
	radioV5.value =[[ NSNumber alloc ] initWithInt:2 ];	
	radioV5.style = CheckButtonStyleRadio ;
	[radioGroup add :radioV5];
	[ self.view addSubview :radioV5];
	[radioV5 release];
	
	radioV10 =[[ UICheckButton alloc ] initWithFrame : CGRectMake ( 35+xW , 120+yH , 200 , 32 )];
	radioV10.label.text = @"10 伏" ;
	radioV10.value =[[ NSNumber alloc ] initWithInt:0 ];	
	radioV10.style = CheckButtonStyleRadio ;
	
	[radioGroup add :radioV10];
	[ self.view addSubview :radioV10];
	[radioV10 release];
	
	radioV20 =[[ UICheckButton alloc ] initWithFrame : CGRectMake ( 200+xW , 120+yH , 200 , 32 )];
	radioV20.label.text = @"20 伏" ;
	radioV20.value =[[ NSNumber alloc ] initWithInt:1 ];
	radioV20.style = CheckButtonStyleRadio ;
	[radioGroup add :radioV20];
	[ self.view addSubview :radioV20];
	[radioV20 release];
	
    
    
	comboSens= [[ UIComboBox alloc ] initWithFrame : CGRectMake ( 130+xW , 34+yH , 170 , 30 )];
	comboSens.dropMaxHeigth  = 32*4;
	NSMutableArray *comboSensData = [NSMutableArray array];
	int i = 0;
	char temp[100];
	for(i=0;i<siteDoc.m_das.stnpar.sens_num;i++)
	{
		sprintf(temp,"地震计 %c",  sens_id[i]);
		[comboSensData addObject:[[NSString alloc] initWithUTF8String:temp]];
	}
	comboSens.delegate =self;
	
	if(siteDoc.m_das.stnpar.sens_num != 0) {
		[comboSens setItems:comboSensData];
		
	}
    //文字
    UILabel *lable=[[UILabel alloc] init];
    lable.frame=CGRectMake(comboSens.frame.origin.x-130,
                           comboSens.frame.origin.y, 130, 30);
    lable.text=@"地震计名称：";
    lable.textColor=[UIColor blackColor];
    [ self.view addSubview:lable];
	[ self.view addSubview :comboSens];
	[comboSens release];
	
	
	
	self.title = @"设置量程";
}

- (IBAction)onClickCancel:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)onClickOk:(id)sender {
    
    CM_GAINFRM frm;
    
	char m_cmd[sizeof(frm)+4];
    int m_cmd_len=sizeof(m_cmd);
    
	short gain = (short)[radioGroup.value intValue];
	
	if(comboSens.items == nil) {return;}
	short m_sensid = [comboSens getSelectIndex];
	
	m_cmd[0]=0xbf;
	m_cmd[1]=0x13;
	m_cmd[2]=0x97;
	m_cmd[3]=0x74;
    
    frm.head.sens_id=m_sensid;
    frm.head.cmd=0x6005;
    frm.head.length=6;//sizeof(frm)-8;
    frm.head.reserved=0;
    
    frm.gain_id=gain;
    frm.chk_sum=0;
    short * p=(short *)&frm;
    
    for(int i=0;i<sizeof(frm)/2-1;i++){
        frm.chk_sum-=p[i];
        printf("chk_sum:%d  ",frm.chk_sum);
    }
    memcpy(&m_cmd[4],(char *)&frm,sizeof(CM_GAINFRM));
    
    for(int i=0;i<sizeof(m_cmd);i++){
        printf("%d  ",m_cmd[i]);
    }
    
//	p[2]=m_sensid;
//	p[3]=0x6005;
//	p[4]=6;
//	p[5]=0;
//	p[6]=gain;
//	p[7]=0;
    
//    short * p=(short *)m_cmd;
//    for(int i=2;i<7;i++){
//        p[7]-=p[i];}
	
	
	
	if(!siteDoc.m_thd->Send(m_cmd,m_cmd_len))
	{
        UIAlertView *av = [[[UIAlertView alloc] initWithTitle:@"错误" message:@"网路连接失败"
													 delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
		[av show];	
	}else {
		UIAlertView *av = [[[UIAlertView alloc] initWithTitle:@"信息" message:@"系统量程设置成功" 
													 delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
		[av show];	
	}
		
}


- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscapeLeft;
}
- (void)dealloc {
    [super dealloc];
}
@end
