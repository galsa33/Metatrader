//+------------------------------------------------------------------+
//|                                               RsiBandsConfig.mqh |
//|                                 Copyright © 2017, Matthew Kastor |
//|                                 https://github.com/matthewkastor |
//+------------------------------------------------------------------+
#property copyright "Matthew Kastor"
#property link      "https://github.com/matthewkastor"
#property strict

#include <Signals\Config\HighLowThresholds.mqh>
#include <Signals\Config\RsiBaseConfig.mqh>
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
struct RsiBandsConfig : public RsiBaseConfig
  {
public:
   HighLowThresholds Midband;
   HighLowThresholds Nullband;

   void RsiConfig()
     {
      this.Period=14;
      this.Timeframe=PERIOD_CURRENT;
      this.Shift=0;
      this.AppliedPrice=PRICE_CLOSE;
      this.Wideband.High=70.0;
      this.Wideband.Low=30.0;
      this.Midband.High=60.0;
      this.Midband.Low=40.0;
      this.Nullband.High=52.0;
      this.Nullband.Low=48.0;
     };
  };
//+------------------------------------------------------------------+
