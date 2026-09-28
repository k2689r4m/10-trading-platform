const WebSocket = require('ws');
const axios = require('axios');
const dbcon = require("./dbcon");
const dayjs = require('dayjs');
const utc = require('dayjs/plugin/utc');
const timezone = require('dayjs/plugin/timezone');
const dt = require("./data");
const Binance = require('node-binance-api');
const schedule = require("node-schedule");
const { customAlphabet } = require('nanoid')
const alphabet = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
const nanoid = customAlphabet(alphabet, 10);

const { RestClientV5, WebsocketClient } = require('bybit-api');
const bybitOptions = {
    key: '',
	secret: '',
};
  





require('dayjs/locale/ko');
dayjs.locale('ko');
dayjs.extend(utc);
dayjs.extend(timezone);

var exports = module.exports = {};
let ACCESS_TOKEN = '';
let bybit = {};

let io = null;

const testnet = false;

const symbolList = [
  'BTCUSDT',
  'ETHUSDT',
  'SOLUSDT',
  'XRPUSDT',
]

let DB_candleUpDown = [];

const getKorTime = (time) => {
  return dayjs(Number(time)).tz('Asia/Seoul').format('YYYY-MM-DD HH:mm:ss') == 'Invalid Date'
    ? dayjs(time).tz('Asia/Seoul').format('YYYY-MM-DD HH:mm:ss')
    : dayjs(Number(time)).tz('Asia/Seoul').format('YYYY-MM-DD HH:mm:ss');
}

const sleep = (ms) => {
    return new Promise(resolve=>{
        setTimeout(resolve,ms)
    })
}

const socketInit = async () => {
  if(!io){
      console.log('socketInit !!!')
      io = require('./routes/socket');
      
      // io.wsOneSend(1,'test', {msg: '123132132'});

      // console.log(io.users);
      // wsOneSend(1,'test', {data: '123132132'})
  }
}


const reOrderGet2 = (uid_, data) => {
  // Rejected
  // PartiallyFilledCanceled
  // Filled
  // Cancelled
  // Triggered
  // Deactivated

  const status = data.orderStatus;        // 실행 타입 (Filled)
  const oid = data.orderId; 
  const cData = data.orderLinkId.split('_');

  const uid = cData[1];
  const pid = cData[2];
  const orderID = cData[3];
  const retry = cData[4];

  const symbol = data.symbol;
  const side = data.side.toUpperCase();          //BUY or SELL
  const tradeType = data.orderType.toUpperCase();     //MARKET, LIMIT
  const price = data.avgPrice;
  const qty = data.cumExecQty;         //수량
  const allQty = data.qty;
  const charge = data.cumExecFee;        //수수료
  const pnl = data.closedPnl;        //실현 손익 (Realized PnL)
  const updateTime = data.createdTime;        //체결 시간
  const leavesQty = data.leavesQty;     //남은 수량

  const rejectReason = data.rejectReason;

  // console.log('-----------------------------------');
  // console.log(data);
  // console.log('-----------------------------------');
 

  try{
    //첫주문


    if(cData[0] == 'N'){
        // if(status != 'Filled'){
        //   if(status == 'Cancelled'){
        //     // dbcon.DBOneCall(`CALL SP_ORDER_ADD2(?,?,?,?,?,?,?,?,?)`,[
        //     //   'NEW_RUN',
        //     //   uid,
        //     //   pid,
        //     //   data.symbol,
        //     //   data.side.toUpperCase(),
        //     //   parseFloat(data.qty) - parseFloat(data.cumExecQty),
        //     //   null,
        //     //   null,
        //     //   null,
        //     // ]);
        //     dbcon.DBCall(`CALL SP_ORDER_UPDATE_STATUS(?,?,?)`,[pid, 'NEW_RUN', dt.cool.NEW_RUN]);
        //   }else{
        //     exports.msgAdd('NEW',status, rejectReason, uid, pid, null, symbol, side);
        //   }
        // }

        // if(qty){
        //   const positionSize = parseFloat(price) * parseFloat(qty);
        //   dbcon.DBCall(`CALL SP_LIVE_PLAY_ST_NEW_EXACT_UPDATE(?,?,?,?,?,?,?)`,[pid, uid, price, data.cumExecQty, positionSize, charge, status=='FILLED' ? 1 : 0]);
        // }

        if(status == 'Filled' || status == 'Cancelled'){
          // dbcon.DBCall(`CALL SP_LIVE_PLAY_ST_EDIT(?,?)`,[pid, 'EXACT']);
          // dbcon.DBCall(`CALL SP_ORDER_UPDATE_STATUS(?,?,?)`,[pid, 'RUN', dt.cool.RUN]);

          // dbcon.DBOneCall(`CALL SP_LIVE_PLAY_ST_NEW_GET(?)`,[pid]).then((re)=>{
          //   if(re.stopLoss){
          //     exports.sendLimit(symbol, side, re.stopLoss, price, allQty, uid, pid, 'L_'+uid+'_'+pid+'_'+orderID);
          //   }
          // })

          // console.log(`소켓 NEW :: ${status}`);
          // console.log(data)
          dbcon.DBCall(`CALL SP_ORDER_UPDATE_STATUS(?,?,?)`,[pid, 'NEW_RUN', 10]);
        }
    }
    else if((cData[0] == 'P' || cData[0] == 'S' || cData[0] == 'TS' || cData[0] == 'F' || cData[0] == 'L')){
        // console.log(`CLOSE ------------- ${cData[0]}, ${status}`);
        // console.log(data);
        // console.log(`charge: ${charge}, pnl: ${pnl}`);

        // if(status != 'Filled' && cData[0] != 'L'){
        //   if(status == 'Cancelled'){
        //     dbcon.DBCall(`CALL SP_LIVE_PLAY_ST_NEW_UPDATE(?,?)`,[pid, charge]);

        //     // dbcon.DBOneCall(`CALL SP_ORDER_ADD2(?,?,?,?,?,?,?,?,?)`,[
        //     //   'CLOSE_RUN',
        //     //   uid,
        //     //   pid,
        //     //   data.symbol,
        //     //   data.side.toUpperCase() == 'BUY' ? 'SELL' : 'BUY',
        //     //   parseFloat(data.qty) - parseFloat(data.cumExecQty),
        //     //   null,
        //     //   null,
        //     //   cData[0],
        //     // ]);

        //     dbcon.DBCall(`CALL SP_ORDER_UPDATE_STATUS(?,?,?)`,[pid, 'CLOSE', dt.cool.CLOSE]);



        //   }else{
        //     exports.msgAdd('CLOSE',status, rejectReason, uid, pid, null, symbol, side);
        //   }
        // }else if(status == 'Filled'){
        //   dbcon.DBCall(`CALL SP_LIVE_PLAY_ST_NEW_UPDATE(?,?)`,[pid, charge]).then(()=>{
        //     dbcon.DBOneCall(`CALL SP_LIVE_PLAY_ST_NEW_GET(?)`,[pid]).then((re)=>{
        //       // let rePrice = re.r_exactPrice - price;
        //       let endType = null; 
  
        //       if(cData[0] == 'F'){
        //         if(0 < pnl){
        //           endType = 'PROFIT'
        //         }else{
        //           endType = 'STOP'
        //         }
        //       }else{
        //         endType = cData[0] == 'TS' ? 'PROFIT' : cData[0];
        //       }
  
  
              
        //       const positionSize = re.leverage * re.margin;
        //       // console.log(`수수료:${charge}, 전 수수료:${re.r_t_charge}`);
        //       dbcon.DBCall(`CALL SP_LIVE_PLAY_ST_NEW_CLOSE(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)`,[
        //           uid,
        //           pid,
        //           re.r_tid,
        //           oid,   
  
        //           endType,
  
        //           re.symbol,
        //           re.leverage,
        //           re.margin,
        //           positionSize,
  
        //           re.type,
        //           re.bunbong,
  
        //           re.r_signalType,
        //           re.r_signalPrice,
        //           re.r_signalTime,
  
        //           re.r_exactPrice,
        //           price,
  
        //           pnl,
        //           pnl,
  
        //           pnl > 0 ? true : false,
        //           pnl < 0 ? true : false,
  
        //           charge,  //수수료
        //           parseFloat(charge)+parseFloat(re.r_t_charge),
        //           re.r_exactTime,
        //           getKorTime(updateTime),
        //       ]);

        //       cancelOrder(re.symbol, uid, re.algoId);
  
        //       // repeatConfig
        //       // repeat: 자동반복, stopLoss: 손절 시 반복 멈춤, once: 1회만 진입
        //       if(cData[0] == 'F'){
        //         dbcon.DBCall(`CALL SP_LIVE_PLAY_SET_ST(?,?,?)`, [re.id, re.autoST == 'Y' ? 'START' : 'STOP','READY',]);
        //       }else{
        //         if(re.autoST == 'Y'){
        //           if(re.repeatConfig == 'repeat'){
        //               dbcon.DBCall(`CALL SP_LIVE_PLAY_SET_ST2(?,?,?,?)`, [re.id, 'START','READY','Y']);
        //           }else if(re.repeatConfig == 'stopLoss' && cData[0] == 'PROFIT'){
        //               dbcon.DBCall(`CALL SP_LIVE_PLAY_SET_ST2(?,?,?,?)`, [re.id, 'START','READY','Y']);
        //           }else{
        //               dbcon.DBCall(`CALL SP_LIVE_PLAY_SET_ST2(?,?,?,?)`, [re.id, 'STOP','READY','N']);
        //           }
        //         }else{
        //             dbcon.DBCall(`CALL SP_LIVE_PLAY_SET_ST2(?,?,?,?)`, [re.id, 'STOP','READY','N']);
        //         }
        //       }
        //       dbcon.DBCall(`CALL SP_LIVE_PLAY_INIT(?)`, [re.id]);
        //       dbcon.DBCall(`CALL SP_ORDER_DEL(?)`,[re.id]);
        //     });



        //   })
          
        // }

        if(status == 'Filled' || status == 'Cancelled'){
          // console.log(`소켓 CLOSE :: ${status}`);
          // console.log(data)
          dbcon.DBCall(`CALL SP_ORDER_UPDATE_STATUS(?,?,?)`,[pid, 'CLOSE', 1]);
        }
        
    }






  }catch(e){
      console.log(e);
  }
}

