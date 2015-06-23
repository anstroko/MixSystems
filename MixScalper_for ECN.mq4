
#property copyright "AlexanderS"
extern string Пapаметры=" Параметры советника";
extern bool TM5=true;
extern bool TM15=true;
extern bool TM30=true;
extern bool TM60=true;
extern bool MM=true;
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
         
            if(OrderType()==OP_BUY){ if (BM5==true){ if (OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice()-SL_5*k*Point,OrderOpenPrice()+TP_5*k*Point,0,Orange)>0){BM5=false;}     }
                                     if (BM15==true){ if (OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice()-SL_15*k*Point,OrderOpenPrice()+TP_15*k*Point,0,Orange)>0){BM15=false;}     }
                                     if (BM30==true){ if (OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice()-SL_30*k*Point,OrderOpenPrice()+TP_30*k*Point,0,Orange)>0){BM30=false;}     }
                                     if (BM60==true){ if (OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice()-SL_60*k*Point,OrderOpenPrice()+TP_60*k*Point,0,Orange)>0){BM60=false;} }

                                   }
            
             if(OrderType()==OP_SELL){
                                     if (SM5==true){ if (OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice()+SL_5*k*Point,OrderOpenPrice()-TP_5*k*Point,0,Orange)>0){SM5=false;}     }
                                     if (SM15==true){ if (OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice()+SL_15*k*Point,OrderOpenPrice()-TP_15*k*Point,0,Orange)>0){SM15=false;}     }
                                     if (SM30==true){ if (OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice()+SL_30*k*Point,OrderOpenPrice()-TP_30*k*Point,0,Orange)>0){SM30=false;}     }
                                     if (SM60==true){ if (OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice()+SL_60*k*Point,OrderOpenPrice()-TP_60*k*Point,0,Orange)>0){SM60=false;} }

                                     }
 
    
           }
        }
     }
     }

  
  if(!isNewBar())return(0);
if (Start5!=0){Start5=Start5-1;}
   OpenOrder_5=false;
  if ((Minute()==15)||(Minute()==30)||(Minute()==45)||(Minute()==00)){  OpenOrder_15=false;}
 if ((Minute()==30)||(Minute()==00)) {   OpenOrder_30=false;}
 if ((Minute()==00))  {  OpenOrder_60=false;}
