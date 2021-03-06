//+------------------------------------------------------------------+
//|                                                    TimeStamp.mqh |
//|                                 Copyright © 2017, Matthew Kastor |
//|                                 https://github.com/matthewkastor |
//+------------------------------------------------------------------+
#property copyright "Matthew Kastor"
#property link      "https://github.com/matthewkastor"
#property version   "1.00"
#property strict

//+------------------------------------------------------------------+
//| Define an hour and minute, like 14:25                            |
//+------------------------------------------------------------------+
class TimeStamp
  {
public:
   int               Hour;
   int               Minute;
   void TimeStamp(string str)
     {
      string sep=":";
      string result[];
      ushort u_sep=StringGetCharacter(sep,0);
      int k=StringSplit(str,u_sep,result);
      int h= StrToInteger(result[0]);
      int m= StrToInteger(result[1]);
      Hour=h;
      Minute=m;
     }
   string ToString()
     {
      return(StringFormat("%02i%s%02i", Hour, ":", Minute));
     }
  };