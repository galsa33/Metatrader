//+------------------------------------------------------------------+
//|                                                              MPC |
//|                                 Copyright © 2017, Matthew Kastor |
//|                                 https://github.com/matthewkastor |
//+------------------------------------------------------------------+
#property copyright "Matthew Kastor"
#property link      "https://github.com/matthewkastor"
#property description "Does Magic."
#property strict

#include <PLManager\PLManager.mqh>
#include <Schedule\ScheduleSet.mqh>
#include <Signals\SignalSet.mqh>
#include <Signals\ExtremeBreak.mqh>
#include <MPC\MPC.mqh>

input string WatchedSymbols="USDJPYpro,GBPUSDpro,USDCADpro,USDCHFpro,USDSEKpro"; // Currency Basket, csv list or blank for current chart.
input int ExtremeBreakPeriod=15;
input int ExtremeBreakShift=1;
input int ExtremeBreakMinimumTpSlDistance=50; // Tp/Sl Min. Points for valid signal.
input double Lots=0.01;
input double ProfitTarget=25; // Profit target in account currency
input double MaxLoss=25; // Maximum allowed loss in account currency
input int Slippage=10; // Allowed slippage
extern ENUM_DAY_OF_WEEK Start_Day=0;//Start Day
extern ENUM_DAY_OF_WEEK End_Day=6;//End Day
extern string   Start_Time="00:00";//Start Time
extern string   End_Time="24:00";//End Time
input bool ScheduleIsDaily=false;// Use start and stop times daily?
input bool TradeAtBarOpenOnly=false;// Trade only at opening of new bar?

MPC *mpc;
SymbolSet *ss;
ScheduleSet *sched;
OrderManager *om;
PLManager *plman;
SignalSet *signalSet;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void deinit()
  {
   delete mpc;
   delete ss;
   delete sched;
   delete om;
   delete plman;
   delete signalSet;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void init()
  {
   string symbols=WatchedSymbols;
   ss=new SymbolSet();
   ss.AddSymbolsFromCsv(symbols);

   sched=new ScheduleSet();
   if(ScheduleIsDaily==true)
     {
      sched.AddWeek(Start_Time,End_Time,Start_Day,End_Day);
     }
   else
     {
      sched.Add(new Schedule(Start_Day,Start_Time,End_Day,End_Time));
     }

   om=new OrderManager();
   om.Slippage=Slippage;

   plman=new PLManager(ss,om);
   plman.ProfitTarget=ProfitTarget;
   plman.MaxLoss=MaxLoss;
   plman.MinAge=60;

   signalSet=new SignalSet();
   signalSet.Add(new ExtremeBreak(ExtremeBreakPeriod,(ENUM_TIMEFRAMES)Period(),ExtremeBreakShift,ExtremeBreakMinimumTpSlDistance));
   signalSet.Add(new ExtremeBreak(ExtremeBreakPeriod,(ENUM_TIMEFRAMES)Period(),ExtremeBreakShift+(ExtremeBreakPeriod*3),ExtremeBreakMinimumTpSlDistance));
   signalSet.Add(new ExtremeBreak(ExtremeBreakPeriod,(ENUM_TIMEFRAMES)Period(),ExtremeBreakShift+(ExtremeBreakPeriod*6),ExtremeBreakMinimumTpSlDistance));

   mpc=new MPC(Lots,ss,sched,om,plman,signalSet);
   mpc.tradeEveryTick=!TradeAtBarOpenOnly;
   mpc.ExpertOnInit();
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnTick()
  {
   mpc.ExpertOnTick();
  }
//+------------------------------------------------------------------+
