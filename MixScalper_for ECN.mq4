
#property copyright "AlexanderS"
extern string Пapаметры=" Параметры советника";
extern bool TM5=true;
extern bool TM15=true;
extern bool TM30=true;
extern bool TM60=true;
extern bool MM=true;
extern int LowLevel=-95;
extern int CCIUP=90;
extern int WPRUP=-5;
extern int DinamicDepo=10000;
extern int TP_5=10;
extern int SL_5=40;
extern int filtr_5=2;
extern int MA_5=150;
extern int WPR_5=21;
extern int CCI_5=16;
extern int TP_15=10;
extern int SL_15=40;
extern int filtr_15=2;
extern int MA_15=150;
extern int WPR_15=21;
extern int CCI_15=16;
extern int TP_30=10;
extern int SL_30=40;
extern int filtr_30=2;
extern int MA_30=150;
extern int WPR_30=21;
extern int CCI_30=16;
extern int TP_60=10;
extern int SL_60=40;
extern int filtr_60=2;
extern int MA_60=150;
extern int WPR_60=21;
extern int CCI_60=16;
extern double lot = 0.03;
extern int CloseAt_5=4;
extern int CloseAt_15=4;
extern int CloseAt_30=4;
extern int CloseAt_60=4;
extern int Magic_Number = 68705;
extern int Slipage=3;
extern int SleepTime=2;

int total;
int Min;
int Start5;
int Start15;
int Start30;
int Start60;
int k;
bool BuTranz=false;
double Stop;
bool flag_sell=false,flag_buy=false;
int i;
bool NewTraid;
bool TraidToday;
bool OpenOrder_60=false;
bool OpenOrder_30=false;
bool OpenOrder_15=false;
bool OpenOrder_5=false;
bool SM5=false;
bool SM15=false;
bool SM30=false;
bool SM60=false;
bool BM5=false;
bool BM15=false;
bool BM30=false;
bool BM60=false;
int Kof;
int init()
{
   if((Digits==3)||(Digits==5)) { k=10;}
   if((Digits==4)||(Digits==2)) { k=1;}
   return(0);
}

int deinit()
{
   return(0);
}

int start()
{
  ObjectCreate("label_object1",OBJ_LABEL,0,0,0);
ObjectSet("label_object1",OBJPROP_CORNER,4);
ObjectSet("label_object1",OBJPROP_XDISTANCE,10);
ObjectSet("label_object1",OBJPROP_YDISTANCE,10);
ObjectSetText("label_object1","Минуты "+Min,12,"Arial",Green);

if (MM==true){
 if (Kof<AccountBalance()/DinamicDepo){Kof=AccountBalance()/DinamicDepo;}
 }
 else {Kof=1;}

if ((BM5==true)||(BM15==true)||(BM30==true)||(BM60==true)||(SM5==true)||(SM15==true)||(SM30==true)||(SM60==true)){
   for(int inb=0;inb<OrdersTotal();inb++)
     {      if(OrderSelect(inb,SELECT_BY_POS)==true)
        {
         if((OrderSymbol()==Symbol())&&(OrderMagicNumber()==Magic_Number) )
           {
         
            if(OrderType()==OP_BUY){ if ((BM5==true)&&(OrderComment()=="M5")){ if (OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice()-SL_5*k*Point,OrderOpenPrice()+TP_5*k*Point,0,Orange)>0){BM5=false;}     }
                                     if ((BM15==true)&&(OrderComment()=="M15")){ if (OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice()-SL_15*k*Point,OrderOpenPrice()+TP_15*k*Point,0,Orange)>0){BM15=false;}     }
                                     if ((BM30==true)&&(OrderComment()=="M30")){ if (OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice()-SL_30*k*Point,OrderOpenPrice()+TP_30*k*Point,0,Orange)>0){BM30=false;}     }
                                     if ((BM60==true)&&(OrderComment()=="M60")){ if (OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice()-SL_60*k*Point,OrderOpenPrice()+TP_60*k*Point,0,Orange)>0){BM60=false;} }

                                   }
            
             if(OrderType()==OP_SELL){
                                     if ((SM5==true)&&(OrderComment()=="M5")){ if (OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice()+SL_5*k*Point,OrderOpenPrice()-TP_5*k*Point,0,Orange)>0){SM5=false;}     }
                                     if ((SM15==true)&&(OrderComment()=="M15")){ if (OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice()+SL_15*k*Point,OrderOpenPrice()-TP_15*k*Point,0,Orange)>0){SM15=false;}     }
                                     if ((SM30==true)&&(OrderComment()=="M30")){ if (OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice()+SL_30*k*Point,OrderOpenPrice()-TP_30*k*Point,0,Orange)>0){SM30=false;}     }
                                     if ((SM60==true)&&(OrderComment()=="M60")){ if (OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice()+SL_60*k*Point,OrderOpenPrice()-TP_60*k*Point,0,Orange)>0){SM60=false;} }

                                     }
 
    
           }
        }
     }
     }

  
  if(!isNewBar())return(0);