const initAPI = async (uid, APP_KEY, APP_SECRET) => {
  console.log(`START initAPI ID:${uid} !!`);

  bybit[uid] = new RestClientV5({
    key: APP_KEY,
    secret: APP_SECRET,
    testnet: testnet,
  });

  await bybit[uid].postPrivate(
    '/v5/position/switch-mode',
    {
      category: 'linear',
      mode: 3,
      coin: "USDT",
    }
  );
  
  const ws = new WebsocketClient({
    key: APP_KEY,
    secret: APP_SECRET,
    testnet: testnet,
  });
    
  

  // ws.subscribeV5('order', 'linear');

  // 데이터 수신
  ws.on('update', (msg) => {
    // if (msg.topic !== 'execution') return;

    msg.data.forEach((exec) => {
        reOrderGet2(uid, exec);
    });
    
  });

  // 연결 열림
  ws.on('open', () => {
    console.log('#[initAPI] Private WS 연결 완료');
  });

  // 에러
  ws.on('exception', (err) => {
    console.error('#[initAPI] WS 에러', uid, err);
  });

  // 재연결
  ws.on('reconnected', () => {
    console.log('#[initAPI] WS 재연결 완료');
  });

  // reOrderGet(uid, data);

  // 개인 체결 구독
  // ws.subscribeV5('execution', 'linear');
  ws.subscribeV5('order', 'linear');
  // ws.subscribeV5('position', 'linear');

  // const res = await bybit[uid].getExecutionList({
  //   category: 'linear',
  //   // symbol: 'BTCUSDT',
  // });

  // const orders = await bybit[uid].getHistoricOrders({
  //   category: 'linear',
  //   // symbol: 'BTCUSDT',
  // });

  // console.log(orders.result.list[0]);

  // let xx = 0;
  // for(let i=0;i<res.result.list.length;i++){
  //   const item = res.result.list[i];
  //   if(item.orderLinkId == 'N_1_1_JxkVsV6iYN'){
  //     xx += parseFloat(item.execQty);
  //   }
  // }
  // console.log(xx);


  // const positions = await bybit[uid].getPositionInfo({
  //   category: 'linear', // USDT 선물
  //   symbol: 'XRPUSDT',  // 특정 심볼 (없으면 전체)
  // });
  
  // console.log(positions.result.list);
  

  const symbol = 'ETHUSDT';
  const side = 'Buy';
  const qty = 71;
  const r_exactPrice = 5000;

}

const getCandlePer = async (interval) => {
  // await sleep(5000);
  const binance = new Binance();
  let cc = 0;
  for(let i=0;i<symbolList.length;i++){
      try{
          const s = symbolList[i];
          const openPrice = parseFloat((await binance.futuresCandles(symbol = s, interval = interval, {limit: 2}))[1].open);
          // const curPrice = parseFloat(dt.price[s].bestBid);
          // const changePercent = ((curPrice - openPrice) / openPrice) * 100;
          
          const interval_ = timeStrInt[interval];
  
          dbcon.DBCall(`CALL SP_CAGR_UP_DOWN_ADD(?,?,?)`,[
              s,
              interval_,
              openPrice,
          ])

          cc = 0;
      }catch(e){
          cc++;

          if(cc < 5) i--;

          await sleep(1000);

          continue;
      }
      
  }
}


const getCandleUpDown = async (symbol, curPrice) => {
  Object.entries(timeStrInt).forEach(([period, candle]) => {
      for(let i=0;i<DB_candleUpDown.length;i++){
          if(symbol != DB_candleUpDown[i].symbol || candle != DB_candleUpDown[i].candle){
              continue;
          }

          const openPrice = DB_candleUpDown[i].price;
          const s = DB_candleUpDown[i].symbol;
          // const curPrice = parseFloat(dt.price[s].bestBid);
          const changePercent = ((curPrice - openPrice) / openPrice) * 100;
          // console.log(`[${s}] ${candle} ${openPrice}, ${changePercent.toFixed(2)}`);

          dbcon.DBCall(`CALL SP_CAGR_UP_DOWN_PER_EDIT(?,?,?)`,[
              s,
              candle,
              changePercent.toFixed(2),
          ])
          .then((re)=>{})
          .catch((e)=>{});

          DB_candleUpDown[i].per = parseFloat(changePercent.toFixed(2));
      }
  });

}


