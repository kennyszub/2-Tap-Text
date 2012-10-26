//
//  Shortcut.h
//  Text Shortcuts
//
//  Created by Ken Szubzda on 4/19/12.
//  Copyright (c) 2012 University of California, Berkeley. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Shortcut : NSObject <NSCoding>

@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *phoneNum;
@property (nonatomic, copy) NSString *message;

-(id)initWithNickName:(NSString *)nickname 
               number:(NSString *)number  
              message:(NSString *) message;


@end
