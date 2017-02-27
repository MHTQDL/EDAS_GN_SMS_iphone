//
//  SetNetworkTimeServerViewController.m
//  EDAS_GN_SMS
//
//  Created by 莫浩天 on 2017/1/10.
//
//

#import "SetNetworkTimeServerViewController.h"
#include "GlobalData.h"
@interface SetNetworkTimeServerViewController ()

@end

@implementation SetNetworkTimeServerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.title = @"设置网络授时服务器";
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    _host1.text = [[NSString alloc] initWithUTF8String:siteDoc.m_das.das.ntpsrvfrm.host1];
    _host2.text = [[NSString alloc] initWithUTF8String:siteDoc.m_das.das.ntpsrvfrm.host2];
    _host3.text = [[NSString alloc] initWithUTF8String:siteDoc.m_das.das.ntpsrvfrm.host3];
}

-(BOOL) isValidator {
    //校验
    
    return TRUE;
}



- (IBAction)btnOKClick:(id)sender {
    
    //未做效验
    if(![self isValidator]){return;}
    
//    char m_cmd[74];
//    int m_cmd_len = 0;
//    CM_NTPSRVFRM frm;
//    
//    memset(&frm,0,sizeof(CM_NTPSRVFRM));
//    m_cmd[0]=0xbf;
//    m_cmd[1]=0x13;
//    m_cmd[2]=0x97;
//    m_cmd[3]=0x74;
//    
//    sprintf(frm.host1,"%s",[_host1.text UTF8String]);
//    sprintf(frm.host2,"%s",[_host2.text UTF8String]);
//    sprintf(frm.host3,"%s",[_host3.text UTF8String]);
//    frm.head.cmd=0x607c;
//    frm.head.sens_id=0;
//    frm.head.length=64;
//    frm.head.reserved=0;
//    frm.chk_sum=0;
//    
//    short * p1=(short *)&frm;
//    for(int i=0;i<(frm.head.length+6)/2-1;i++)
//        frm.chk_sum-=p1[i];
//    
//    memcpy(&m_cmd[4],(char *)&frm,frm.head.length+6);
//    m_cmd_len=frm.head.length+10;
//    
//    NSLog(@"cmd=%d",m_cmd[4]);
//    NSLog(@"cmd_len=%d",m_cmd_len);
    
    /*
     数据项          数据类型  数据长度        数据含义
     SYNC           Char[4]     4           同步字,为0xbf139774
     SENSOR_ID      short       2           地震计序号，从0开始
     CMD            short       2           帧标志
     LENGTH         short       2           从DATA开始的帧长度，单位:字节
     UNUSED         Short       2           保留
     DATA           CharArray   LENGTH-2    数据部分
     CHK_SUM        short       2           (从SENSOR_ID到DATA结束的数据之和) *-1
     */
    
    CM_NTPSRVFRM frm;//70字节
    
    
    
    char m_cmd[sizeof(CM_NTPSRVFRM)+4];//74字节
    
    int m_cmd_len =sizeof(m_cmd);
    
    
    
    
    /*
     void *memset(void *s, int ch, size_t n);
     函数解释：将s中当前位置后面的n个字节 （typedef unsigned int size_t ）用 ch 替换并返回 s 。
     memset：作用是在一段内存块中填充某个给定的值，它是对较大的结构体或数组进行清零操作的一种最快方法
     */
    memset(&frm,0,sizeof(CM_NTPSRVFRM));
    
    //m_cmd设置为74字节的用意在这里  frm字节+4字节
    m_cmd[0]=0xbf;
    m_cmd[1]=0x13;
    m_cmd[2]=0x97;
    m_cmd[3]=0x74;
    
    frm.head.sens_id=0;//地震计号
    frm.head.cmd=0x607c;//帧标记
    frm.head.length=sizeof(CM_NTPSRVFRM)-6;//64
    frm.head.reserved=0;//保留
    
    sprintf(frm.host1,"%s",[_host1.text UTF8String]);
    sprintf(frm.host2,"%s",[_host2.text UTF8String]);
    sprintf(frm.host3,"%s",[_host3.text UTF8String]);
    
    frm.chk_sum=0;//校验和
    
    short * p1=(short *)&frm;
    
    
    //70/2-1=34
    for(int i=0;i<sizeof(CM_NTPSRVFRM)/2-1;i++){
        frm.chk_sum-=p1[i];
    }
    
    
    memcpy(&m_cmd[4],(char *)&frm,sizeof(CM_NTPSRVFRM));
    
    if(siteDoc.m_thd->Send(m_cmd,m_cmd_len))
    {
        UIAlertView *av = [[[UIAlertView alloc] initWithTitle:@"信息" message:@"网络授时服务器设置成功"
                                                     delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
        [av show];
    }else {
        UIAlertView *av = [[[UIAlertView alloc] initWithTitle:@"错误" message:@"网路连接失败"
                                                     delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
        [av show];
    }
    
}

- (IBAction)btnCancelClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc {
    [_btnOK release];
    [_btnCancel release];
    [_host1 release];
    [_host2 release];
    [_host3 release];
    [super dealloc];
}
@end