const getTick = async () => {
  const wsConfig = {
    testnet: testnet // 실제 거래소 데이터
  };
  
  const tickerTopics = symbolList.map(
    (symbol) => `tickers.${symbol}`
  );


  const ws = new WebsocketClient(wsConfig);

  ws.subscribeV5([...tickerTopics], 'linear');
  // ws.subscribeV5('tickers.BTCUSDT', 'linear');

  ws.on('update', (msg) => {
    try{
      const { topic, data } = msg;

      // 📈 현재가
      if (topic.startsWith('tickers.')) {
        let prev = dt.price[data.symbol] || {
          symbol: data.symbol,
          bestBid: 0,
          bestBidQty: 0,
          bestAsk: 0,
          bestAskQty: 0,
        };
                
        // 새로 들어온 데이터
        const next = {
          symbol: data.symbol,
          bestBid: data.bid1Price,
          bestBidQty: data.bid1Size,
          bestAsk: data.ask1Price,
          bestAskQty: data.ask1Size,
        };

        // undefined면 기존 값 유지
        const merged = {
          symbol: prev.symbol,
          bestBid: next.bestBid ?? prev.bestBid,
          bestBidQty: next.bestBidQty ?? prev.bestBidQty,
          bestAsk: next.bestAsk ?? prev.bestAsk,
          bestAskQty: next.bestAskQty ?? prev.bestAskQty,
        };

        dt.price[data.symbol] = merged;

        if(dt.price[merged.symbol]?.bestBid != merged.bestBid || dt.price[merged.symbol]?.bestAsk != merged.bestAsk){
          getCandleUpDown(merged.symbol,  parseFloat(merged.bestBid));
      }
      }
  
      
    }catch(e){
      console.log('getTick ###!!! ERR:: ', e);
    }
    
  });

  
  // 연결 열림
  ws.on('open', ({ wsKey }) => {
    // console.log('#[getTick] WebSocket 연결됨');
  });

  // 구독 응답
  ws.on('response', (res) => {
    if (res.success === false) {
      // console.error('#[getTick] 구독 실패:', res);
    }
  });

  // 에러
  ws.on('exception', (err) => {
    // console.error('#[getTick] WS 에러:', err);
  });

  // 재연결
  ws.on('reconnected', ({ wsKey }) => {
    // console.log('#[getTick] 재연결 완료');
  });

  
}
let ttt = true;
const getUserBalance = async () => {
  setInterval(async () => {
      try{
          dbcon.DBCall(`CALL SP_A_MEMBER_KEY_ALL_GET()`).then((keyList)=>{
              keyList.forEach((k)=>{
                  const uid = k.id;
                  if(!bybit[uid]){
                    return;
                  }
                  const client = bybit[uid];

                  client
                  .getWalletBalance({
                    accountType: 'UNIFIED',
                    coin: 'USDT',
                  })
                  .then((re) => {
                    // if(uid == 5){
                    //   console.log(re.result.list[0].coin);
                    // }

                    let price = 0;
                    if(re.result?.list){
                      const account = re.result.list.find(a => a.accountType === 'UNIFIED');
                      const usdt = account.coin.find(c => c.coin === 'USDT');
                      const equity = Number(usdt.equity);
                      const positionIM = Number(usdt.totalPositionIM);
                      const orderIM = Number(usdt.totalOrderIM);
  
                      price = equity - positionIM - orderIM;
                    }

                    dbcon.DBCall(`CALL SP_LIVE_PLAY_PRICE_SET(?,?)`,[uid, price]);



                    // if(re.result?.list && re.result.list[0].totalAvailableBalance){
                    //   const balance = re.result.list[0];

                    //   dbcon.DBCall(`CALL SP_LIVE_PLAY_PRICE_SET(?,?)`,[uid, balance.totalAvailableBalance]);
                    // }

                    // if(ttt){
                    //   ttt = false;

                    //   exports.sendEnter(
                    //     'BTCUSDT',
                    //     'Buy',
                    //     10,
                    //     10,
                    //     1,
                    //     1,
                    //     null,
                    //     null
                    //   );

                    //   // exports.sendForcing(null,'BTCUSDT','Sell',null,null,null,null,null);

                      
  
                    // }
                   
                    
                  })
                  .catch((error) => {
                    console.error('Market order error', error);
                  });
              });
          }).catch((eee)=>{
              console.log('ERR :: getPrice  111 !! -------------');
              console.log(eee);
          });
  
          
      }catch(e){
          console.log('ERR :: getPrice !! -------------');
          console.log(e);
      }
  }, 5000); // 30분
}

const isCooldownOver = (coolTimeStr) => {
  if (!coolTimeStr) return true;

  const coolTime = new Date(coolTimeStr);
  return new Date() >= coolTime;
}

