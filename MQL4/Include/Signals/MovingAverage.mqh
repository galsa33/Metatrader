//+------------------------------------------------------------------+
//|                                                MovingAverage.mqh |
//|                                 Copyright © 2017, Matthew Kastor |
//|                                 https://github.com/matthewkastor |
//+------------------------------------------------------------------+
#property copyright "Matthew Kastor"
#property link      "https://github.com/matthewkastor"
#property strict

#include <Signals\MovingAverageBase.mqh>
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class MovingAverage : public MovingAverageBase
  {
public:
                     MovingAverage(int period,ENUM_TIMEFRAMES timeframe,ENUM_MA_METHOD maMethod,ENUM_APPLIED_PRICE maAppliedPrice,int maShift,int shift=0,double minimumSpreadsTpSl=1,color indicatorColor=clrHotPink);
   SignalResult     *Analyzer(string symbol,int shift);
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
MovingAverage::MovingAverage(int period,ENUM_TIMEFRAMES timeframe,ENUM_MA_METHOD maMethod,ENUM_APPLIED_PRICE maAppliedPrice,int maShift,int shift=0,double minimumSpreadsTpSl=1,color indicatorColor=clrHotPink):MovingAverageBase(period,timeframe,maMethod,maAppliedPrice,maShift,shift,minimumSpreadsTpSl,indicatorColor)
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
SignalResult *MovingAverage::Analyzer(string symbol,int shift)
  {
   PriceTrend ma=this.GetMovingAverageTrend(symbol,shift);

   this.DrawIndicatorTrend(symbol,shift,ma.current,ma.previous);

   MqlTick tick;
   bool gotTick=SymbolInfoTick(symbol,tick);

   if(gotTick)
     {
      if(ma.current<ma.previous)
        {
         this.Signal.isSet=true;
         this.Signal.time=tick.time;
         this.Signal.symbol=symbol;
         this.Signal.orderType=OP_SELL;
         this.Signal.price=tick.bid;
         this.Signal.stopLoss=0;
         this.Signal.takeProfit=0;
        }
      if(ma.current>ma.previous)
        {
         this.Signal.isSet=true;
         this.Signal.orderType=OP_BUY;
         this.Signal.price=tick.ask;
         this.Signal.symbol=symbol;
         this.Signal.time=tick.time;
         this.Signal.stopLoss=0;
         this.Signal.takeProfit=0;
        }
     }
   return this.Signal;
  }
//+------------------------------------------------------------------+
