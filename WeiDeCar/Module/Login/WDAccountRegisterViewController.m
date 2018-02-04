//
//  WDAccountRegisterViewController.m
//  WeiDeCar
//
//  Created by mafanghua on 2018/2/4.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDAccountRegisterViewController.h"
#import "MMBaseTextFieldItem.h"

@interface WDAccountRegisterViewController () <MMTableViewInfoDelegate, MMBaseInfoItemDelegate>
{
    MMTableViewInfo *m_tableViewInfo;
    
    MMBaseTextFieldItem *m_textFieldCarModelItem;
    MMBaseTextFieldItem *m_textFieldVinNoItem;
    MMBaseTextFieldItem *m_textFieldTelephoneItem;
    MMBaseTextFieldItem *m_textFieldPasswdItem;
    
    NSMutableArray *m_arrayInfo;
}

@end

@implementation WDAccountRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