const runTrade = async () => {
  await sleep(3000);

  let ss = false;

  while (true) {
    const orderList = await dbcon.DBCall(`CALL SP_ORDER_GET()`);

    if(ss){
      const ccc = bybit[2];
      const re = await ccc.getHistoricOrders({
        category: 'linear',
        symbol: 'XRPUSDT',
      });

      console.table(
        re.result.list.map(v => ({
          createType: v.createType,
          symbol: v.symbol,
          orderLinkId: v.orderLinkId,
          orderType: v.orderType,
          stopOrderType: v.stopOrderType,
          status: v.orderStatus,
          side: v.side,
          triggerPrice: v.triggerPrice,
          qty: v.qty,
          execQty: v.cumExecQty,
          avgPrice: v.avgPrice,
          orderId: v.orderId,
          created: getKorTime(v.createdTime)
        }))
      );

      ss = false;
    }


    for(let x=0;x<orderList.length;x++){
      const order = orderList[x];

      try {
        if (!order) {
          await sleep(500);
          continue;
        }
  
        if(!isCooldownOver(order.coolTime)){
          continue;
        }
  
        if(3 <= order.retry){
          await dbcon.DBCall(`CALL SP_ORDER_DEL(?)`,[order.pid]);
          exports.msgAdd('runTrade',404, 'retry >= 3', order.uid, order.pid, null, order.symbol, order.side);
  
          // dbcon.DBCall(`CALL SP_LIVE_PLAY_INIT(?)`, [order.pid]);
          // dbcon.DBCall(`CALL SP_LIVE_PLAY_STOP(?)`, [order.pid]);
          continue;
        }
  
        const client = bybit[order.uid];
        const play = await dbcon.DBOneCall(`CALL SP_LIVE_PLAY_ST_NEW_GET(?)`,[order.pid]);

        // console.log(play.id, play.status, order.st);
        
        if (order.st === 'NEW_START') {
          await dbcon.DBCall(`CALL SP_ORDER_UPDATE_STATUS(?,?,?)`,[play.id, 'NEW_START', dt.cool.NEW_START]);
          await exports.sendEnter(
            order.symbol,
            order.side,
            order.leverage,
            order.margin,
            order.uid,
            order.pid,
            order.id,
            'N',
            null,
          );
        } else if (order.st === 'NEW_RUN') {
          const oidList = JSON.parse(order.new_oid);
          const oid = oidList[oidList.length-1];
  
          const re = await client.getActiveOrders({
            category: 'linear',
            symbol: order.symbol,
            orderId: oid,
          });
  
          const reData = re.result.list[0];
          await dbcon.DBCall(`CALL SP_ORDER_UPDATE_STATUS(?,?,?)`,[play.id, order.st, dt.cool.NEW_RUN]);
        
          if(play.status == 'ENTER'){
            if(reData.orderStatus == 'New'){
              await dbcon.DBCall(`CALL SP_ORDER_UPDATE_STATUS(?,?,?)`,[play.id, 'NEW_RUN', dt.cool.NEW_RUN]);
            }else if(reData.orderStatus == 'PartiallyFilled'){
              await dbcon.DBCall(`CALL SP_ORDER_UPDATE_STATUS(?,?,?)`,[play.id, 'NEW_RUN', dt.cool.NEW_RUN]);
            }else if(reData.orderStatus == 'Untriggered'){
              await dbcon.DBCall(`CALL SP_ORDER_UPDATE_STATUS(?,?,?)`,[play.id, 'NEW_RUN', dt.cool.NEW_RUN]);
            }else if(reData.orderStatus == 'Rejected'){
              exports.msgAdd('NEW_RUN', `Rejected : ${reData.rejectReason}`, reData.status, play.uid, play.id, null, play.symbol, play.r_signalType);
  
              dbcon.DBCall(`CALL SP_LIVE_PLAY_SET_ST2(?,?,?,?)`, [play.id, 'STOP','READY','N']);
              dbcon.DBCall(`CALL SP_LIVE_PLAY_INIT(?)`, [play.id]);
              await dbcon.DBCall(`CALL SP_ORDER_DEL(?)`,[play.id]);
            }else if(reData.orderStatus == 'Triggered'){
              await dbcon.DBCall(`CALL SP_ORDER_UPDATE_STATUS(?,?,?)`,[play.id, 'NEW_RUN', dt.cool.NEW_RUN]);
            }else if(reData.orderStatus == 'Deactivated'){
              await dbcon.DBCall(`CALL SP_ORDER_UPDATE_STATUS(?,?,?)`,[play.id, 'NEW_RUN', dt.cool.NEW_RUN]);
            }else if(reData.orderStatus == 'Cancelled'){
              await dbcon.DBCall(`CALL SP_ORDER_UPDATE_STATUS(?,?,?)`,[play.id, 'NEW_RUN', dt.cool.NEW_RUN]);
              exports.sendEnter2(
                order.symbol,
                order.side,
                parseFloat(reData.qty) - parseFloat(reData.cumExecQty),
                order.uid,
                order.pid,
                oid,
                order.retry,
              );
            }else if(reData.orderStatus == 'PartiallyFilledCanceled '){
              
            }else if(reData.orderStatus == 'Filled'){
              // await dbcon.DBCall(`CALL SP_LIVE_PLAY_ST_NEW_EXACT_UPDATE2(?,?,?,?,?,?,?)`,[play.id, play.uid, reData.avgPrice, reData.cumExecQty, reData.cumExecValue, reData.cumExecFee, getKorTime(reData.updatedTime)]);
  
              let avgPrice = 0;
              let cumExecQty = 0;
              let cumExecValue = 0;
              let cumExecFee = 0;
              let cnt = 0;
              for(let i=0;i<oidList.length;i++){
                const o = oidList[i];
                const reOrder_ = await client.getActiveOrders({
                  category: 'linear',
                  symbol: order.symbol,
                  orderId: o,
                });
                const reOrder = reOrder_.result.list[0];
  
                if(!reOrder.avgPrice){
                  continue;
                }
      
                avgPrice += reOrder.avgPrice;
                cumExecQty += reOrder.cumExecQty;
                cumExecValue += reOrder.cumExecValue;
                cumExecFee += reOrder.cumExecFee;
                cnt++;
                
                await sleep(300);
              }
              
              // console.log(
              //   '1111111', play.id, play.uid, avgPrice, cnt, cumExecQty, cumExecValue, cumExecFee, 1
              // );

              await dbcon.DBCall(`CALL SP_LIVE_PLAY_ST_NEW_EXACT_UPDATE(?,?,?,?,?,?,?)`,[play.id, play.uid, avgPrice / cnt, cumExecQty, cumExecValue, cumExecFee, 1]);
  
  
              // if(play.stopLoss && !play.algoId){
              //   exports.sendLimit(play.symbol, play.r_signalType, play.stopLoss, reData.avgPrice, reData.cumExecQty, play.uid, play.id, 'L_'+play.uid+'_'+play.id+'_'+oid);
              // }
  
              await dbcon.DBCall(`CALL SP_LIVE_PLAY_ST_EDIT(?,?)`,[play.id, 'EXACT']);
              await dbcon.DBCall(`CALL SP_ORDER_UPDATE_STATUS(?,?,?)`,[play.id, 'RUN', dt.cool.RUN]);
            }else{
              exports.msgAdd('NEW_RUN', 'EXPIRED_IN_MATCH', reData.status, play.uid, play.id, null, play.symbol, play.r_signalType);
              dbcon.DBCall(`CALL SP_LIVE_PLAY_SET_ST2(?,?,?,?)`, [play.id, 'STOP','READY','N']);
              dbcon.DBCall(`CALL SP_LIVE_PLAY_INIT(?)`, [play.id]);
              await dbcon.DBCall(`CALL SP_ORDER_DEL(?)`,[play.id]);
            }
  
          }else if(play.status == 'EXACT'){
            const pos = await client.getPositionInfo({
              category: 'linear',
              symbol: order.symbol,
            });
      
            const longPos = pos.result.list.find(v =>
              v.positionIdx === 1
            );
      
            const currentQty = Number(longPos?.size || 0);
      
            if (currentQty >= play.r_qty) {
              await dbcon.DBCall(`CALL SP_ORDER_UPDATE_STATUS(?,?,?)`,[play.id, 'RUN', dt.cool.RUN]);
            } else {
              if(play.stopLoss && play.algoId){
                // cancelOrder(play.symbol, play.uid, play.algoId);
              }
  
              exports.msgAdd('RUN', '이미종료', `이미종료된 포지션입니다.`, play.uid, play.id, null, play.symbol, play.r_signalType);
              dbcon.DBCall(`CALL SP_LIVE_PLAY_SET_ST2(?,?,?,?)`, [play.id, 'STOP','READY','N']);
              dbcon.DBCall(`CALL SP_LIVE_PLAY_INIT(?)`, [play.id]);
              await dbcon.DBCall(`CALL SP_ORDER_DEL(?)`,[play.id]);
              continue;
            }
          }
  
        } else if (order.st === 'FAIL_RUN') {
          const oidList = JSON.parse(order.new_oid);
          const oid = oidList[oidList.length-1];
        
          const re = await client.getActiveOrders({
            category: 'linear',
            symbol: order.symbol,
            orderId: oid,
          });
  
          const reData = re.result.list[0];
          await dbcon.DBCall(`CALL SP_ORDER_UPDATE_STATUS(?,?,?)`,[play.id, order.st, dt.cool.FAIL_RUN]);
  
  
          let avgPrice = 0;
          let cumExecQty = 0;
          let cumExecValue = 0;
          let cumExecFee = 0;
          let cnt = 0;
          for(let i=0;i<oidList.length;i++){
            const o = oidList[i];
            const reOrder_ = await client.getActiveOrders({
              category: 'linear',
              symbol: order.symbol,
              orderId: o,
            });
            const reOrder = reOrder_.result.list[0];
  
            if(!reOrder.avgPrice){
              continue;
            }
  
            avgPrice += parseFloat(reOrder.avgPrice);
            cumExecQty += parseFloat(reOrder.cumExecQty);
            cumExecValue += parseFloat(reOrder.cumExecValue);
            cumExecFee += parseFloat(reOrder.cumExecFee);
            cnt++;
  
            await sleep(300);
          }
          
          // console.log(
          //   '2222222',
          //   play.id, 
          //   play.uid, 
          //   avgPrice,
          //   cnt, 
          //   cumExecQty, 
          //   cumExecValue, 
          //   cumExecFee, 
          //   1
          // );
          await dbcon.DBCall(`CALL SP_LIVE_PLAY_ST_NEW_EXACT_UPDATE(?,?,?,?,?,?,?)`,[
            play.id, 
            play.uid, 
            avgPrice / cnt, 
            cumExecQty, 
            cumExecValue, 
            cumExecFee, 
            1
          ]);
  
  
  
          // if(play.stopLoss && !play.algoId){
          //   exports.sendLimit(play.symbol, play.r_signalType, play.stopLoss, reData.avgPrice, reData.cumExecQty, play.uid, play.id, 'L_'+play.uid+'_'+play.id+'_'+oid);
          // }
  
          await dbcon.DBCall(`CALL SP_LIVE_PLAY_ST_EDIT(?,?)`,[play.id, 'EXACT']);
          await dbcon.DBCall(`CALL SP_ORDER_UPDATE_STATUS(?,?,?)`,[play.id, 'RUN', dt.cool.RUN]);
  
  
        } else if (order.st === 'RUN') {
          await dbcon.DBCall(`CALL SP_ORDER_UPDATE_STATUS(?,?,?)`,[play.id, 'RUN', dt.cool.RUN]);
          // if(play.status == 'EXACT'){
          //   const pos = await client.getPositionInfo({
          //     category: 'linear',
          //     symbol: order.symbol,
          //   });
      
          //   const longPos = pos.result.list.find(v =>
          //     v.positionIdx === 1
          //   );
      
          //   const currentQty = Number(longPos?.size || 0);
            
          //   if (currentQty >= play.r_qty) {
          //     await dbcon.DBCall(`CALL SP_ORDER_UPDATE_STATUS(?,?,?)`,[play.id, 'RUN', dt.cool.RUN]);
          //   } else {
          //     if(play.stopLoss && play.algoId){
          //       cancelOrder(play.symbol, play.uid, play.algoId);
          //     }
  
          //     exports.msgAdd('RUN', '이미종료', `이미종료된 포지션입니다.`, play.uid, play.id, null, play.symbol, play.r_signalType);
          //     dbcon.DBCall(`CALL SP_LIVE_PLAY_SET_ST2(?,?,?,?)`, [play.id, 'STOP','READY','N']);
          //     dbcon.DBCall(`CALL SP_LIVE_PLAY_INIT(?)`, [play.id]);
          //     await dbcon.DBCall(`CALL SP_ORDER_DEL(?)`,[play.id]);
          //     continue;
          //   }
          // }
        } else if (order.st === 'NEW_CLOSE') {
          await dbcon.DBCall(`CALL SP_ORDER_UPDATE_STATUS(?,?,?)`,[play.id, 'NEW_CLOSE', dt.cool.NEW_CLOSE]);
  
          exports.sendForcing(
            order.endType,
            order.symbol,
            order.side,
            order.qty,
            order.uid,
            order.pid,
            order.id,
            order.retry,
          );
  
          if(play.stopLoss && play.algoId){
            // cancelOrder(play.symbol, play.uid, play.algoId);
          }
  
        } else if (order.st === 'CLOSE') {  
          if(!order.close_oid){
            exports.msgAdd('RUN', '이미종료', `이미종료된 포지션입니다.`, play.uid, play.id, null, play.symbol, play.r_signalType);
            dbcon.DBCall(`CALL SP_LIVE_PLAY_SET_ST2(?,?,?,?)`, [play.id, 'STOP','READY','N']);
            dbcon.DBCall(`CALL SP_LIVE_PLAY_INIT(?)`, [play.id]);
            await dbcon.DBCall(`CALL SP_ORDER_DEL(?)`,[play.id]);
            continue;
          }
          
          const oidList = JSON.parse(order.close_oid);
          const oid = oidList[oidList.length-1];
  
          const re = await client.getActiveOrders({
            category: 'linear',
            symbol: order.symbol,
            orderId: oid,
          });
  
          const reData = re.result.list[0];
          await dbcon.DBCall(`CALL SP_ORDER_UPDATE_STATUS(?,?,?)`,[play.id, order.st, dt.cool.CLOSE]);
  
          if(reData.orderStatus == 'New'){
            await dbcon.DBCall(`CALL SP_ORDER_UPDATE_STATUS(?,?,?)`,[play.id, 'CLOSE', dt.cool.CLOSE]);
          }else if(reData.orderStatus == 'PartiallyFilled'){
            await dbcon.DBCall(`CALL SP_ORDER_UPDATE_STATUS(?,?,?)`,[play.id, 'CLOSE', dt.cool.CLOSE]);
          }else if(reData.orderStatus == 'Cancelled'){
            await dbcon.DBCall(`CALL SP_ORDER_UPDATE_STATUS(?,?,?)`,[play.id, 'CLOSE', dt.cool.CLOSE]);
            // console.log(parseFloat(reData.qty) - parseFloat(reData.cumExecQty ? reData.cumExecQty : 0 ));
            exports.sendForcing2(
              order.symbol,
              order.side,
              parseFloat(reData.qty) - parseFloat(reData.cumExecQty ? reData.cumExecQty : 0 ),
              order.uid,
              order.pid,
              oid,
              order.retry,
            );
  
          }else if(reData.orderStatus == 'Filled'){
            let charge = 0;
            let avgPrice = 0;
            let qty = 0;
            let execValue = 0;
            let pnl = 0;
            let cnt = 0;
  
            for(let i=0;i<oidList.length;i++){
              const o = oidList[i];
              const pnlList = await client.getClosedPnL({
                category: 'linear',
                symbol: order.symbol,
              });
              
              const item = pnlList.result.list.find(v =>
                v.orderId === o
              );
  
              // console.log(item);
              // if(!item.closedPnl){
              //   await dbcon.DBCall(`CALL SP_ORDER_UPDATE_STATUS(?,?,?)`,[play.id, 'CLOSE', dt.cool.CLOSE]);
              //   continue;
              // }

              if(!(item?.closedPnl)){
                continue;
              }
              
              pnl += parseFloat(item.closedPnl);
  
              await sleep(300);
            }
      
            for(let i=0;i<oidList.length;i++){
              const o = oidList[i];
              const reOrder_ = await client.getActiveOrders({
                category: 'linear',
                symbol: order.symbol,
                orderId: o,
              });
              const reOrder = reOrder_.result.list[0];
  
              if(!(reOrder?.avgPrice)){
                continue;
              }
  
              qty += parseFloat(reOrder.cumExecQty);
              charge += parseFloat(reOrder.cumExecFee);
              avgPrice += parseFloat(reOrder.avgPrice);
              execValue += parseFloat(reOrder.cumExecValue);
              cnt++;
  
              await sleep(300);
            }
  
  
  
            avgPrice = avgPrice / cnt;
  
            await dbcon.DBCall(`CALL SP_LIVE_PLAY_ST_NEW_UPDATE(?,?)`,[play.id, charge]);
            
            // console.log(`총 수익: ${pnl}, 수수료: ${charge},   ${play.r_t_charge}`)
  
            let endType = null;
  
            if(order.endType == 'F'){
              if(0 < pnl){
                endType = 'PROFIT'
              }else{
                endType = 'STOP'
              }
            }else{
              endType = order.endType == 'TS' ? 'PROFIT' : order.endType;
            }
  
            await dbcon.DBCall(`CALL SP_LIVE_PLAY_ST_NEW_CLOSE(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)`,[
              play.uid,
              play.id,
              play.r_tid,
              oid,   
  
              endType,
  
              play.symbol,
              play.leverage,
              play.margin,
              execValue,
  
              play.type,
              play.bunbong,
  
              play.r_signalType,
              play.r_signalPrice,
              play.r_signalTime,
  
              play.r_exactPrice,
              avgPrice,
  
              pnl,
              pnl,
  
              pnl > 0 ? true : false,
              pnl < 0 ? true : false,
  
              charge,  //수수료
              parseFloat(charge)+parseFloat(play.r_t_charge),
              play.r_exactTime,
              getKorTime(reData.createdTime),
            ]);
  
            // cancelOrder(play.symbol, play.uid, play.algoId);
  
            if(order.endType == 'F'){
              dbcon.DBCall(`CALL SP_LIVE_PLAY_SET_ST(?,?,?)`, [play.id, play.autoST == 'Y' ? 'START' : 'STOP','READY',]);
            }else{
              if(play.autoST == 'Y'){
                if(play.repeatConfig == 'repeat'){
                    dbcon.DBCall(`CALL SP_LIVE_PLAY_SET_ST2(?,?,?,?)`, [play.id, 'START','READY','Y']);
                }else if(play.repeatConfig == 'stopLoss' && order.endType == 'PROFIT'){
                    dbcon.DBCall(`CALL SP_LIVE_PLAY_SET_ST2(?,?,?,?)`, [play.id, 'START','READY','Y']);
                }else{
                    dbcon.DBCall(`CALL SP_LIVE_PLAY_SET_ST2(?,?,?,?)`, [play.id, 'STOP','READY','N']);
                }
              }else{
                  dbcon.DBCall(`CALL SP_LIVE_PLAY_SET_ST2(?,?,?,?)`, [play.id, 'STOP','READY','N']);
              }
            }
  
            await dbcon.DBCall(`CALL SP_LIVE_PLAY_INIT(?)`, [play.id]);
            await dbcon.DBCall(`CALL SP_ORDER_DEL(?)`,[play.id]);
          }
        } 
  
      } catch (err) {
        await dbcon.DBCall(`CALL SP_ORDER_UPDATE_STATUS(?,?,?)`,[order.pid, order.st, dt.cool.ERROR]);
        console.error('runTrade error:', err);
      }
    }
    

    // await sleep(10000);
  }
};

