//+------------------------------------------------------------------+
//|                                            CanvasGlitterBomb.mq4 |
//|                                 Copyright © 2017, Matthew Kastor |
//|                                 https://github.com/matthewkastor |
//+------------------------------------------------------------------+
#property copyright "Matthew Kastor"
#property link      "https://github.com/matthewkastor"
#property strict

#include <Canvas\Canvas.mqh> 
#include <Math\Random.mqh>
#include <Color\Colors.mqh>
//+------------------------------------------------------------------+ 
//| Script program start function                                    | 
//+------------------------------------------------------------------+ 
void OnStart()
  {
   CCanvas canvas;
   int      Width=Random::Number(100,800);
   int      Height=Random::Number(50,150);

   if(!canvas.CreateBitmapLabel(0,0,("CirclesCanvas"+(string)Random::Number(0,100000)),30,30,Width,Height,COLOR_FORMAT_ARGB_NORMALIZE))
     {
      Print("Error creating canvas: ",GetLastError());
     }

   canvas.Erase(Colors::Argb(0,0,0,0));

   for(int i=0;i<100;i++)
     {
      canvas.FillCircle(Random::Number(0,Width),Random::Number(0,Height),Random::Number(5,5),RandomArgbColor());
     }
   canvas.Update();
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
uint RandomArgbColor()
  {
   return Colors::Argb((uchar)Random::Number(0,255)
                       ,(uchar)Random::Number(0,255)
                       ,(uchar)Random::Number(0,255)
                       ,(uchar)Random::Number(0,255));
  }
//+------------------------------------------------------------------+
