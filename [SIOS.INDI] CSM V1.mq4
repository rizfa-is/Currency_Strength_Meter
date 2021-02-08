//+------------------------------------------------------------------+
//|                                       [SIOS.INDI] New CSM V1.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2019,  SIOS Insight Corp."
#property link      "https://t.me/sios_insight"
#property description   "SIOS adalah singkatan dari Supertrade Innovation and Online Investment. Kami hadir sebagai asisten keuangan anda dalam memproyeksikan dan mengoptimalkan pendapatan aktif dan pasif anda. \n\nCONTACT PERSON : \nTelegram : @azzamra15 \nWhatsApp : (+62)89 670 507 682"
#property icon "\\images\\siosin.ico"
#property strict
#property indicator_separate_window
#property indicator_buffers 8
#property indicator_color1 clrBlue
#property indicator_width1 1
#property indicator_color2 clrRed
#property indicator_width2 1
#property indicator_color3 clrMagenta
#property indicator_width3 1
#property indicator_color4 clrAqua
#property indicator_width4 1
#property indicator_color5 clrYellow
#property indicator_width5 1
#property indicator_color6 clrGreen
#property indicator_width6 1
#property indicator_color7 clrDarkOrange
#property indicator_width7 1
#property indicator_color8 clrLime
#property indicator_width8 1


#define sub_wnd 1
enum stch {PRICE_1=0,PRICE_2=1};

// External variables
extern string myName = "+++{  [SIOS] Currency Strenght Meter V1  }+++";
extern string               TFs                 = "=== Currency Strenght Meter V1 ===";
extern int                  BarsToCalculate              = 90;
extern int                  Smooth_Period     = 5;
extern string suffix="";
extern ENUM_APPLIED_PRICE   Methode_InLogic     = PRICE_CLOSE;

