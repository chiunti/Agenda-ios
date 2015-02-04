//
//  Defaults.h
//  Agenda
//
//  Created by Chiunti on 04/02/15.
//  Copyright (c) 2015 Chiunti. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{Insert,Delete,Edit,Show,Idle} agendaState;
agendaState currentState;

@interface Defaults : NSObject

@end