const adjustQty = (qty, min, step) => {
  const decimals = (step.toString().split('.')[1] || '').length;
  const multiplier = Math.pow(10, decimals);

  const fixed = Math.floor(qty * multiplier / (step * multiplier)) * step;
  const result = fixed < min ? min : fixed;

  return Number(result.toFixed(decimals));
}

const cancelOrder = (symbol, uid, oid) => {
  bybit[uid].cancelOrder({
    category: 'linear',
    symbol: symbol,
    // orderLinkId: oid,
    orderId: oid,
  }).then((re)=>{
  }).catch((er)=>{});
}

exports.sendEnter = async (symbol = null, side_ = null, lv = null, userMargin = null, uid = null, pid = null, oid = 0, limitST = 'N', enterPrice = null) => {
  if(dt.runPID.includes(pid)){
    return;
  }else{
    dt.runPID.push(pid);
  }


  const side = side_ == 'BUY' ? 'Buy' : 'Sell';

  const sendData = {
      status: false,
      errCode: null,
      errMsg: null,
  }
  let extData = null;
  
  const client = bybit[uid];

  const ticker = await client.getTickers({
    category: 'linear',
    symbol,
  });
  const info = await client.getInstrumentsInfo({
    category: 'linear',
    symbol,
  });

  const { minOrderQty, qtyStep } = info.result.list[0].lotSizeFilter;
  const price = Number(ticker.result.list[0].lastPrice);
  const rawQty = (userMargin * lv) / price;
  const qty = adjustQty(rawQty, Number(minOrderQty), Number(qtyStep));
  try{

    await client.setLeverage({
      category: 'linear',      // USDT 선물
      symbol: symbol,
      buyLeverage: lv.toString(),       // 롱 레버리지
      sellLeverage: lv.toString(),      // 숏 레버리지
    });
    
    // const orderLinkId = nanoid();
    // const orderLinkId = oid+'_'+retry;

    extData = await client.submitOrder({
      category: 'linear',
      symbol,
      side: side,
      orderType: 'Market',
      qty: qty.toString(),
      positionIdx: side == 'Buy' ? 1 : 2,
      orderLinkId: 'N_'+uid+'_'+pid+'_'+oid,
    });

    // console.log('sendEnter !!!!!!!!!!!');
    // console.log(extData);
    // console.log('!!!!!!!!!!!');

    sendData.status = extData.retMsg == 'OK' ? true : false;
    sendData.errCode = extData.retCode;
    sendData.errMsg = extData.retMsg;

    if(sendData.status){
      await dbcon.DBCall(`CALL SP_ORDER_UPDATE_NEW_OID(?,?)`, [
        pid,
        JSON.stringify([extData.result.orderId]),
      ]);

      await dbcon.DBCall(`CALL SP_ORDER_UPDATE_STATUS(?,?,?)`,[pid, 'NEW_RUN', dt.cool.NEW_RUN]);

      await dbcon.DBCall(`CALL SP_LIVE_PLAY_ST_NEW_SET(?,?,?,?)`, [
        pid,
        extData.result.orderId,
        extData.result.orderLinkId,
        minOrderQty,
        // positionSize,
      ]);
    }else{

      exports.msgAdd('sendEnter',sendData.errCode, sendData.errMsg, uid, pid, null, symbol, side);

      await dbcon.DBCall(`CALL SP_LIVE_PLAY_INIT(?)`, [pid]);
      await dbcon.DBCall(`CALL SP_LIVE_PLAY_STOP(?)`, [pid]);
      await dbcon.DBCall(`CALL SP_ORDER_DEL(?)`, [pid]);
    }

    // return sendData;
  }catch(e){
    console.log('!!!!!!!!!! sendEnter ::: ', e);
    sendData.status = false;
    sendData.errCode = 404;
    sendData.errMsg = 'not';

    await dbcon.DBCall(`CALL SP_LIVE_PLAY_INIT(?)`, [pid]);
    await dbcon.DBCall(`CALL SP_LIVE_PLAY_STOP(?)`, [pid]);

    // return sendData;
  }

  dt.delRunPID(pid);
}