int total=OrdersTotal();
     for(int in=0;in<OrdersTotal();in++)
     {      if(OrderSelect(in,SELECT_BY_POS)==true)
        {
         if((OrderSymbol()==Symbol())&&(OrderMagicNumber()==Magic_Number) )
           {
           if ((OrderType()==OP_BUY)&&(OrderComment()=="M5")){OpenOrder_5=true; if ((OrderProfit()>0)&&(Start5==0)){OrderClose(OrderTicket(),OrderLots(),Bid,3*k,Black);}
           }
            if ((OrderType()==OP_BUY)&&(OrderComment()=="M15")&&((Minute()==15)||(Minute()==30)||(Minute()==45)||(Minute()==00))){OpenOrder_15=true; if (Start15!=0){Start15=Start15-1;} if ((OrderProfit()>0)&&(Start15==0)){OrderClose(OrderTicket(),OrderLots(),Bid,3*k,Black);}
           }
             if ((OrderType()==OP_BUY)&&(OrderComment()=="M30")&&((Minute()==30)||(Minute()==00))){OpenOrder_30=true; if (Start30!=0){Start30=Start30-1;} if ((OrderProfit()>0)&&(Start30==0)){OrderClose(OrderTicket(),OrderLots(),Bid,3*k,Black);}
           }
             if ((OrderType()==OP_BUY)&&(OrderComment()=="M60")&&(Minute()==00)){OpenOrder_60=true; if (Start60!=0){Start60=Start60-1;} if ((OrderProfit()>0)&&(Start60==0)){OrderClose(OrderTicket(),OrderLots(),Bid,3*k,Black);}
           }
           if ((OrderType()==OP_SELL)&&(OrderComment()=="M5")){OpenOrder_5=true; if ((OrderProfit()>0)&&(Start5==0)){OrderClose(OrderTicket(),OrderLots(),Ask,3*k,Black);}
           }
           if ((OrderType()==OP_SELL)&&(OrderComment()=="M15")&&((Minute()==15)||(Minute()==30)||(Minute()==45)||(Minute()==00))){OpenOrder_15=true; if (Start15!=0){Start15=Start15-1;}if ((OrderProfit()>0)&&(Start15==0)){OrderClose(OrderTicket(),OrderLots(),Ask,3*k,Black);}
           }
            if ((OrderType()==OP_SELL)&&(OrderComment()=="M30")&&((Minute()==30)||(Minute()==00))){OpenOrder_30=true; if (Start30!=0){Start30=Start30-1;}if ((OrderProfit()>0)&&(Start30==0)){OrderClose(OrderTicket(),OrderLots(),Ask,3*k,Black);}
           }
           if ((OrderType()==OP_SELL)&&(OrderComment()=="M60")&&(Minute()==00)){OpenOrder_60=true; if (Start60!=0){Start60=Start60-1;}if ((OrderProfit()>0)&&(Start60==0)){OrderClose(OrderTicket(),OrderLots(),Ask,3*k,Black);}
           }
            }
    }
     }
   if ((Start5!=0)&&(OpenOrder_5==false)){Start5=0;}  
      if ((Start15!=0)&&(OpenOrder_5==false)){Start5=0;}    
        if ((Start30!=0)&&(OpenOrder_30==false)){Start30=0;}  
          if ((Start60!=0)&&(OpenOrder_60==false)){Start60=0;}      
  if ((OpenOrder_5==false)&&(TM5==true)&&((iMA(NULL,0,MA_5,0,MODE_SMA,PRICE_CLOSE,1)+filtr_5*Point*k)<Close[1])&&(iATR(NULL,0,22,1)>0.0002)&&(iWPR(NULL,0,WPR_5,1)<-95)&&(iCCI(Symbol(),0,CCI_5,PRICE_TYPICAL,1)<-95)) { 
  Start5=CloseAt_5;
    Print("Открываемся на buy m5");
    RefreshRates();
  if(    OrderSend(Symbol(),OP_BUY,lot*Kof,Ask,Slipage*k,NULL,NULL,"M5",Magic_Number,0,Blue) < 0) 
      { 
        Alert("Ошибка открытия позиции № ", GetLastError());
      }
      else {BM5=true;SendMail("MixSystems Buy"+Symbol(),"Депо ="+AccountEquity());}
  }
  
  if (((Minute()==15)||(Minute()==30)||(Minute()==45)||(Minute()==00))&&(TM15==true)){
    if ((OpenOrder_15==false)&&((iMA(NULL,15,MA_15,0,MODE_SMA,PRICE_CLOSE,1)+filtr_15*Point*k)<Close[1])&&(iATR(NULL,15,22,1)>0.0002)&&(iWPR(NULL,15,WPR_15,1)<-95)&&(iCCI(Symbol(),15,CCI_15,PRICE_TYPICAL,1)<-95)) { 
  Start15=CloseAt_15;
  Print("Открываемся на buy m15");
  RefreshRates();
  if(    OrderSend(Symbol(),OP_BUY,lot*Kof,Ask,Slipage*k,NULL,NULL,"M15",Magic_Number,0,Blue) < 0) 
      { 
        Alert("Ошибка открытия позиции № ", GetLastError());
      }   else {BM15=true;SendMail("MixSystems Buy"+Symbol(),"Депо ="+AccountEquity());}
  }}
   if (((Minute()==30)||(Minute()==00))&&(TM30==true)) {
    if ((OpenOrder_30==false)&&((iMA(NULL,30,MA_30,0,MODE_SMA,PRICE_CLOSE,1)+filtr_30*Point*k)<Close[1])&&(iATR(NULL,30,22,1)>0.0002)&&(iWPR(NULL,30,WPR_30,1)<-95)&&(iCCI(Symbol(),30,CCI_30,PRICE_TYPICAL,1)<-95)) { 
  Start30=CloseAt_30;
    Print("Открываемся на buy m30");
    RefreshRates();
  if(    OrderSend(Symbol(),OP_BUY,lot*Kof,Ask,Slipage*k,NULL,NULL,"M30",Magic_Number,0,Blue) < 0) 
      { 
        Alert("Ошибка открытия позиции № ", GetLastError());
      }   else {BM30=true;SendMail("MixSystems Buy"+Symbol(),"Депо ="+AccountEquity());}
  }}
   if (((Minute()==00))&&(TM60==true)) {
    if ((OpenOrder_60==false)&&((iMA(NULL,60,MA_60,0,MODE_SMA,PRICE_CLOSE,1)+filtr_60*Point*k)<Close[1])&&(iATR(NULL,60,22,1)>0.0002)&&(iWPR(NULL,60,WPR_60,1)<-95)&&(iCCI(Symbol(),60,CCI_60,PRICE_TYPICAL,1)<-95)) { 
  Start60=CloseAt_60;
    Print("Открываемся на buy m60");
    RefreshRates();
  if(    OrderSend(Symbol(),OP_BUY,lot*Kof,Ask,Slipage*k,NULL,NULL,"M60",Magic_Number,0,Blue) < 0) 
      { 
        Alert("Ошибка открытия позиции № ", GetLastError());
      }   else {BM60=true;SendMail("MixSystems Buy"+Symbol(),"Депо ="+AccountEquity());}
  }}
  
  
   if ((OpenOrder_5==false)&&(TM5==true)&&((iMA(NULL,0,MA_5,0,MODE_SMA,PRICE_CLOSE,1)-filtr_5*Point*k)>Close[1])&&(iATR(NULL,0,22,1)>0.0002)&&(iWPR(NULL,0,WPR_5,1)>-5)&&(iCCI(Symbol(),0,CCI_5,PRICE_TYPICAL,1)>90)) { 
   Start5=CloseAt_5;
     Print("Открываемся на sell m5");
     RefreshRates();
  if(    OrderSend(Symbol(),OP_SELL,lot*Kof,Bid,Slipage*k,NULL,NULL,"M5",Magic_Number,0,Red) < 0) 
      { 
        Alert("Ошибка открытия позиции № ", GetLastError());
      }   else {SM5=true;SendMail("MixSystems Sell"+Symbol(),"Депо ="+AccountEquity());}
  } 
  if (((Minute()==15)||(Minute()==30)||(Minute()==45)||(Minute()==00))&&(TM15==true)){
  if ((OpenOrder_15==false)&&((iMA(NULL,15,MA_15,0,MODE_SMA,PRICE_CLOSE,1)-filtr_15*Point*k)>Close[1])&&(iATR(NULL,15,22,1)>0.0002)&&(iWPR(NULL,15,WPR_15,1)>-5)&&(iCCI(Symbol(),15,CCI_15,PRICE_TYPICAL,1)>90)) { 
   Start15=CloseAt_15;
        Print("Открываемся на sell m15");
        RefreshRates();
  if(    OrderSend(Symbol(),OP_SELL,lot*Kof,Bid,Slipage*k,NULL,NULL,"M15",Magic_Number,0,Red) < 0) 
      { 
        Alert("Ошибка открытия позиции № ", GetLastError());
      }else {SM15=true;SendMail("MixSystems Sell"+Symbol(),"Депо ="+AccountEquity());}
  } }
   if (((Minute()==30)||(Minute()==00))&&(TM30==true)) {
    if ((OpenOrder_30==false)&&((iMA(NULL,30,MA_30,0,MODE_SMA,PRICE_CLOSE,1)-filtr_30*Point*k)>Close[1])&&(iATR(NULL,30,22,1)>0.0002)&&(iWPR(NULL,30,WPR_30,1)>-5)&&(iCCI(Symbol(),30,CCI_30,PRICE_TYPICAL,1)>90)) { 
   Start30=CloseAt_30;
        Print("Открываемся на sell m30");
        RefreshRates();
  if(    OrderSend(Symbol(),OP_SELL,lot*Kof,Bid,Slipage*k,NULL,NULL,"M30",Magic_Number,0,Red) < 0) 
      { 
        Alert("Ошибка открытия позиции № ", GetLastError());
      }else {SM30=true;SendMail("MixSystems Sell"+Symbol(),"Депо ="+AccountEquity());}
  } }
   if (((Minute()==00))&&(TM60==true)) {
    if ((OpenOrder_60==false)&&((iMA(NULL,60,MA_60,0,MODE_SMA,PRICE_CLOSE,1)-filtr_60*Point*k)>Close[1])&&(iATR(NULL,60,22,1)>0.0002)&&(iWPR(NULL,60,WPR_60,1)>-5)&&(iCCI(Symbol(),60,CCI_60,PRICE_TYPICAL,1)>90)) { 
   Start60=CloseAt_60;
           Print("Открываемся на sell m60");
           RefreshRates();
  if(    OrderSend(Symbol(),OP_SELL,lot*Kof,Bid,Slipage*k,NULL,NULL,"M60",Magic_Number,0,Red) < 0) 
      { 
        Alert("Ошибка открытия позиции № ", GetLastError());
      }else {SM60=true;SendMail("MixSystems Sell"+Symbol(),"Депо ="+AccountEquity());}
  }   }
  
   Sleep(SleepTime*100);

     

   
   
   
   
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

