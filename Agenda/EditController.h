//
//  EditController.h
//  Agenda
//
//  Created by Chiunti on 03/02/15.
//  Copyright (c) 2015 Chiunti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>


// tableviews
@property (strong, nonatomic) IBOutlet UITableView *tblEdit;


//Navigators
@property (strong, nonatomic) IBOutlet UINavigationItem *navEdit;


@end