exports.sendEnter2 = async (symbol = null, side_ = null, userQty = null, uid = null, pid = null, oid = 0, retry = 0) => {
  if(dt.runPID.includes(pid)){
    return;
  }else{
    dt.runPID.push(pid);
  }

  const side = side_.toUpperCase() == 'BUY' ? 'Buy' : 'Sell';

  const sendData = {
      status: false,
      errCode: null,
      errMsg: null,
  }
  const client = bybit[uid];
  const info = await client.getInstrumentsInfo({category: 'linear', symbol});
  const { minOrderQty, qtyStep } = info.result.list[0].lotSizeFilter;
  const qty = adjustQty(userQty, Number(minOrderQty), Number(qtyStep));

  try{
    // const orderLinkId = nanoid();
    const orderLinkId = oid+'_'+retry;
    const extData = await client.submitOrder({
      category: 'linear',
      symbol: symbol,
      side: side,
      orderType: 'Market',
      qty: qty.toString(),          
      positionIdx: side.toUpperCase() == 'BUY'  ? 1 : 2,
      orderLinkId: 'N_'+uid+'_'+pid+'_'+oid,
      reduceOnly: false
    });

    // console.log('sendEnter2 !!!!!!!!!!!');
    // console.log(extData);
    // console.log('!!!!!!!!!!!');
    // console.log('----------');
    // console.log(`
    //   category: 'linear',
    //   symbol: ${symbol},
    //   side: ${side},
    //   orderType: 'Market',
    //   qty: ${qty},          
    //   positionIdx: ${side.toUpperCase() == 'BUY'  ? 1 : 2},
    //   orderLinkId: ${'N_'+uid+'_'+pid+'_'+orderLinkId},
    //   reduceOnly: false
    //   `

    // );
    // console.log(extData);
    // console.log('----------');

    sendData.status = extData.retMsg == 'OK' ? true : false;
    sendData.errCode = extData.retCode;
    sendData.errMsg = extData.retMsg;

    if(sendData.status){
      await dbcon.DBCall(`CALL SP_ORDER_UPDATE_PUSH_OID(?,?)`, [
        pid,
        extData.result.orderId,
      ]);
    }else{
      exports.msgAdd('sendEnter2',sendData.errCode, sendData.errMsg, uid, pid, null, symbol, side);
      await dbcon.DBCall(`CALL SP_ORDER_UPDATE_STATUS(?,?,?)`,[pid, 'FAIL_RUN', dt.cool.RUN]);
    }
    
    // if(sendData.status){
    //   await dbcon.DBCall(`CALL SP_ORDER_UPDATE_STATUS(?)`,[oid]);
    //   // return true;
    // }else{
    //   await dbcon.DBCall(`CALL SP_ORDER_UPDATE_RE(?)`,[oid]);
    //   exports.msgAdd('sendEnter2',sendData.errCode, sendData.errMsg, uid, pid, null, symbol, side);
    //   // return false;
    // }
  }catch(e){
    console.log('!!!!!!!!!! sendEnter2 ::: ', e);
    // await dbcon.DBCall(`CALL SP_ORDER_UPDATE_RE(?)`,[oid]);
    await dbcon.DBCall(`CALL SP_ORDER_UPDATE_STATUS(?,?,?)`,[pid, 'FAIL_RUN', dt.cool.RUN]);

    sendData.status = false;
    sendData.errCode = 404;
    sendData.errMsg = 'not';

    // return false;
  }

  dt.delRunPID(pid);
}