if (Start5!=0){Start5=Start5-1;}
   OpenOrder_5=false;
    total=OrdersTotal();
   Min=Minute();
//TimeFrame 5
  double MA5=iMA(NULL,0,MA_5,0,MODE_SMA,PRICE_CLOSE,1);
  double ATR5=iATR(NULL,0,22,1);
  double WPR5=iWPR(NULL,0,WPR_5,1);
  double CCI5=iCCI(Symbol(),0,CCI_5,PRICE_TYPICAL,1);
//TimeFrame 15   

  double MA15=iMA(NULL,15,MA_15,0,MODE_SMA,PRICE_CLOSE,1);
  double ATR15=iATR(NULL,15,22,1);
  double WPR15=iWPR(NULL,15,WPR_15,1);
  double CCI15=iCCI(Symbol(),15,CCI_15,PRICE_TYPICAL,1);
   
//TimeFrame 30   

  double MA30=iMA(NULL,30,MA_30,0,MODE_SMA,PRICE_CLOSE,1);
  double ATR30=iATR(NULL,30,22,1);
  double WPR30=iWPR(NULL,30,WPR_30,1);
  double CCI30=iCCI(NULL,30,CCI_30,PRICE_TYPICAL,1);   
  
//TimeFrame 60   

  double MA60=iMA(NULL,60,MA_60,0,MODE_SMA,PRICE_CLOSE,1);
  double ATR60=iATR(NULL,60,22,1);
  double WPR60=iWPR(NULL,60,WPR_60,1);
  double CCI60=iCCI(NULL,60,CCI_60,PRICE_TYPICAL,1);    
   
  if ((Min==15)||(Min==30)||(Min==45)||(Min==0)){  OpenOrder_15=false;}
 if ((Min==30)||(Min==0)) {   OpenOrder_30=false;}
 if ((Min==0))  {  OpenOrder_60=false;}
        for(int in=0;in<total;in++)
     {      if(OrderSelect(in,SELECT_BY_POS)==true)
        {
         if((OrderSymbol()==Symbol())&&(OrderMagicNumber()==Magic_Number) )
           {
           if ((OrderType()==OP_BUY)&&(OrderComment()=="M5")){OpenOrder_5=true; Print("Количество свечей до перевода в безубыток M5 ",Start5);if ((OrderProfit()>0)&&(Start5==0)){OrderClose(OrderTicket(),OrderLots(),Bid,3*k,Black);}
           }
            if ((OrderType()==OP_BUY)&&(OrderComment()=="M15")&&((Min==15)||(Min==30)||(Min==45)||(Min==0))){OpenOrder_15=true; if (Start15!=0){Start15=Start15-1;Print("Количество свечей до перевода в безубыток M15 ",Start15);} if ((OrderProfit()>0)&&(Start15==0)){OrderClose(OrderTicket(),OrderLots(),Bid,3*k,Black);}
           }
             if ((OrderType()==OP_BUY)&&(OrderComment()=="M30")&&((Min==30)||(Min==0))){OpenOrder_30=true; if (Start30!=0){Start30=Start30-1;Print("Количество свечей до перевода в безубыток M30 ",Start30);} if ((OrderProfit()>0)&&(Start30==0)){OrderClose(OrderTicket(),OrderLots(),Bid,3*k,Black);}
           }
             if ((OrderType()==OP_BUY)&&(OrderComment()=="M60")&&(Min==0)){OpenOrder_60=true; if (Start60!=0){Start60=Start60-1;Print("Количество свечей до перевода в безубыток M60 ",Start60);} if ((OrderProfit()>0)&&(Start60==0)){OrderClose(OrderTicket(),OrderLots(),Bid,3*k,Black);}
           }
           if ((OrderType()==OP_SELL)&&(OrderComment()=="M5")){OpenOrder_5=true;Print("Количество свечей до перевода в безубыток M5 ",Start5); if ((OrderProfit()>0)&&(Start5==0)){OrderClose(OrderTicket(),OrderLots(),Ask,3*k,Black);}
           }
           if ((OrderType()==OP_SELL)&&(OrderComment()=="M15")&&((Min==15)||(Min==30)||(Min==45)||(Min==0))){OpenOrder_15=true; if (Start15!=0){Start15=Start15-1;Print("Количество свечей до перевода в безубыток M15 ",Start15);}if ((OrderProfit()>0)&&(Start15==0)){OrderClose(OrderTicket(),OrderLots(),Ask,3*k,Black);}
           }
            if ((OrderType()==OP_SELL)&&(OrderComment()=="M30")&&((Min==30)||(Min==0))){OpenOrder_30=true; if (Start30!=0){Start30=Start30-1;Print("Количество свечей до перевода в безубыток M30 ",Start30);}if ((OrderProfit()>0)&&(Start30==0)){OrderClose(OrderTicket(),OrderLots(),Ask,3*k,Black);}
           }
           if ((OrderType()==OP_SELL)&&(OrderComment()=="M60")&&(Min==0)){OpenOrder_60=true; if (Start60!=0){Start60=Start60-1;Print("Количество свечей до перевода в безубыток M60 ",Start60);}if ((OrderProfit()>0)&&(Start60==0)){OrderClose(OrderTicket(),OrderLots(),Ask,3*k,Black);}
           }
            }
      }
     }  

   if ((Start5!=0)&&(OpenOrder_5==false)){Start5=0;}  
      if ((Start15!=0)&&(OpenOrder_15==false)&&((Min==0)||(Min==15)||(Min==30)||(Min==45))){Start15=0;}    
        if ((Start30!=0)&&(OpenOrder_30==false)&&((Min==0)||(Min==30))){Start30=0;}  
          if ((Start60!=0)&&(OpenOrder_60==false)&&(Min==0)){Start60=0;}      
  if ((OpenOrder_5==false)&&(TM5==true)&&((MA5+filtr_5*Point*k)<Close[1])&&(ATR5>0.0002)&&(WPR5<LowLevel)&&(CCI5<LowLevel)) { 
  Start5=CloseAt_5;
    Print("Открываемся на buy m5, закрытие через ",Start5);
    RefreshRates();
  if(    OrderSend(Symbol(),OP_BUY,lot*Kof,Ask,Slipage*k,NULL,NULL,"M5",Magic_Number,0,Blue) < 0) 
      { 
        Alert("Ошибка открытия позиции № ", GetLastError());
      }
      else {BM5=true;SendMail("MixSystems Buy "+Symbol(),MarketInfo(Symbol(),MODE_SPREAD));}
  }
  
  if (((Min==15)||(Min==30)||(Min==45)||(Min==0))&&(TM15==true)){
    if ((OpenOrder_15==false)&&((MA15+filtr_15*Point*k)<Close[1])&&(ATR15>0.0002)&&(WPR15<LowLevel)&&(CCI15<LowLevel)) { 
  Start15=CloseAt_15;
  Print("Открываемся на buy m15, закрытие через ",Start15);
  RefreshRates();
  if(    OrderSend(Symbol(),OP_BUY,lot*Kof,Ask,Slipage*k,NULL,NULL,"M15",Magic_Number,0,Blue) < 0) 
      { 
        Alert("Ошибка открытия позиции № ", GetLastError());
      }   else {BM15=true;SendMail("MixSystems Buy "+Symbol(),MarketInfo(Symbol(),MODE_SPREAD));}
  }}
   if (((Min==30)||(Min==0))&&(TM30==true)) {
    if ((OpenOrder_30==false)&&((MA30+filtr_30*Point*k)<Close[1])&&(ATR30>0.0002)&&(WPR30<LowLevel)&&(CCI30<LowLevel)) { 
  Start30=CloseAt_30;
    Print("Открываемся на buy m30, закрытие через ",Start30);
    RefreshRates();
  if(    OrderSend(Symbol(),OP_BUY,lot*Kof,Ask,Slipage*k,NULL,NULL,"M30",Magic_Number,0,Blue) < 0) 
      { 
        Alert("Ошибка открытия позиции № ", GetLastError());
      }   else {BM30=true;SendMail("MixSystems Buy "+Symbol(),MarketInfo(Symbol(),MODE_SPREAD));}
  }}
   if (((Min==0))&&(TM60==true)) {
    if ((OpenOrder_60==false)&&((MA60+filtr_60*Point*k)<Close[1])&&(ATR60>0.0002)&&(WPR60<LowLevel)&&(CCI60<LowLevel)) { 
  Start60=CloseAt_60;
    Print("Открываемся на buy m60, закрытие через ",Start60);
    RefreshRates();
  if(    OrderSend(Symbol(),OP_BUY,lot*Kof,Ask,Slipage*k,NULL,NULL,"M60",Magic_Number,0,Blue) < 0) 
      { 
        Alert("Ошибка открытия позиции № ", GetLastError());
      }   else {BM60=true;SendMail("MixSystems Buy "+Symbol(),MarketInfo(Symbol(),MODE_SPREAD));}
  }}
  
  
   if ((OpenOrder_5==false)&&(TM5==true)&&((MA5-filtr_5*Point*k)>Close[1])&&(ATR5>0.0002)&&(WPR5>WPRUP)&&(CCI5>CCIUP)) { 
   Start5=CloseAt_5;
     Print("Открываемся на sell m5, закрытие через ",Start5);
     RefreshRates();
  if(    OrderSend(Symbol(),OP_SELL,lot*Kof,Bid,Slipage*k,NULL,NULL,"M5",Magic_Number,0,Red) < 0) 
      { 
        Alert("Ошибка открытия позиции № ", GetLastError());
      }   else {SM5=true;SendMail("MixSystems Sell "+Symbol(),MarketInfo(Symbol(),MODE_SPREAD));}
  } 
  if (((Min==15)||(Min==30)||(Min==45)||(Min==0))&&(TM15==true)){
  if ((OpenOrder_15==false)&&((MA15-filtr_15*Point*k)>Close[1])&&(ATR15>0.0002)&&(WPR15>WPRUP)&&(CCI15>CCIUP)) { 
   Start15=CloseAt_15;
        Print("Открываемся на sell m15, закрытие через ",Start15);
        RefreshRates();
  if(    OrderSend(Symbol(),OP_SELL,lot*Kof,Bid,Slipage*k,NULL,NULL,"M15",Magic_Number,0,Red) < 0) 
      { 
        Alert("Ошибка открытия позиции № ", GetLastError());
      }else {SM15=true;SendMail("MixSystems Sell "+Symbol(),MarketInfo(Symbol(),MODE_SPREAD));}
  } }
   if (((Min==30)||(Min==0))&&(TM30==true)) {
    if ((OpenOrder_30==false)&&((MA30-filtr_30*Point*k)>Close[1])&&(ATR30>0.0002)&&(WPR15>WPRUP)&&(CCI30>CCIUP)) { 
   Start30=CloseAt_30;
        Print("Открываемся на sell m30, закрытие через ",Start30);
        RefreshRates();
  if(    OrderSend(Symbol(),OP_SELL,lot*Kof,Bid,Slipage*k,NULL,NULL,"M30",Magic_Number,0,Red) < 0) 
      { 
        Alert("Ошибка открытия позиции № ", GetLastError());
      }else {SM30=true;SendMail("MixSystems Sell "+Symbol(),MarketInfo(Symbol(),MODE_SPREAD));}
  } }
   if (((Min==0))&&(TM60==true)) {
    if ((OpenOrder_60==false)&&((MA60-filtr_60*Point*k)>Close[1])&&(ATR60>0.0002)&&(WPR60>WPRUP)&&(CCI60>CCIUP)) { 
   Start60=CloseAt_60;
           Print("Открываемся на sell m60, закрытие через ",Start60);
           RefreshRates();
  if(    OrderSend(Symbol(),OP_SELL,lot*Kof,Bid,Slipage*k,NULL,NULL,"M60",Magic_Number,0,Red) < 0) 
      { 
        Alert("Ошибка открытия позиции № ", GetLastError());
      }else {SM60=true;SendMail("MixSystems Sell "+Symbol(),MarketInfo(Symbol(),MODE_SPREAD));}
  }   }
  
 



   
   
   
   
  if(
  Orders_Total_by_type(OP_BUY, Magic_Number, Symbol()) > 0)

   
 if(
 Orders_Total_by_type(OP_SELL, Magic_Number, Symbol()) > 0)
  
   
   return(0);
  }
//+------------------------------------------------------------------+

bool isNewBar()
  {
  static datetime BarTime;  
   bool res=false;
    
   if (BarTime!=Time[0]) 
      {
         BarTime=Time[0];  
         res=true;
      } 
   return(res);
  }
  
//---- Возвращает количество ордеров указанного типа ордеров ----//
int Orders_Total_by_type(int type, int mn, string sym)
{
   int num_orders=0;
   for(int i= OrdersTotal()-1;i>=0;i--)
   {
      OrderSelect(i,SELECT_BY_POS,MODE_TRADES);
      if(OrderMagicNumber() == mn && type == OrderType() && sym==OrderSymbol())
         num_orders++;
   }
   return(num_orders);
}

