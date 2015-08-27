//
//  CMCC_BLUETOOTH_EPS_IMSI.h
//  CMCC_BLUETOOTH_EPS_IMSI
//
//  Created by eps_admin on 15/5/11.
//  Copyright (c) 2015年 eps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface CMCC_BLUETOOTH_EPS_IMSI : NSObject<CBCentralManagerDelegate,CBPeripheralDelegate>

#pragma mark 初始化/扫描/连接
- (id) initWithDelegate:(id) delegate;
- (void) startScan;
- (void) stopScan;
- (void) connect:(CBPeripheral *)peripheral;
- (void) disconnect;
- (BOOL) isConnected;
- (void) connectByUUID:(NSString *) uuid;

#pragma mark 写卡
- (void) getCardICCID;
- (void) getCardIMSI;
- (void) writeCard:(NSString *) imsi;
- (void) openCard;
- (void) closeCard;

@end


#pragma mark 回调代理
@protocol CMCC_BLUETOOTH_EPS_IMSI_DELEGATE <NSObject>

@required
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error; //断开连接成功
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI;//发现外设
- (void)centralManagerDidUpdateState:(CBCentralManager *)central;
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral;//连接成功
- (void) didOpretionSuc:(NSDictionary *) dic; //操作成功
- (void) didOpretionFail:(NSDictionary *) dic;//操作失败

@end
