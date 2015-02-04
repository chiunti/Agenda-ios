//
//  ShowMoreController.m
//  Agenda
//
//  Created by Chiunti on 03/02/15.
//  Copyright (c) 2015 Chiunti. All rights reserved.
//

#import "ShowMoreController.h"

@implementation ShowMoreController

-(void)viewDidLoad{
    NSURL *url = [NSURL URLWithString:@"https://www.youtube.com/embed/1MwjX4dG72s"];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.wvwVideo loadRequest:requestObj];
}
@end
