//
//  WDCarOwnerDiagnoseDetailViewController.m
//  WeiDeCar
//
//  Created by EEKA on 2018/6/30.
//  Copyright © 2018年 mafanghua. All rights reserved.
//

#import "WDCarOwnerDiagnoseDetailViewController.h"
#import "WDDiagnoseDetailHeaderView.h"
#import "WDDiagnoseDetailResultView.h"

@interface WDCarOwnerDiagnoseDetailViewController () <UITableViewDataSource,UITableViewDelegate>
{
    MFUITableView *m_tableView;
    
    NSMutableArray<WDDiagnoseItemFaultAppearanceModel *> *m_faultAppearances;
}

@end

@implementation WDCarOwnerDiagnoseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"诊断详情";
    [self setBackBarButton];
    
    self.view.backgroundColor = [UIColor hx_colorWithHexString:@"f5f5f5"];
    
    WDLoginService *loginService = [[MMServiceCenter defaultCenter] getService:[WDLoginService class]];
    m_currentUserInfo = loginService.currentUserInfo;
    
    m_faultAppearances = self.diagnoseModel.diagnoseItems.faultAppearances;
    
    [self initTableView];
    
    [self reloadTableView];
}

-(void)initTableView
{
    m_tableView = [[MFUITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    m_tableView.backgroundColor = [UIColor hx_colorWithHexString:@"f5f5f5"];
    m_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    m_tableView.dataSource = self;
    m_tableView.delegate = self;
    [self.view addSubview:m_tableView];
    
    [m_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.width.equalTo(self.view.mas_width);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return m_cellInfos.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    
    if ([identifier isEqualToString:@"detailHeader"])
    {
        return [self tableView:tableView detailHeaderForIndexPath:indexPath];
    }
    else if ([identifier isEqualToString:@"detailResult"])
    {
        return [self tableView:tableView diagnoseDetailResultViewCellForIndexPath:indexPath];
    }
//    else if ([identifier isEqualToString:@"faultAppearance"])
//    {
//        return [self tableView:tableView faultAppearanceCellForIndexPath:indexPath];
//    }
//    else if ([identifier isEqualToString:@"expertAdvices"])
//    {
//        return [self tableView:tableView expertDiagnoseAdviceCellForIndexPath:indexPath];
//    }
    else if ([identifier isEqualToString:@"division"])
    {
        return [self tableView:tableView divisionForIndexPath:indexPath];
    }
    else if ([identifier isEqualToString:@"separator"])
    {
        return [self tableView:tableView separatorCellForIndexPath:indexPath];
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.separatorInset = UIEdgeInsetsZero;
    }
    
    cell.textLabel.text = identifier;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    return cellInfo.cellHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView detailHeaderForIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        WDDiagnoseDetailHeaderView *cellView = [[WDDiagnoseDetailHeaderView alloc] initWithFrame:cell.contentView.bounds];
        cell.m_subContentView = cellView;
    }
    
    return cell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView diagnoseDetailResultViewCellForIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        WDDiagnoseDetailResultView *cellView = [[WDDiagnoseDetailResultView alloc] initWithFrame:cell.contentView.bounds];
        cell.m_subContentView = cellView;
    }
    
    NSInteger attachIndex = cellInfo.attachIndex;
    WDDiagnoseItemFaultAppearanceModel *appearanceModel = m_faultAppearances[attachIndex];
    
    WDDiagnoseDetailResultView *cellView = (WDDiagnoseDetailResultView *)cell.m_subContentView;
    [cellView setDiagnoseModel:self.diagnoseModel appearanceModel:appearanceModel];
    
    return cell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView divisionForIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.contentView.backgroundColor = [UIColor hx_colorWithHexString:@"f5f5f5"];
    return cell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView separatorCellForIndexPath:(NSIndexPath *)indexPath
{
    MFTableViewCellObject *cellInfo = m_cellInfos[indexPath.row];
    NSString *identifier = cellInfo.cellReuseIdentifier;
    
    MFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MFTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
        UIView *separator = [UIView new];
        separator.frame = CGRectMake(0, 0, CGRectGetWidth(cell.contentView.frame), MFOnePixHeight);
        separator.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        separator.backgroundColor = MFCustomLineColor;
        [cell.contentView addSubview:separator];
    }
    return cell;
}

-(void)reloadTableView
{
    [self makeCellObjects];
    [m_tableView reloadData];
}

-(void)makeCellObjects
{
    [m_cellInfos removeAllObjects];
    
    for (int i = 0; i < m_faultAppearances.count; i++) {
        
        WDDiagnoseItemFaultAppearanceModel *appearanceModel  = m_faultAppearances[i];
        
        MFTableViewCellObject *division = [MFTableViewCellObject new];
        division.cellHeight = 15.0f;
        division.cellReuseIdentifier = @"division";
        [m_cellInfos addObject:division];
        
        MFTableViewCellObject *detailHeader = [MFTableViewCellObject new];
        detailHeader.cellHeight = 70.0f;
        detailHeader.cellReuseIdentifier = @"detailHeader";
        [m_cellInfos addObject:detailHeader];
        
        CGFloat detailResultCellHeight = appearanceModel.causeJudgements.count * 50.0f;
        
        MFTableViewCellObject *detailResult = [MFTableViewCellObject new];
        detailResult.cellHeight = detailResultCellHeight;
        detailResult.cellReuseIdentifier = @"detailResult";
        detailResult.attachIndex = i;
        [m_cellInfos addObject:detailResult];
        
        MFTableViewCellObject *detailResultFooter = [MFTableViewCellObject new];
        detailResultFooter.cellHeight = 70.0f;
        detailResultFooter.cellReuseIdentifier = @"detailResultFooter";
        detailResultFooter.attachIndex = i;
        [m_cellInfos addObject:detailResultFooter];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
