//
//  Shortcut.m
//  Text Shortcuts
//
//  Created by Ken Szubzda on 4/19/12.
//  Copyright (c) 2012 University of California, Berkeley. All rights reserved.
//

#import "Shortcut.h"

@implementation Shortcut
@synthesize nickname = _nickname;
@synthesize phoneNum = _phoneNum;
@synthesize message = _message;

- (id) initWithNickName:(NSString *)nickname number:(NSString *)number message:(NSString *)message {
    self = [super init];
    if (self) {
        _nickname = nickname;
        _phoneNum = number;
        _message = message;
        return self;
    }
    return nil;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject: [self nickname] forKey: @"nickname"];
    [coder encodeObject: [self phoneNum] forKey: @"phoneNum"];
    [coder encodeObject: [self message] forKey: @"message"];
}

- (id)initWithCoder: (NSCoder *)coder
{
    NSString *nickname = [coder decodeObjectForKey: @"nickname"];
    NSString *phoneNum = [coder decodeObjectForKey: @"phoneNum"];
    NSString *message = [coder decodeObjectForKey: @"message"];
    return [self initWithNickName:nickname number:phoneNum message:message];
}


@end