double usd[],eur[],gbp[],aud[],nzd[],cad[],chf[],jpy[];
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit() {
//--- indicator buffers mapping
   IndicatorBuffers(8);
   SetIndexBuffer(0,usd);
   SetIndexBuffer(1,eur);
   SetIndexBuffer(2,gbp);
   SetIndexBuffer(3,aud);
   SetIndexBuffer(4,nzd);
   SetIndexBuffer(5,cad);
   SetIndexBuffer(6,chf);
   SetIndexBuffer(7,jpy);
   SetIndexStyle(0,DRAW_LINE);
   SetIndexStyle(1,DRAW_LINE);
   SetIndexStyle(2,DRAW_LINE);
   SetIndexStyle(3,DRAW_LINE);
   SetIndexStyle(4,DRAW_LINE);
   SetIndexStyle(5,DRAW_LINE);
   SetIndexStyle(6,DRAW_LINE);
   SetIndexStyle(7,DRAW_LINE);
   SetIndexLabel(0,"USD");
   SetIndexLabel(1,"EUR");
   SetIndexLabel(2,"GBP");
   SetIndexLabel(3,"AUD");
   SetIndexLabel(4,"NZD");
   SetIndexLabel(5,"CAD");
   SetIndexLabel(6,"CHF");
   SetIndexLabel(7,"JPY");
   SetLevelValue(0,20);
   SetLevelValue(1,40);
   SetLevelValue(2,60);
   SetLevelValue(3,80);
//---
   return(INIT_SUCCEEDED);
}
//+------------------------------------------------------------------+
void OnDeinit(const int reason) {
}
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[]) {
//---
   if(disabled()==false) {
      for(int i=0; i<BarsToCalculate; i++) {
         if(Smooth_Period<=2) Smooth_Period=2;
         usd[i]=SnUSD(PERIOD_CURRENT,i);
         eur[i]=SnEUR(PERIOD_CURRENT,i);
         gbp[i]=SnGBP(PERIOD_CURRENT,i);
         aud[i]=SnAUD(PERIOD_CURRENT,i);
         nzd[i]=SnNZD(PERIOD_CURRENT,i);
         cad[i]=SnCAD(PERIOD_CURRENT,i);
         chf[i]=SnCHF(PERIOD_CURRENT,i);
         jpy[i]=SnJPY(PERIOD_CURRENT,i);
         

         color cusd=clrRed;
         color ceur=clrBlue;
         color cgbp=clrMagenta;
         color caud=clrAqua;
         color cnzd=clrYellow;
         color ccad=clrGreen;
         color cchf=clrDarkOrange;
         color cjpy=clrLime;

         int xmax=50;
         int ymax=15;
         SnText("txt1","USD    ",12,xmax,ymax,cusd);
         SnText("txt2","EUR    ",12,xmax,ymax+20,ceur);
         SnText("txt3","GBP    ",12,xmax,ymax+20*2,cgbp);
         SnText("txt4","AUD    ",12,xmax,ymax+20*3,caud);
         SnText("txt5","NZD    ",12,xmax,ymax+20*4,cnzd);
         SnText("txt6","CAD    ",12,xmax,ymax+20*5,ccad);
         SnText("txt7","CHF    ",12,xmax,ymax+20*6,cchf);
         SnText("txt8","JPY    ",12,xmax,ymax+20*7,cjpy);

         SnText("txt11",DoubleToString(SnUSD(PERIOD_CURRENT,0),2),12,xmax+50,ymax,cusd);
         SnText("txt21",DoubleToString(SnEUR(PERIOD_CURRENT,0),2),12,xmax+50,ymax+20,ceur);
         SnText("txt31",DoubleToString(SnGBP(PERIOD_CURRENT,0),2),12,xmax+50,ymax+20*2,cgbp);
         SnText("txt41",DoubleToString(SnAUD(PERIOD_CURRENT,0),2),12,xmax+50,ymax+20*3,caud);
         SnText("txt51",DoubleToString(SnNZD(PERIOD_CURRENT,0),2),12,xmax+50,ymax+20*4,cnzd);
         SnText("txt61",DoubleToString(SnCAD(PERIOD_CURRENT,0),2),12,xmax+50,ymax+20*5,ccad);
         SnText("txt71",DoubleToString(SnCHF(PERIOD_CURRENT,0),2),12,xmax+50,ymax+20*6,cchf);
         SnText("txt81",DoubleToString(SnJPY(PERIOD_CURRENT,0),2),12,xmax+50,ymax+20*7,cjpy);
      }
   }

//--- return value of prev_calculated for next call
   return(rates_total);
}
//+------------------------------------------------------------------+
void SnChartInfo() {
   RefreshRates();
}
//+------------------------------------------------------------------+
double SnPoint() {
   double pips=0;
   if(Digits==3 || Digits==5)
      pips=Point*10;
   if(Digits==2 || Digits==4)
      pips=Point;
   if(StringFind(Symbol(),"XAUUSD",0)>=0 || StringFind(Symbol(),"GOLD",0)>=0)
      pips=Point*10;
   return(pips);
}
//+------------------------------------------------------------------+
bool disabled() {
   bool mati=0;
   if(TimeCurrent()>D'2020.02.19 00:00') {
      mati=true;
      Alert("INDICATOR IS EXPIRED");
   }
   if(TimeCurrent()<D'2020.02.19 00:00')
      mati=false;
   return(mati);
}
//+------------------------------------------------------------------+
void SnBG(string name,int xmax,int ymax) {
   if(ObjectFind(0,name)<0)
      ObjectCreate(0,name,OBJ_RECTANGLE_LABEL,sub_wnd,0,0);
   ObjectSetInteger(0,name,OBJPROP_XDISTANCE,5);
   ObjectSetInteger(0,name,OBJPROP_YDISTANCE,16);
   ObjectSetInteger(0,name,OBJPROP_XSIZE,xmax);
   ObjectSetInteger(0,name,OBJPROP_YSIZE,ymax);
   ObjectSetInteger(0,name,OBJPROP_BGCOLOR,clrBlack);
   ObjectSetInteger(0,name,OBJPROP_BORDER_COLOR,clrNavy);
   ObjectSetInteger(0,name,OBJPROP_WIDTH,100);
   ObjectSetInteger(0,name,OBJPROP_BACK,false);
}
//+------------------------------------------------------------------+
void SnText(string name,string text,int myFontSz,int xmax,int ymax,color myClr) {
   if(ObjectFind(0,name)<0)
      ObjectCreate(name,OBJ_LABEL,sub_wnd,0,0);
   ObjectSetString(0,name,OBJPROP_FONT,"Times New Roman");
   ObjectSetInteger(0,name,OBJPROP_FONTSIZE,myFontSz);
   ObjectSetInteger(0,name,OBJPROP_COLOR,myClr);
   ObjectSetString(0,name,OBJPROP_TEXT,text);
   ObjectSetInteger(0,name,OBJPROP_XDISTANCE,xmax);
   ObjectSetInteger(0,name,OBJPROP_YDISTANCE,ymax);
   ObjectSetInteger(0,name,OBJPROP_CORNER,1);
   ObjectSetInteger(0,name,OBJPROP_BACK,false);
}
//+------------------------------------------------------------------+
void SnText2(string name,string text,string myFont,int myFontSz,int xmax,int ymax,color myColor) {
   if(ObjectFind(0,name)<0)
      ObjectCreate(name,OBJ_LABEL,sub_wnd,0,0);
   ObjectSetString(0,name,OBJPROP_FONT,myFont);
   ObjectSetInteger(0,name,OBJPROP_FONTSIZE,myFontSz);
   ObjectSetInteger(0,name,OBJPROP_COLOR,myColor);
   ObjectSetString(0,name,OBJPROP_TEXT,text);
   ObjectSetInteger(0,name,OBJPROP_XDISTANCE,xmax);
   ObjectSetInteger(0,name,OBJPROP_YDISTANCE,ymax);
   ObjectSetInteger(0,name,OBJPROP_BORDER_COLOR,clrBlack);
   ObjectSetInteger(0,name,OBJPROP_BACK,false);
}
//+------------------------------------------------------------------+
double SnUSD(int tf,int a) {
   double result=0;
   int count=0;
   double out[7];
   out[0]=iRSI("EURUSD"+suffix,tf,Smooth_Period,Methode_InLogic,a);
   out[1]=iRSI("USDJPY"+suffix,tf,Smooth_Period,Methode_InLogic,a);
   out[2]=iRSI("GBPUSD"+suffix,tf,Smooth_Period,Methode_InLogic,a);
   out[3]=iRSI("AUDUSD"+suffix,tf,Smooth_Period,Methode_InLogic,a);
   out[4]=iRSI("NZDUSD"+suffix,tf,Smooth_Period,Methode_InLogic,a);
   out[5]=iRSI("USDCHF"+suffix,tf,Smooth_Period,Methode_InLogic,a);
   out[6]=iRSI("USDCAD"+suffix,tf,Smooth_Period,Methode_InLogic,a);

//Adjusting Value based Pair
   out[0]=100-out[0];
   out[2]=100-out[2];
   out[3]=100-out[3];
   out[4]=100-out[4];

//Selected Unavailable Value
   for(int i=0; i<7; i++) {
      if(out[i]==0 || out[i]==100)
         continue;
      count++;
      ////Measuring amount of all Pair
      result+=out[i];
   }
   result/=count;
   return(result);
}
//+------------------------------------------------------------------+
double SnEUR(int tf,int a) {
   double result=0;
   int count=0;
   double out[7];
   out[0]=iRSI("EURUSD"+suffix,tf,Smooth_Period,Methode_InLogic,a);
   out[1]=iRSI("EURGBP"+suffix,tf,Smooth_Period,Methode_InLogic,a);
   out[2]=iRSI("EURJPY"+suffix,tf,Smooth_Period,Methode_InLogic,a);
   out[3]=iRSI("EURCAD"+suffix,tf,Smooth_Period,Methode_InLogic,a);
   out[4]=iRSI("EURCHF"+suffix,tf,Smooth_Period,Methode_InLogic,a);
   out[5]=iRSI("EURAUD"+suffix,tf,Smooth_Period,Methode_InLogic,a);
   out[6]=iRSI("EURNZD"+suffix,tf,Smooth_Period,Methode_InLogic,a);

//Selected Unavailable Value
   for(int i=0; i<7; i++) {
      if(out[i]==0 || out[i]==100)
         continue;
      count++;
      //Measuring amount of all Pair
      result+=out[i];
   }
   result/=count;
   return(result);
}
//+------------------------------------------------------------------+
double SnGBP(int tf,int a) {
   double result=0;
   int count=0;
   double out[7];
   out[0]=iRSI("GBPUSD"+suffix,tf,Smooth_Period,Methode_InLogic,a);
   out[1]=iRSI("GBPJPY"+suffix,tf,Smooth_Period,Methode_InLogic,a);
   out[2]=iRSI("EURGBP"+suffix,tf,Smooth_Period,Methode_InLogic,a);
   out[3]=iRSI("GBPCHF"+suffix,tf,Smooth_Period,Methode_InLogic,a);
   out[4]=iRSI("GBPCAD"+suffix,tf,Smooth_Period,Methode_InLogic,a);
   out[5]=iRSI("GBPAUD"+suffix,tf,Smooth_Period,Methode_InLogic,a);
   out[6]=iRSI("GBPNZD"+suffix,tf,Smooth_Period,Methode_InLogic,a);

//Adjusting Value based Pair
   out[2]=100-out[2];

//Selected Unavailable Value
   for(int i=0; i<7; i++) {
      if(out[i]==0 || out[i]==100)
         continue;
      count++;
      ////Measuring amount of all Pair
      result+=out[i];
   }
   result/=count;
   return(result);
}
//+------------------------------------------------------------------+
double SnAUD(int tf,int a) {
   double result=0;
   int count=0;
   double out[7];
   out[0]=iRSI("AUDUSD"+suffix,tf,Smooth_Period,Methode_InLogic,a);
   out[1]=iRSI("AUDJPY"+suffix,tf,Smooth_Period,Methode_InLogic,a);
   out[2]=iRSI("GBPAUD"+suffix,tf,Smooth_Period,Methode_InLogic,a);
   out[3]=iRSI("AUDCHF"+suffix,tf,Smooth_Period,Methode_InLogic,a);
   out[4]=iRSI("AUDCAD"+suffix,tf,Smooth_Period,Methode_InLogic,a);
   out[5]=iRSI("EURAUD"+suffix,tf,Smooth_Period,Methode_InLogic,a);
   out[6]=iRSI("AUDNZD"+suffix,tf,Smooth_Period,Methode_InLogic,a);

//Adjusting Value based Pair
   out[2]=100-out[2];
   out[5]=100-out[5];

//Selected Unavailable Value
   for(int i=0; i<7; i++) {
      if(out[i]==0 || out[i]==100)
         continue;
      count++;
      ////Measuring amount of all Pair
      result+=out[i];
   }
   result/=count;
   return(result);
}
//+------------------------------------------------------------------+
double SnNZD(int tf,int a) {
   double result=0;
   int count=0;
   double out[7];
   out[0]=iRSI("NZDUSD"+suffix,tf,Smooth_Period,Methode_InLogic,a);
   out[1]=iRSI("NZDJPY"+suffix,tf,Smooth_Period,Methode_InLogic,a);
   out[2]=iRSI("AUDNZD"+suffix,tf,Smooth_Period,Methode_InLogic,a);
   out[3]=iRSI("NZDCHF"+suffix,tf,Smooth_Period,Methode_InLogic,a);
   out[4]=iRSI("GBPNZD"+suffix,tf,Smooth_Period,Methode_InLogic,a);
   out[5]=iRSI("EURNZD"+suffix,tf,Smooth_Period,Methode_InLogic,a);
   out[6]=iRSI("NZDCAD"+suffix,tf,Smooth_Period,Methode_InLogic,a);

//Adjusting Value based Pair
   out[2]=100-out[2];
   out[4]=100-out[4];
   out[5]=100-out[5];

//Selected Unavailable Value
   for(int i=0; i<7; i++) {
      if(out[i]==0 || out[i]==100)
         continue;
      count++;
      ////Measuring amount of all Pair
      result+=out[i];
   }
   result/=count;
   return(result);
}
//+------------------------------------------------------------------+
double SnCAD(int tf,int a) {
   double result=0;
   int count=0;
   double out[7];
   out[0]=iRSI("CADCHF"+suffix,tf,Smooth_Period,Methode_InLogic,a);
   out[1]=iRSI("CADJPY"+suffix,tf,Smooth_Period,Methode_InLogic,a);
   out[2]=iRSI("USDCAD"+suffix,tf,Smooth_Period,Methode_InLogic,a);
   out[3]=iRSI("EURCAD"+suffix,tf,Smooth_Period,Methode_InLogic,a);
   out[4]=iRSI("GBPCAD"+suffix,tf,Smooth_Period,Methode_InLogic,a);
   out[5]=iRSI("AUDCAD"+suffix,tf,Smooth_Period,Methode_InLogic,a);
   out[6]=iRSI("NZDCAD"+suffix,tf,Smooth_Period,Methode_InLogic,a);

//Adjusting Value based Pair
   out[2]=100-out[2];
   out[3]=100-out[3];
   out[4]=100-out[4];
   out[5]=100-out[5];
   out[6]=100-out[6];

//Selected Unavailable Value
   for(int i=0; i<7; i++) {
      if(out[i]==0 || out[i]==100)
         continue;
      count++;
      ////Measuring amount of all Pair
      result+=out[i];
   }
   result/=count;
   return(result);
}
//+------------------------------------------------------------------+
double SnCHF(int tf,int a) {
   double result=0;
   int count=0;
   double out[7];
   out[0]=iRSI("CADCHF"+suffix,tf,Smooth_Period,Methode_InLogic,a);
   out[1]=iRSI("AUDCHF"+suffix,tf,Smooth_Period,Methode_InLogic,a);
   out[2]=iRSI("USDCHF"+suffix,tf,Smooth_Period,Methode_InLogic,a);
   out[3]=iRSI("EURCHF"+suffix,tf,Smooth_Period,Methode_InLogic,a);
   out[4]=iRSI("GBPCHF"+suffix,tf,Smooth_Period,Methode_InLogic,a);
   out[5]=iRSI("CHFJPY"+suffix,tf,Smooth_Period,Methode_InLogic,a);
   out[6]=iRSI("NZDCHF"+suffix,tf,Smooth_Period,Methode_InLogic,a);

//Adjusting Value based Pair
   out[0]=100-out[0];
   out[1]=100-out[1];
   out[2]=100-out[2];
   out[3]=100-out[3];
   out[4]=100-out[4];
   out[6]=100-out[6];

//Selected Unavailable Value
   for(int i=0; i<7; i++) {
      if(out[i]==0 || out[i]==100)
         continue;
      count++;
      ////Measuring amount of all Pair
      result+=out[i];
   }
   result/=count;
   return(result);
}
//+------------------------------------------------------------------+
double SnJPY(int tf,int a) {
   double result=0;
   int count=0;
   double out[7];
   out[0]=iRSI("USDJPY"+suffix,tf,Smooth_Period,Methode_InLogic,a);
   out[1]=iRSI("GBPJPY"+suffix,tf,Smooth_Period,Methode_InLogic,a);
   out[2]=iRSI("CADJPY"+suffix,tf,Smooth_Period,Methode_InLogic,a);
   out[3]=iRSI("CHFJPY"+suffix,tf,Smooth_Period,Methode_InLogic,a);
   out[4]=iRSI("NZDJPY"+suffix,tf,Smooth_Period,Methode_InLogic,a);
   out[5]=iRSI("AUDJPY"+suffix,tf,Smooth_Period,Methode_InLogic,a);
   out[6]=iRSI("EURJPY"+suffix,tf,Smooth_Period,Methode_InLogic,a);

//Adjusting Value based Pair
   out[0]=100-out[0];
   out[1]=100-out[1];
   out[2]=100-out[2];
   out[3]=100-out[3];
   out[4]=100-out[4];
   out[5]=100-out[5];
   out[6]=100-out[6];

//Selected Unavailable Value
   for(int i=0; i<7; i++) {
      if(out[i]==0 || out[i]==100)
         continue;
      count++;
      ////Measuring amount of all Pair
      result+=out[i];
   }
   result/=count;
   return(result);
}
//+------------------------------------------------------------------+