exports.sendForcing = async (type = null, symbol = null, side = null, userQty = null, uid = null, pid = null, oid = 0, retry = 0) => {
  if(dt.runPID.includes(pid)){
    return;
  }else{
    dt.runPID.push(pid);
  }

  // type :: FORCING   PROFIT     STOP
  const sendData = {
      status: false,
      errCode: null,
      errMsg: null,
  }
  const client = bybit[uid];

  const info = await client.getInstrumentsInfo({category: 'linear', symbol});
  const { minOrderQty, qtyStep } = info.result.list[0].lotSizeFilter;
  const qty = adjustQty(userQty, Number(minOrderQty), Number(qtyStep));


  try{
    // const orderLinkId = nanoid();
    const orderLinkId = oid+'_'+retry;
    const extData = await client.submitOrder({
      category: 'linear',
      symbol: symbol,
      side: side.toUpperCase() == 'BUY' ? 'Sell' : 'Buy',
      orderType: 'Market',
      qty: qty.toString(),          
      // reduceOnly: true,      
      positionIdx: side.toUpperCase() == 'BUY' ? 1 : 2,
      orderLinkId: type+'_'+uid+'_'+pid+'_'+oid,
    });

    // console.log('sendForcing !!!!!!!!!!!');
    // console.log(extData);
    // console.log('!!!!!!!!!!!');
    // console.log('----------');
    // console.log(`
    //   category: 'linear',
    //   symbol: ${symbol},
    //   side: ${side.toUpperCase() == 'BUY' ? 'Sell' : 'Buy'},
    //   orderType: 'Market',
    //   qty: ${userQty.toString()},          
    //   positionIdx: ${side.toUpperCase() == 'BUY'  ? 1 : 2},
    //   orderLinkId: ${'N_'+uid+'_'+pid+'_'+orderLinkId},
    //   reduceOnly: true
    //   `

    // );
    // console.log(extData);
    // console.log('----------');

    sendData.status = extData.retMsg == 'OK' ? true : false;
    sendData.errCode = extData.retCode;
    sendData.errMsg = extData.retMsg;

    
    if(sendData.status){
      await dbcon.DBCall(`CALL SP_ORDER_UPDATE_STATUS(?,?,?)`,[pid, 'CLOSE', dt.cool.CLOSE]);
      await dbcon.DBCall(`CALL SP_LIVE_PLAY_ST_NEW_OID_UPDATE(?,?)`,[pid, extData.result.orderId]);
      await dbcon.DBCall(`CALL SP_ORDER_UPDATE_CLOSE_OID(?,?)`, [
        pid,
        JSON.stringify([extData.result.orderId]),
      ]);

      // return true;
    }else{
      await dbcon.DBCall(`CALL SP_ORDER_UPDATE_RE(?)`,[oid]);
      if(sendData.errCode == '110017'){
        exports.msgAdd('sendForcing', sendData.errCode, `이미종료된 포지션입니다.`, uid, pid, null, symbol, side);
        dbcon.DBCall(`CALL SP_LIVE_PLAY_SET_ST2(?,?,?,?)`, [pid, 'STOP','READY','N']);
        dbcon.DBCall(`CALL SP_LIVE_PLAY_INIT(?)`, [pid]);
        await dbcon.DBCall(`CALL SP_ORDER_DEL(?)`,[pid]);
      }else{
        exports.msgAdd('sendForcing',sendData.errCode, sendData.errMsg, uid, pid, null, symbol, side);
      }

      // return false;
    }
  }catch(e){
    console.log('!!!!!!!!!! sendForcing ::: ', e);
    sendData.status = false;
    sendData.errCode = 404;
    sendData.errMsg = 'not';

    // return false;
  }

  dt.delRunPID(pid);
}

