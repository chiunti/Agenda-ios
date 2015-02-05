//
//  CustomizedTableViewCell.h
//  Agenda
//
//  Created by Chiunti on 03/02/15.
//  Copyright (c) 2015 Chiunti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomizedTableViewCell : UITableViewCell
// labels
@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblStatus;
// Images
@property (strong, nonatomic) IBOutlet UIImageView *imgPhoto;

@end
