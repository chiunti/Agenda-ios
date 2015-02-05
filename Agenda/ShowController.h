//
//  ShowController.h
//  Agenda
//
//  Created by Chiunti on 03/02/15.
//  Copyright (c) 2015 Chiunti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowController : UIViewController<UITableViewDataSource,UITableViewDelegate>
// tableViews
@property (strong, nonatomic) IBOutlet UITableView *tblShow;
// Buttons
@property (strong, nonatomic) IBOutlet UIButton *btnShare;
@property (strong, nonatomic) IBOutlet UIButton *btnMore;
// Actions
- (IBAction)btnSharePressed:(id)sender;
- (IBAction)btnMorePressed:(id)sender;


@end