exports.sendForcing2 = async (symbol = null, side_ = null, userQty = null, uid = null, pid = null, oid = 0, retry = 0) => {
  if(dt.runPID.includes(pid)){
    return;
  }else{
    dt.runPID.push(pid);
  }

  // const side = side_.toUpperCase() == 'BUY' ? 'Buy' : 'Sell';
  const side =
  side_.toUpperCase() == 'BUY'
    ? 'Sell'
    : 'Buy';

  const sendData = {
      status: false,
      errCode: null,
      errMsg: null,
  }
  const client = bybit[uid];
  const info = await client.getInstrumentsInfo({category: 'linear', symbol});
  const { minOrderQty, qtyStep } = info.result.list[0].lotSizeFilter;
  const qty = adjustQty(userQty, Number(minOrderQty), Number(qtyStep));

  try{
    // const orderLinkId = nanoid();
    const orderLinkId = oid+'_'+retry;
    const extData = await client.submitOrder({
      category: 'linear',
      symbol: symbol,
      side: side,
      orderType: 'Market',
      qty: qty.toString(),          
      positionIdx: side_.toUpperCase() == 'BUY'  ? 1 : 2,
      orderLinkId: 'F_'+uid+'_'+pid+'_'+oid,
      reduceOnly: true
    });

    // console.log('sendClose2 !!!!!!!!!!!');
    // console.log(extData);

    sendData.status = extData.retMsg == 'OK' ? true : false;
    sendData.errCode = extData.retCode;
    sendData.errMsg = extData.retMsg;

    if(sendData.status){
      await dbcon.DBCall(`CALL SP_ORDER_UPDATE_C_PUSH_OID(?,?)`, [
        pid,
        extData.result.orderId,
      ]);
    }else{
      exports.msgAdd('sendClose2',sendData.errCode, sendData.errMsg, uid, pid, null, symbol, side);
      await dbcon.DBCall(`CALL SP_ORDER_UPDATE_STATUS(?,?,?)`,[pid, 'CLOSE', dt.cool.CLOSE]);
    }
  }catch(e){
    console.log('!!!!!!!!!! sendClose2 ::: ', e);
    // await dbcon.DBCall(`CALL SP_ORDER_UPDATE_RE(?)`,[oid]);
    await dbcon.DBCall(`CALL SP_ORDER_UPDATE_STATUS(?,?,?)`,[pid, 'CLOSE', dt.cool.CLOSE]);

    sendData.status = false;
    sendData.errCode = 404;
    sendData.errMsg = 'not';

    // return false;
  }

  dt.delRunPID(pid);
}

exports.sendLimit = async (symbol, side, stopLoss, exactPrice, qty, uid, pid, oid) => {
  const isLong = side.toUpperCase() === 'BUY';
  const client = bybit[uid];

  const info = await client.getInstrumentsInfo({
    category: 'linear',
    symbol
  });

  const tickSize = Number(info.result.list[0].priceFilter.tickSize);

  function adjustPrice(price, tickSize) {
    const precision = Math.round(1 / tickSize);
    return (Math.floor(price * precision) / precision).toFixed(
      tickSize.toString().split('.')[1]?.length || 0
    );
  }

  // 🔥 1. 트리거 가격 (손절 발동)
  const triggerRaw = isLong
    ? exactPrice * (1 - stopLoss / 100)
    : exactPrice * (1 + stopLoss / 100);

  const triggerPrice = adjustPrice(triggerRaw, tickSize);

  // 🔥 2. 실제 주문 가격 (조금 더 불리하게)
  const limitRaw = isLong
    ? triggerRaw * 0.995   // 롱 → 더 아래로
    : triggerRaw * 1.005;  // 숏 → 더 위로

  const price = adjustPrice(limitRaw, tickSize);

  // console.log('triggerPrice:', triggerPrice);
  // console.log('limitPrice:', price);

  try {
    const submitData = {
      category: 'linear',
      symbol: symbol,

      side: isLong ? 'Sell' : 'Buy',

      orderType: 'Limit',              // 🔥 Limit 유지
      price: price.toString(),         // 🔥 실제 주문 가격

      stopOrderType: 'Stop',           // 🔥 핵심
      triggerPrice: triggerPrice,      // 🔥 발동 조건
      triggerBy: 'MarkPrice',          // 🔥 추천

      qty: qty.toString(),
      reduceOnly: true,
      timeInForce: 'GTC',

      positionIdx: isLong ? 1 : 2,
      triggerDirection: isLong ? 2 : 1,

      orderLinkId: oid,
    };
    // console.log(submitData);

    const rData = await client.submitOrder(submitData);

    if(rData?.retMsg == 'OK'){
      await dbcon.DBCall(`CALL SP_LIVE_PLAY_ST_ALGO(?,?)`,[pid, rData.result.orderId]);
      await dbcon.DBCall(`CALL SP_ORDER_UPDATE_ALOGO(?,?)`,[pid, rData.result.orderId]);
    }

  } catch (e) {
    console.log('sendLimit error:', e);
  }
};

exports.msgAdd = async (
  fun = null,
  code = null,
  msg = null,
  uid = null,
  pid = null,
  tid = null,
  symbol = null,
  side = null
) => {
  dbcon.DBCall(`CALL SP_MSG_ADD(?,?,?,?,?,?,?,?)`, [
      fun,
      code,
      msg,
      uid,
      pid,
      tid,
      symbol,
      side,
  ]).then((re)=>{
      //소켓 전달 코드
      io.wsOneSend(uid,'live-error', {st: true});

      exports.msgGetCnt(uid);
  }).catch((e)=>{
      console.log('EEEEEEEEE :: msgAdd : ',e);
  })
}

exports.msgGetCnt = async (uid) => {
  dbcon.DBOneCall(`CALL SP_MSG_CNT_GET(?)`, [
      uid
  ]).then((re)=>{
      //소켓 전달 코드
      io.wsOneSend(uid, 'msg-cnt', {cnt: re.msg_cnt});
  }).catch((e)=>{
      console.log('EEEEEEEEE :: msgGetCnt : ',e);
  })
}


  
exports.init = async () => {
  dbcon.DBCall(`CALL SP_CAGR_UP_DOWN_GET()`).then((re)=>{
    DB_candleUpDown = re;
  });

  getTick();
  getUserBalance();

  dbcon.DBCall(`CALL SP_A_MEMBER_KEY_ALL_GET()`).then((keyList)=>{
    console.log(keyList);
    keyList.forEach((k)=>{
        initAPI(k.id, k.appKey, k.appSecret);
    });

    runTrade();
  }).catch((eee)=>{
      console.log('zzzzzzzzzzzzz');
      console.log(eee);
  });

  socketInit();

  // schedule.scheduleJob("0 0 * * * *", ()=>{ getCandlePer('1h'); });
  // schedule.scheduleJob("0 0 */2 * * *", ()=>{ getCandlePer('2h'); });
  // schedule.scheduleJob("0 0 */4 * * *", ()=>{ getCandlePer('4h'); });
  // schedule.scheduleJob("0 0 0 * * *", ()=>{ getCandlePer('1d'); });


  schedule.scheduleJob("0 */5 * * * *", ()=>{ getCandlePer('1h'); });
  schedule.scheduleJob("0 */5 * * * *", ()=>{ getCandlePer('2h'); });
  schedule.scheduleJob("0 */5 * * * *", ()=>{ getCandlePer('4h'); });
  schedule.scheduleJob("0 */5 * * * *", ()=>{ getCandlePer('1d'); });
}

