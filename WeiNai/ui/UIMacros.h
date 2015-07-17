//
//  UIMacros.h
//  WeiNai
//
//  Created by Ji Fang on 7/15/15.
//  Copyright (c) 2015 Ji Fang. All rights reserved.
//

#ifndef WeiNai_UIMacros_h
#define WeiNai_UIMacros_h

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

typedef enum _EMActivityType {
    ActivityType_Milk = 0,
    ActivityType_Piss,
    ActivityType_Excrement,
    ActivityType_Sleep,
    ActivityType_NumberOfActivityTypes
}EMActivityType;

typedef enum _EMMilkType {
    MilkType_BreastMilk = 0,
    MilkType_PowderMilk
}EMMilkType;

#endif
