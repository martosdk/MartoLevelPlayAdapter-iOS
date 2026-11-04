
#import "ISMartoCustomAdapter.h"
#import <MartoSDK/CTADSDK.h>

@implementation ISMartoCustomAdapter

- (void)init:(ISAdData*)adData delegate:(id<ISNetworkInitializationDelegate>)delegate
{
    NSString *appid = adData.configuration[@"appid"];
    if(appid)
    {
        NSString *userID = adData.adUnitData[@"userId"];
        if(userID != nil)
        {
            [CTADSDK sharedInstance].userid = userID;
        }
        [CTADSDK sharedInstance].mediation = @"LevelPlay";
        [[CTADSDK sharedInstance] start:appid completion:^{
            [delegate onInitDidSucceed];
        }];
    }
    else
    {
        [delegate onInitDidFailWithErrorCode:400 errorMessage:@"no appid"];
    }
}

- (void)setConsent:(BOOL)consent
{
    [[CTADSDK sharedInstance] setGDPRStatus:consent];
}

- (NSString*)networkSDKVersion
{
    return [CTADSDK sdkVersion];
}

- (NSString*)adapterVersion
{
    return @"1.0.0";
}

+ (void)setGDPRStatus:(BOOL)bo
{
    [[CTADSDK sharedInstance] setGDPRStatus:bo];
}

+ (void)setDoNotSell:(BOOL)bo
{
    [[CTADSDK sharedInstance] setDoNotSell:bo];
}

+ (void)setCOPPAStatus:(BOOL)bo
{
    [[CTADSDK sharedInstance] setCOPPAStatus:bo];
}

+ (void)setLGPDStatus:(BOOL)bo
{
    [[CTADSDK sharedInstance] setLGPDStatus:bo];
}
@end
