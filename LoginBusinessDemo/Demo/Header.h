
//
//  Header.h
//  Demo
//
//  Created by LiuTao on 16/7/3.
//  Copyright © 2016年 ZhiYou. All rights reserved.
//

#ifndef Header_h
#define Header_h


// list <loginid,passwd,autologin>
#define LOGIN_USERS         @"KJASDKLFJH"
#define LOGIN_LAST_USERS    @"AOIUFSLJLQ"

#define CITY_SELECTED       @"A98HFSLJLQ"


#define LOGIN_USER_CREATE(loginid,passwd)       @{@"loginid":loginid,@"passwd":passwd,@"autologin":@"1"}


#define U_GET_OBJ(key)      [[NSUserDefaults standardUserDefaults] objectForKey:key]
#define U_SET_OBJ(key,obj)  [[NSUserDefaults standardUserDefaults] setObject:obj forKey:key]


#endif /* Header_h */
