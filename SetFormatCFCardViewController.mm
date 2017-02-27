//
//  SetFormatCFCardViewController.m
//  EDAS_GN_SMS
//
//  Created by 莫浩天 on 2017/1/18.
//
//

#import "SetFormatCFCardViewController.h"

@interface SetFormatCFCardViewController ()

@end

@implementation SetFormatCFCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)dealloc {
    [_btnCancel release];
    [_btnOK release];
    [_btnOK release];
    [_btnCancel release];
    [super dealloc];
}
- (IBAction)btnCancelClick:(id)sender {
     [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btnOKClick:(id)sender {
    char buf[20];
    short *p=(short *)buf;
    
    buf[0]=0xbf;
    buf[1]=0x13;
    buf[2]=0x97;
    buf[3]=0x74;
    
    p[2]=0;
    p[3]=0x6080;
    p[4]=4;
    p[5]=0;
    p[6]=0;
    for(int i=2;i<6;i++){
        p[6]-=p[i];
    }
    
    if(siteDoc.m_thd->Send(buf,14))
    {
        UIAlertView *av = [[[UIAlertView alloc] initWithTitle:@"提示" message:@"格式化CF卡成功"
                                                     delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
        [av show];
    }else {
        UIAlertView *av = [[[UIAlertView alloc] initWithTitle:@"错误" message:@"网络连接错误"
                                                     delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
        [av show];
    }
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeLeft;
}


@end
