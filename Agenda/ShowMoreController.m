//
//  ShowMoreController.m
//  Agenda
//
//  Created by Chiunti on 03/02/15.
//  Copyright (c) 2015 Chiunti. All rights reserved.
//

#import "ShowMoreController.h"
#import "Defaults.h"

@implementation ShowMoreController

-(void)viewDidLoad{

    NSURL *url = [NSURL URLWithString:currentRecord[RECORD_SONG]];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.wvwVideo loadRequest:requestObj];
    self.lblNombre.text = currentRecord[RECORD_NAME];
    self.lblStatus.text = currentRecord[RECORD_STATUS];
    self.imgPhoto.image = currentRecord[RECORD_IMAGE];
}
@end
