var express = require('express');
var router = express.Router();
const axios = require('axios');
const crypto = require('crypto');
const refresh = require("../middleware/refresh");
const redisClient = require('../util/redis.util');
const jwt = require('../util/jwt.util');
const db = require('../database/connect/config');
const requestIp = require('request-ip');
const seon = require('../seon');
const dbcon = require("../dbcon");
// const coin = require("../coin");
const coin = require("../bybit");

const { validateRegister, validateRegister1, validateRegister2, validateLogin } = require('./validation');
const fs = require("fs");

const coolsms = require('coolsms-node-sdk').default;
const messageService = new coolsms(process.env.COOL_SMS_KEY, process.env.COOL_SMS_SECRET);

/////////////////////////
const 분봉 = 1
const 옵1 = 5
const 옵2 = 3
const 옵3 = 3

const 진입 = 0
const 취소 = 0
const 일차익절 = 0
const 손절 = 0
//////////////////////////
const 손절취소ST = 'N'
const 손절취소 = 0
const b2차익절 = 0
/////////////////////////
const 추세주문ST = 'N'
const 즉시진입ST = 'N'
const 추격ST = 'N'
const 자동청산ST = 'N'
const 손절익절취소 = 0
const c2차익절 = 0
const 추세추격 = 0
/////////////////////////


const isEmpty = function(value){
	if( value == "" || value == null || Number.isNaN(value) || value == undefined || ( value != null && typeof value == "object" && !Object.keys(value).length ) ){
	  return null;
	}else{
	  return value;
	}
};

const isEmpty2 = function(value){
  if( value == "" || value == null || value == undefined || ( value != null && typeof value == "object" && !Object.keys(value).length ) ){
	return 0;
  }else{
	return value;
  }
};

router.post('/access', async (req, res) =>{
  const userIp = requestIp.getClientIp(req);

  await dbcon.DBCall(`CALL SP_U_ACCESS_LOG(?)`,[userIp]);
  
  return res.send(true);
});

/* GET users listing. */
router.get('/refresh', refresh, function(req, res, next) {
  res.send('respond with a resource');
});

router.post('/admin/login', validateLogin, async (req, res) =>{
  let info = {type: false, message: ''};
  let {userId, password} = req.body
  
  if(!(userId && password)){
    return res.status(400).json({
      status: 400,
      errors: [{msg:'12312'}]
    });
  }

  const reData = await dbcon.DBOneCall(`CALL SP_A_LOGIN(?,?)`,[
    userId,
    password
  ]);

  if(reData && reData.id){
    const accessToken = jwt.sign(reData.id+'');
    const refreshToken = jwt.refresh();

    redisClient.set(reData.id+'', refreshToken);

    info.message = 'success';
    res.setHeader('Content-Type','application/json; charset=utf-8');
    res.setHeader('Authorization', 'Bearer ' + accessToken);
    res.setHeader('Refresh', 'Bearer ' + refreshToken);

    coin.msgGetCnt(reData.id);

    return res.status(200).json({
        status: 200,
        info: info,
        token: {
            accessToken: accessToken,
            refreshToken: refreshToken
        }
    });
  }
  else{
    return res.status(400).json({
      status: 400,
      errors: [
        {msg:'이름과 이메일을 입력해주세요', param: "userId", location: "body"},
        {msg:'이름과 이메일을 입력해주세요', param: "password", location: "body"},
      ]
    });
  }
  
});

router.get('/n/image', async function(req, res){
  try{
    const reData = await dbcon.DBOneCall(`CALL SP_NAVER_FILE_GET(?,?)`, [req.query.uid, req.query.n_id]);
    const reBuffer = fs.readFileSync(reData.path);

    res.writeHead(200, { "Context-Type": reData.type });
    res.write(reBuffer);  
    res.end();  
  }catch(e){
    console.log(e);
    return res.send('');
  }
});

router.get('/api/hook', async function(req, res){
  // console.log(req.query);
});
// router.post('/api/hook', async function(req, res){
//   const reg_ex = /[^0-9]/g;
//   const reqData = req.body;

//   if(reqData && reqData.db_type == 'stoch'){
//     await seon.coolSET(reqData);
//   }else if(reqData && (reqData.db_type == 'UT' || reqData.db_type == 'ATF')){
//     await dbcon.DBCall(`CALL SP_LOG_ALERT_ADD3(?,?,?,?)`, [
//       reqData.db_type,
//       reqData.type,
//       reqData.bunbong.replace(reg_ex, ""),
//       new Date(parseInt(reqData.time)),
//     ]);
//   }

  
//   if(reqData.db_type == 'UT'){
//     seon.UT_OLD[reqData.bunbong] = seon.UT_NEW[reqData.bunbong]
//     seon.UT_NEW[reqData.bunbong] = reqData.type
//     const reqBun = reqData.bunbong.replace(reg_ex, "");
//     const tgDataList = await dbcon.DBCall(`CALL SP_API_PLAY_Y_GET(?)`,[reqBun]);

//     for(let i=0;i<tgDataList.length;i++){
//       try{
//         const tgData = tgDataList[i];
//         const bunbong = tgData.bunbong.split('_')[1]
//         let logItem = await dbcon.DBOneCall(`CALL SP_API_PLAY_LOG_ITEM2_GET(?,?,?)`, [
//           tgData.id,
//           tgData.uid,
//           tgData.idx,
//         ]);

//         // console.log(`${tgData.type} ${bunbong} ATF :: ${seon.ATF_NEW[bunbong+'m']}, UT :: ${seon.UT_NEW[bunbong+'m']}`);

//         // if(logItem?.signalType == 'SELL' && tgData.st == 'START' && logItem.st == 'EXACT_WAIT' && tgData.type == 'C' && seon.ATF_NEW[bunbong+'m'] == 'SHORT' && seon.UT_NEW[bunbong+'m'] == 'LONG'){
//         //   // 골드크로스 숏포지션 진입 취소
//         //   const price = logItem.signalType == 'BUY' ? seon.offerho : seon.bidho

//         //   await dbcon.DBCall(`CALL SP_API_PLAY_ST_CANCEL(?,?,?)`,[logItem.id, tgData.id, tgData.idx-1]);

//         //   await dbcon.DBCall(`CALL SP_LOG_ADD(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)`, [
//         //       tgData.uid,
//         //       tgData.id,
//         //       logItem.id,
//         //       tgData.stoch_id,
//         //       null,
//         //       null,
//         //       '취소' + tgData.type,
//         //       null,
//         //       price,
//         //       null,
//         //       null,
//         //       null,
//         //       null,
//         //       null,
//         //       null,
//         //   ]);
//         // }else if(logItem?.signalType == 'BUY' && tgData.st == 'START' && logItem.st == 'EXACT_WAIT' && tgData.type == 'C' && seon.ATF_NEW[bunbong+'m'] == 'LONG' && seon.UT_NEW[bunbong+'m'] == 'SHORT'){
//         //   // 데드크로스 롱포지션 진입 취소
//         //   const price = logItem.signalType == 'BUY' ? seon.offerho : seon.bidho

//         //   await dbcon.DBCall(`CALL SP_API_PLAY_ST_CANCEL(?,?,?)`,[logItem.id, tgData.id, tgData.idx-1]);

//         //   await dbcon.DBCall(`CALL SP_LOG_ADD(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)`, [
//         //     tgData.uid,
//         //     tgData.id,
//         //     logItem.id,
//         //     tgData.stoch_id,
//         //     null,
//         //     null,
//         //     '취소' + tgData.type,
//         //     null,
//         //     price,
//         //     null,
//         //     null,
//         //     null,
//         //     null,
//         //     null,
//         //     null,
//         //   ]);
//         // }
        
        
//         if((tgData.signalType == 'BUY' || tgData.signalType == 'TWO') && tgData.type == 'C' && tgData.st == 'READY' && seon.ATF_NEW[bunbong+'m'] == 'LONG' && seon.UT_NEW[bunbong+'m'] == 'LONG'){
//           //롱포지션 진입대기
//           const price = tgData.signalType == 'BUY' ? seon.offerho : seon.bidho

//           const logObj = await dbcon.DBOneCall(`CALL SP_API_PLAY_ST_EXACT_WAIT(?,?,?,?,?)`, [
//             tgData.id,
//             tgData.uid,
//             price,
//             tgData.idx+1,
//             'BUY',
//           ]);

//           await dbcon.DBCall(`CALL SP_LOG_ADD(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)`, [
//             tgData.uid,
//             tgData.id,
//             logObj.id,
//             reqData.uuid,
//             reqData.db_type,
//             reqData.type,
//             '신호발생' + tgData.type,
//             price,
//             null,
//             tgData.bunbong,
//             tgData.second1,
//             tgData.second2,
//             tgData.second3,
//             tgData.second4,
//             new Date(parseInt(reqData.time)),
//           ]);
//         }else if((tgData.signalType == 'SELL' || tgData.signalType == 'TWO') && tgData.type == 'C' && tgData.st == 'READY' && seon.ATF_NEW[bunbong+'m'] == 'SHORT' && seon.UT_NEW[bunbong+'m'] == 'SHORT'){
//           //숏포지션 진입
//           const price = tgData.signalType == 'BUY' ? seon.offerho : seon.bidho

//           const logObj = await dbcon.DBOneCall(`CALL SP_API_PLAY_ST_EXACT_WAIT(?,?,?,?,?)`, [
//             tgData.id,
//             tgData.uid,
//             price,
//             tgData.idx+1,
//             'SELL',
//           ]);

//           await dbcon.DBCall(`CALL SP_LOG_ADD(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)`, [
//             tgData.uid,
//             tgData.id,
//             logObj.id,
//             reqData.uuid,
//             reqData.db_type,
//             reqData.type,
//             '신호발생' + tgData.type,
//             price,
//             null,
//             tgData.bunbong,
//             tgData.second1,
//             tgData.second2,
//             tgData.second3,
//             tgData.second4,
//             new Date(parseInt(reqData.time)),
//           ]);
//         }
        
//         // else if((tgData.signalType == 'BUY' || tgData.signalType == 'TWO') && tgData.type == 'C' && logItem?.st == 'EXACT_WAIT' && tgData.autoST == 'Y' && seon.ATF_NEW[bunbong+'m'] == 'LONG' && seon.UT_NEW[bunbong+'m'] == 'LONG'){
//         //   //롱포지션 새로운 진입
//         //   const price = tgData.signalType == 'BUY' ? seon.offerho : seon.bidho
//         //   await dbcon.DBCall(`CALL SP_API_PLAY_ST_EXACT_WAIT_UPDATE(?,?,?)`, [
//         //     logItem.id,
//         //     price,
//         //     'BUY',
//         //   ]);

//         //   await dbcon.DBCall(`CALL SP_LOG_ADD(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)`, [
//         //     tgData.uid,
//         //     tgData.id,
//         //     logItem.id,
//         //     reqData.uuid,
//         //     reqData.db_type,
//         //     reqData.type,
//         //     '신호갱신' + tgData.type,
//         //     price,
//         //     null,
//         //     tgData.bunbong,
//         //     tgData.second1,
//         //     tgData.second2,
//         //     tgData.second3,
//         //     tgData.second4,
//         //     new Date(parseInt(reqData.time)),
//         //   ]);
//         // }else if((tgData.signalType == 'SELL' || tgData.signalType == 'TWO') && tgData.type == 'C' && logItem?.st == 'EXACT_WAIT' && tgData.autoST == 'Y' && seon.ATF_NEW[bunbong+'m'] == 'SHORT' && seon.UT_NEW[bunbong+'m'] == 'SHORT'){
//         //   //숏포지션 새로운 진입
//         //   const price = tgData.signalType == 'BUY' ? seon.offerho : seon.bidho
//         //   await dbcon.DBCall(`CALL SP_API_PLAY_ST_EXACT_WAIT_UPDATE(?,?,?)`, [
//         //     logItem.id,
//         //     price,
//         //     'SELL',
//         //   ]);

//         //   await dbcon.DBCall(`CALL SP_LOG_ADD(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)`, [
//         //     tgData.uid,
//         //     tgData.id,
//         //     logItem.id,
//         //     reqData.uuid,
//         //     reqData.db_type,
//         //     reqData.type,
//         //     '신호갱신' + tgData.type,
//         //     price,
//         //     null,
//         //     tgData.bunbong,
//         //     tgData.second1,
//         //     tgData.second2,
//         //     tgData.second3,
//         //     tgData.second4,
//         //     new Date(parseInt(reqData.time)),
//         //   ]);
//         // }

//       }catch(e){
//         console.log('api/hook ERROR :: ', e)
//       }
//     }

//   }else if(reqData.db_type == 'ATF'){
//     seon.ATF_OLD[reqData.bunbong] = seon.ATF_NEW[reqData.bunbong]
//     seon.ATF_NEW[reqData.bunbong] = reqData.type

//     const reqBun = reqData.bunbong.replace(reg_ex, "");
//     const tgDataList = await dbcon.DBCall(`CALL SP_API_PLAY_Y_GET(?)`,[reqBun]);

//     for(let i=0;i<tgDataList.length;i++){
//       try{
//         const tgData = tgDataList[i];
//         const bunbong = tgData.bunbong.split('_')[1]
//         let logItem = await dbcon.DBOneCall(`CALL SP_API_PLAY_LOG_ITEM2_GET(?,?,?)`, [
//           tgData.id,
//           tgData.uid,
//           tgData.idx,
//         ]);

//         // console.log(`${tgData.type} ${bunbong} ATF :: ${seon.ATF_NEW[bunbong+'m']}, UT :: ${seon.UT_NEW[bunbong+'m']}`);
//         if(
//           (tgData.signalType == 'BUY' || tgData.signalType == 'TWO')
//           && (tgData.st == 'START' || tgData.st == 'READY' || logItem?.st == 'EXACT_WAIT')
//           // && tgData.type != 'A' 
//           && seon.ATF_OLD[bunbong+'m'] == 'SHORT' 
//           && seon.ATF_NEW[bunbong+'m'] == 'LONG'
//           && tgData.t_direct == 'Y'
//         ){
//           // 롱포지션 즉시 진입
//           //대기 READY, 시작 START [진입대기 EXACT_WAIT]
//           const price = seon.offerho

//           if(tgData.st == 'READY'){
//             logItem = await dbcon.DBOneCall(`CALL SP_API_PLAY_ST_EXACT_WAIT(?,?,?,?,?)`, [
//               tgData.id,
//               tgData.uid,
//               price,
//               tgData.idx+1,
//               'BUY',
//             ]);
//           }

//           await dbcon.DBCall(`CALL SP_API_PLAY_ST_EXACT(?,?,?,?,?)`,[logItem.id, price, tgData.orderSize, 0, seon.charge]);

//           await dbcon.DBCall(`CALL SP_API_PLAY_ST_USER_PRICE(?,?)`,[
//               tgData.uid, -seon.charge
//           ]);

//           await dbcon.DBCall(`CALL SP_LOG_ADD(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)`, [
//               tgData.uid,
//               tgData.id,
//               logItem.id,
//               tgData.stoch_id,
//               null,
//               null,
//               '즉시진입'+ tgData.type,
//               null,
//               price,
//               null,
//               null,
//               null,
//               null,
//               null,
//               null,
//           ]);

//         }else if(
//           (tgData.signalType == 'SELL' || tgData.signalType == 'TWO')
//           && (tgData.st == 'START' || tgData.st == 'READY' || logItem?.st == 'EXACT_WAIT')
//           // && tgData.type != 'A' 
//           && seon.ATF_OLD[bunbong+'m'] == 'LONG' 
//           && seon.ATF_NEW[bunbong+'m'] == 'SHORT'
//           && tgData.t_direct == 'Y'
//         ){
//           // 숏포지션 즉시 진입

//           const price = seon.bidho

//           if(tgData.st == 'READY'){
//             logItem = await dbcon.DBOneCall(`CALL SP_API_PLAY_ST_EXACT_WAIT(?,?,?,?,?)`, [
//               tgData.id,
//               tgData.uid,
//               price,
//               tgData.idx+1,
//               'SELL',
//             ]);
//           }

//           await dbcon.DBCall(`CALL SP_API_PLAY_ST_EXACT(?,?,?,?,?)`,[logItem.id, price, tgData.orderSize, 0, seon.charge]);

//           await dbcon.DBCall(`CALL SP_API_PLAY_ST_USER_PRICE(?,?)`,[
//               tgData.uid, -seon.charge
//           ]);

//           await dbcon.DBCall(`CALL SP_LOG_ADD(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)`, [
//               tgData.uid,
//               tgData.id,
//               logItem.id,
//               tgData.stoch_id,
//               null,
//               null,
//               '즉시진입'+ tgData.type,
//               null,
//               price,
//               null,
//               null,
//               null,
//               null,
//               null,
//               null,
//           ]);

//         }
        
//         // else if(logItem?.signalType == 'SELL' && tgData.st == 'START' && logItem.st == 'EXACT_WAIT' && tgData.type == 'C' && seon.ATF_NEW[bunbong+'m'] == 'SHORT' && seon.UT_NEW[bunbong+'m'] == 'LONG'){
//         //   // 골드크로스 숏포지션 진입 취소
//         //   const price = logItem.signalType == 'BUY' ? seon.offerho : seon.bidho

//         //   await dbcon.DBCall(`CALL SP_API_PLAY_ST_CANCEL(?,?,?)`,[logItem.id, tgData.id, tgData.idx-1]);

//         //   await dbcon.DBCall(`CALL SP_LOG_ADD(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)`, [
//         //       tgData.uid,
//         //       tgData.id,
//         //       logItem.id,
//         //       tgData.stoch_id,
//         //       null,
//         //       null,
//         //       '취소' + tgData.type,
//         //       null,
//         //       price,
//         //       null,
//         //       null,
//         //       null,
//         //       null,
//         //       null,
//         //       null,
//         //   ]);
//         // }else if(logItem?.signalType == 'BUY' && tgData.st == 'START' && logItem.st == 'EXACT_WAIT' && tgData.type == 'C' && seon.ATF_NEW[bunbong+'m'] == 'LONG' && seon.UT_NEW[bunbong+'m'] == 'SHORT'){
//         //   // 데드크로스 롱포지션 진입 취소
//         //   const price = logItem.signalType == 'BUY' ? seon.offerho : seon.bidho
//         //   await dbcon.DBCall(`CALL SP_API_PLAY_ST_CANCEL(?,?,?)`,[logItem.id, tgData.id, tgData.idx-1]);

//         //   await dbcon.DBCall(`CALL SP_LOG_ADD(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)`, [
//         //     tgData.uid,
//         //     tgData.id,
//         //     logItem.id,
//         //     tgData.stoch_id,
//         //     null,
//         //     null,
//         //     '취소' + tgData.type,
//         //     null,
//         //     price,
//         //     null,
//         //     null,
//         //     null,
//         //     null,
//         //     null,
//         //     null,
//         //   ]);
//         // }
        
//         // else if((tgData.signalType == 'BUY' || tgData.signalType == 'TWO') && tgData.type == 'C' && tgData.st == 'READY' && seon.ATF_NEW[bunbong+'m'] == 'LONG' && seon.UT_NEW[bunbong+'m'] == 'LONG'){
//         //   //롱포지션 진입대기
//         //   const price = tgData.signalType == 'BUY' ? seon.offerho : seon.bidho

//         //   const logObj = await dbcon.DBOneCall(`CALL SP_API_PLAY_ST_EXACT_WAIT(?,?,?,?,?)`, [
//         //     tgData.id,
//         //     tgData.uid,
//         //     price,
//         //     tgData.idx+1,
//         //     'BUY',
//         //   ]);

//         //   await dbcon.DBCall(`CALL SP_LOG_ADD(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)`, [
//         //     tgData.uid,
//         //     tgData.id,
//         //     logObj.id,
//         //     reqData.uuid,
//         //     reqData.db_type,
//         //     reqData.type,
//         //     '신호발생' + tgData.type,
//         //     price,
//         //     null,
//         //     tgData.bunbong,
//         //     tgData.second1,
//         //     tgData.second2,
//         //     tgData.second3,
//         //     tgData.second4,
//         //     new Date(parseInt(reqData.time)),
//         //   ]);
//         // }else if((tgData.signalType == 'SELL' || tgData.signalType == 'TWO') && tgData.type == 'C' && tgData.st == 'READY' && seon.ATF_NEW[bunbong+'m'] == 'SHORT' && seon.UT_NEW[bunbong+'m'] == 'SHORT'){
//         //   //숏포지션 진입
//         //   const price = tgData.signalType == 'BUY' ? seon.offerho : seon.bidho
//         //   const logObj = await dbcon.DBOneCall(`CALL SP_API_PLAY_ST_EXACT_WAIT(?,?,?,?,?)`, [
//         //     tgData.id,
//         //     tgData.uid,
//         //     price,
//         //     tgData.idx+1,
//         //     'SELL',
//         //   ]);

//         //   await dbcon.DBCall(`CALL SP_LOG_ADD(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)`, [
//         //     tgData.uid,
//         //     tgData.id,
//         //     logObj.id,
//         //     reqData.uuid,
//         //     reqData.db_type,
//         //     reqData.type,
//         //     '신호발생' + tgData.type,
//         //     price,
//         //     null,
//         //     tgData.bunbong,
//         //     tgData.second1,
//         //     tgData.second2,
//         //     tgData.second3,
//         //     tgData.second4,
//         //     new Date(parseInt(reqData.time)),
//         //   ]);
//         // }
        
//         else if(logItem && logItem?.st == 'EXACT'){
//           //롱 자동청산
//           const price = logItem.signalType == 'BUY' ? seon.offerho : seon.bidho

//           let stop_st = false

//           if(tgData.type == 'A' || tgData.type == 'A1'){
//             if((tgData.t_ST == 'Y' && tgData.t_autoST == 'Y' && logItem.t_cnt == 2) || (tgData.t_ST == 'N' && tgData.t_autoST == 'Y' && logItem.t_cnt == 1)){
              
//               if(seon.ATF_OLD[bunbong+'m'] == 'SHORT' && seon.ATF_NEW[bunbong+'m'] == 'LONG' && logItem.signalType == 'SELL'){
//                 stop_st = true;
//               }else if(seon.ATF_OLD[bunbong+'m'] == 'LONG' && seon.ATF_NEW[bunbong+'m'] == 'SHORT' && logItem.signalType == 'BUY'){
//                 stop_st = true;
//               }  
//             }
//           }else{
//             if(seon.ATF_OLD[bunbong+'m'] == 'SHORT  ' && seon.ATF_NEW[bunbong+'m'] == 'LONG' && logItem.signalType == 'SELL'){
//               stop_st = true;
//             }else if(seon.ATF_OLD[bunbong+'m'] == 'LONG' && seon.ATF_NEW[bunbong+'m'] == 'SHORT' && logItem.signalType == 'BUY'){
//               stop_st = true;
//             }  
//           }

//           // if(seon.ATF_OLD[bunbong+'m'] == 'SHORT' && seon.ATF_NEW[bunbong+'m'] == 'LONG' && logItem.signalType == 'SELL'){
//           //   stop_st = true;
//           // }else if(seon.ATF_OLD[bunbong+'m'] == 'LONG' && seon.ATF_NEW[bunbong+'m'] == 'SHORT' && logItem.signalType == 'BUY'){
//           //   stop_st = true;
//           // }  

//           if(stop_st){
//             const re = seon.resultPrice(logItem.exactPrice, price, logItem.signalType);

//             await dbcon.DBCall(`CALL SP_API_PLAY_ST_FORCING(?,?,?,?,?,?,?)`,[
//               logItem.id, tgData.id, price, tgData.orderSize, 
//               re.pol_tick, re.pol_sum, seon.charge
//             ]);
  
//             await dbcon.DBCall(`CALL SP_API_PLAY_ST_USER_PRICE(?,?)`,[
//               tgData.uid, re.pol_sum-seon.charge
//             ]);
  
//             await dbcon.DBCall(`CALL SP_API_PLAY_ST_ATUO(?)`,[tgData.id]);
  
//             await dbcon.DBCall(`CALL SP_LOG_ADD(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)`, [
//                 tgData.uid,
//                 tgData.id,
//                 logItem.id,
//                 tgData.stoch_id,
//                 null,
//                 null,
//                 '자동청산' + tgData.type,
//                 null,
//                 price,
//                 null,
//                 null,
//                 null,
//                 null,
//                 null,
//                 null,
//             ]);

//             await seon.coolRE(tgData, price, tgData.idx+1, tgData.cooltime);
//           }

//         }

//       }catch(e){
//         console.log('api/hook ERROR :: ', e)
//       }
//     }
//   }

  
//   // else if(reqData.db_type == 'stoch'){

//   //   return true;

//   //   const tgDataList = await dbcon.DBCall(`CALL SP_API_PLAY_UUID_GET(?)`, [reqData.uuid]);

//   //   for(let i=0;i<tgDataList.length;i++){
//   //     try{
//   //       const tgData = tgDataList[i];
//   //       const bunbong = tgData.bunbong.split('_')[1]

//   //       if(tgData){
//   //         // const logItem = await dbcon.DBOneCall(`CALL SP_API_PLAY_LOG_ITEM2_GET(?,?,?)`, [
//   //         //   tgData.id,
//   //         //   tgData.uid,
//   //         //   tgData.idx,
//   //         // ]);
          
//   //         if(reqData.type == 'gold' && (tgData.signalType == 'BUY' || tgData.signalType == 'TWO') && tgData.st == 'READY' && tgData.autoST == 'Y'){
//   //           // 골드크로스 롱포지션 진입
//   //           let enterST = false

//   //           if(tgData.type == 'A'){
//   //             enterST = true;
//   //           }else if(tgData.type == 'B' && seon.ATF_NEW[bunbong+'m'] == 'LONG'){
//   //             enterST = true;
//   //           }
            
//   //           if(enterST){
//   //             const logObj = await dbcon.DBOneCall(`CALL SP_API_PLAY_ST_EXACT_WAIT(?,?,?,?,?)`, [
//   //               tgData.id,
//   //               tgData.uid,
//   //               reqData.close,
//   //               tgData.idx+1,
//   //               'BUY',
//   //             ]);

//   //             await dbcon.DBCall(`CALL SP_LOG_ADD(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)`, [
//   //               tgData.uid,
//   //               tgData.id,
//   //               logObj.id,
//   //               reqData.uuid,
//   //               reqData.db_type,
//   //               reqData.type,
//   //               '신호발생' + tgData.type,
//   //               parseFloat(reqData.close),
//   //               null,
//   //               tgData.bunbong,
//   //               tgData.second1,
//   //               tgData.second2,
//   //               tgData.second3,
//   //               tgData.second4,
//   //               new Date(parseInt(reqData.time)),
//   //             ]);
//   //           }
//   //         }else if(reqData.type == 'dead' && (tgData.signalType == 'SELL' || tgData.signalType == 'TWO') && tgData.st == 'READY' && tgData.autoST == 'Y'){
//   //           // 데드크로스 숏포지션 진입
//   //           let enterST = false

//   //           if(tgData.type == 'A'){
//   //             enterST = true;
//   //           }else if(tgData.type == 'B' && seon.ATF_NEW[bunbong+'m'] == 'SHORT'){
//   //             enterST = true;
//   //           }

//   //           if(enterST){
//   //             const logObj = await dbcon.DBOneCall(`CALL SP_API_PLAY_ST_EXACT_WAIT(?,?,?,?,?)`, [
//   //               tgData.id,
//   //               tgData.uid,
//   //               reqData.close,
//   //               tgData.idx+1,
//   //               'SELL',
//   //             ]);
  
//   //             await dbcon.DBCall(`CALL SP_LOG_ADD(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)`, [
//   //               tgData.uid,
//   //               tgData.id,
//   //               logObj.id,
//   //               reqData.uuid,
//   //               reqData.db_type,
//   //               reqData.type,
//   //               '신호발생' + tgData.type,
//   //               parseFloat(reqData.close),
//   //               null,
//   //               tgData.bunbong,
//   //               tgData.second1,
//   //               tgData.second2,
//   //               tgData.second3,
//   //               tgData.second4,
//   //               new Date(parseInt(reqData.time)),
//   //             ]);
//   //           }

//   //         }

//   //         // else if(reqData.type == 'gold' && (tgData.signalType == 'BUY' || tgData.signalType == 'TWO') && logItem?.st == 'EXACT_WAIT' && tgData.autoST == 'Y'){
//   //         //   // 골드크로스 롱포지션 새로운 진입
//   //         //   let enterST = false

//   //         //   if(tgData.type == 'A'){
//   //         //     enterST = true;
//   //         //   }else if(tgData.type == 'B' && seon.ATF_NEW[bunbong+'m'] == 'LONG'){
//   //         //     enterST = true;
//   //         //   }

//   //         //   if(enterST){
//   //         //     await dbcon.DBCall(`CALL SP_API_PLAY_ST_EXACT_WAIT_UPDATE(?,?,?)`, [
//   //         //       logItem.id,
//   //         //       reqData.close,
//   //         //       'BUY',
//   //         //     ]);
  
//   //         //     await dbcon.DBCall(`CALL SP_LOG_ADD(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)`, [
//   //         //       tgData.uid,
//   //         //       tgData.id,
//   //         //       logItem.id,
//   //         //       reqData.uuid,
//   //         //       reqData.db_type,
//   //         //       reqData.type,
//   //         //       '신호갱신' + tgData.type,
//   //         //       parseFloat(reqData.close),
//   //         //       null,
//   //         //       tgData.bunbong,
//   //         //       tgData.second1,
//   //         //       tgData.second2,
//   //         //       tgData.second3,
//   //         //       tgData.second4,
//   //         //       new Date(parseInt(reqData.time)),
//   //         //     ]);
//   //         //   }
            
//   //         // }else if(reqData.type == 'dead' && (tgData.signalType == 'SELL' || tgData.signalType == 'TWO') && logItem?.st == 'EXACT_WAIT' && tgData.autoST == 'Y'){
//   //         //   // 데드크로스 숏포지션 새로운 진입
//   //         //   let enterST = false

//   //         //   if(tgData.type == 'A'){
//   //         //     enterST = true;
//   //         //   }else if(tgData.type == 'B' && seon.ATF_NEW[bunbong+'m'] == 'SHORT'){
//   //         //     enterST = true;
//   //         //   }

//   //         //   if(enterST){
//   //         //     await dbcon.DBCall(`CALL SP_API_PLAY_ST_EXACT_WAIT_UPDATE(?,?,?)`, [
//   //         //       logItem.id,
//   //         //       reqData.close,
//   //         //       'SELL',
//   //         //     ]);

//   //         //     await dbcon.DBCall(`CALL SP_LOG_ADD(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)`, [
//   //         //       tgData.uid,
//   //         //       tgData.id,
//   //         //       logItem.id,
//   //         //       reqData.uuid,
//   //         //       reqData.db_type,
//   //         //       reqData.type,
//   //         //       '신호갱신' + tgData.type,
//   //         //       parseFloat(reqData.close),
//   //         //       null,
//   //         //       tgData.bunbong,
//   //         //       tgData.second1,
//   //         //       tgData.second2,
//   //         //       tgData.second3,
//   //         //       tgData.second4,
//   //         //       new Date(parseInt(reqData.time)),
//   //         //     ]);
//   //         //   }
//   //         // }
          
//   //         // else if(reqData.type == 'gold' && logItem?.signalType == 'SELL' && tgData.st == 'START'){
//   //         //   // 골드크로스 숏포지션 진입 취소
//   //         //   if(logItem && logItem.st == 'EXACT_WAIT'){
//   //         //     let enterST = false

//   //         //     if(tgData.type == 'A'){
//   //         //       enterST = true;
//   //         //     }else if(tgData.type == 'B' && seon.ATF_NEW[bunbong+'m'] != 'SHORT'){
//   //         //       enterST = true;
//   //         //     }

//   //         //     if(enterST){
//   //         //       await dbcon.DBCall(`CALL SP_API_PLAY_ST_CANCEL(?,?,?)`,[logItem.id, tgData.id, tgData.idx-1]);

//   //         //       await dbcon.DBCall(`CALL SP_LOG_ADD(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)`, [
//   //         //           tgData.uid,
//   //         //           tgData.id,
//   //         //           logItem.id,
//   //         //           tgData.stoch_id,
//   //         //           null,
//   //         //           null,
//   //         //           '취소' + tgData.type,
//   //         //           null,
//   //         //           parseFloat(reqData.close),
//   //         //           null,
//   //         //           null,
//   //         //           null,
//   //         //           null,
//   //         //           null,
//   //         //           null,
//   //         //       ]);
//   //         //     }
//   //         //   }
//   //         // }else if(reqData.type == 'dead' && logItem?.signalType == 'BUY' && tgData.st == 'START'){
//   //         //   // 데드크로스 롱포지션 진입 취소
//   //         //   if(logItem && logItem.st == 'EXACT_WAIT'){
//   //         //     let enterST = false

//   //         //     if(tgData.type == 'A'){
//   //         //       enterST = true;
//   //         //     }else if(tgData.type == 'B' && seon.ATF_NEW[bunbong+'m'] != 'LONG'){
//   //         //       enterST = true;
//   //         //     }

//   //         //     if(enterST){
//   //         //       await dbcon.DBCall(`CALL SP_API_PLAY_ST_CANCEL(?,?,?)`,[logItem.id, tgData.id, tgData.idx-1]);

//   //         //       await dbcon.DBCall(`CALL SP_LOG_ADD(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)`, [
//   //         //         tgData.uid,
//   //         //         tgData.id,
//   //         //         logItem.id,
//   //         //         tgData.stoch_id,
//   //         //         null,
//   //         //         null,
//   //         //         '취소' + tgData.type,
//   //         //         null,
//   //         //         parseFloat(reqData.close),
//   //         //         null,
//   //         //         null,
//   //         //         null,
//   //         //         null,
//   //         //         null,
//   //         //         null,
//   //         //       ]);
//   //         //     }
//   //         //   }
//   //         // }
      
//   //       }

//   //     }
//   //     catch(e){
//   //       console.log('api/hook ERROR :: ', e)
//   //     }
//   //   }
//   // }
  
  
//   // else if(reqData.db_type == 'rsi'){
//   //   // console.log('RSI ----------------')

//   //   const logList = await dbcon.DBCall(`CALL SP_A_PLAY_LOG_GET3(?)`, [
//   //     Math.abs(reqData.bunbong)
//   //   ]);

//   //   // console.log(logList.length);

//   //   for(let i=0;i<logList.length;i++){
//   //     const log = logList[i]
//   //     const price = log.signalType == 'BUY' ? seon.offerho : seon.bidho

//   //     if((reqData.type == 'DOWN' && log.signalType == 'BUY') || (reqData.type == 'UP' && log.signalType == 'SELL')){
//   //       const re = seon.resultPrice(log.exactPrice, price, log.signalType);

//   //       await dbcon.DBCall(`CALL SP_API_PLAY_ST_FORCING(?,?,?,?,?,?,?)`,[
//   //           log.lid, log.pid, price, log.orderSize, 
//   //           re.pol_tick, re.pol_sum, seon.charge
//   //       ]);
        
//   //       await dbcon.DBCall(`CALL SP_API_PLAY_ST_USER_PRICE(?,?)`,[
//   //           log.uid, re.pol_sum-seon.charge
//   //       ]);
        
//   //       await dbcon.DBCall(`CALL SP_API_PLAY_ST_ATUO(?)`,[log.pid]);
        
//   //       await dbcon.DBCall(`CALL SP_LOG_ADD(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)`, [
//   //         log.uid,
//   //         log.pid,
//   //         log.lid,
//   //         null,
//   //         null,
//   //         null,
//   //         'RSI자동청산',
//   //         null,
//   //         price,
//   //         null,
//   //         null,
//   //         null,
//   //         null,
//   //         null,
//   //         null,
//   //     ]);
//   //     }
//   //   }

//   //   // console.log('----------------')
//   // }else if(reqData.db_type == 'B_BONG_GOLD'){
//   //   // console.log('B_BONG_GOLD ----------------')
//   //   // console.log(reqData);
//   //   for(let i=0;i<tgDataList.length;i++){

//   //     try{
//   //       const tgData = tgDataList[i];

//   //       if(tgData){
//   //         const logItem = await dbcon.DBOneCall(`CALL SP_API_PLAY_LOG_ITEM2_GET(?,?,?)`, [
//   //           tgData.id,
//   //           tgData.uid,
//   //           tgData.idx,
//   //         ]);
          
//   //         if(reqData.type == 'ENTER' && (tgData.signalType == 'BUY' || tgData.signalType == 'TWO') && tgData.st == 'READY' && tgData.autoST == 'Y'){
//   //           // 골드크로스 롱포지션 진입
//   //           const logObj = await dbcon.DBOneCall(`CALL SP_API_PLAY_ST_EXACT_WAIT(?,?,?,?,?)`, [
//   //             tgData.id,
//   //             tgData.uid,
//   //             reqData.close,
//   //             tgData.idx+1,
//   //             'BUY',
//   //           ]);

//   //           await dbcon.DBCall(`CALL SP_LOG_ADD(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)`, [
//   //             tgData.uid,
//   //             tgData.id,
//   //             logObj.id,
//   //             reqData.uuid,
//   //             reqData.db_type,
//   //             reqData.type,
//   //             '신호발생B',
//   //             parseFloat(reqData.close),
//   //             null,
//   //             tgData.bunbong,
//   //             tgData.second1,
//   //             tgData.second2,
//   //             tgData.second3,
//   //             tgData.second4,
//   //             new Date(parseInt(reqData.time)),
//   //           ]);

//   //         }
//   //         else if(reqData.type == 'ENTER' && (tgData.signalType == 'BUY' || tgData.signalType == 'TWO') && logItem?.st == 'EXACT_WAIT' && tgData.autoST == 'Y'){
//   //           // 골드크로스 롱포지션 새로운 진입
//   //           await dbcon.DBCall(`CALL SP_API_PLAY_ST_EXACT_WAIT_UPDATE(?,?,?)`, [
//   //             logItem.id,
//   //             reqData.close,
//   //             'BUY',
//   //           ]);

//   //           await dbcon.DBCall(`CALL SP_LOG_ADD(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)`, [
//   //             tgData.uid,
//   //             tgData.id,
//   //             logItem.id,
//   //             reqData.uuid,
//   //             reqData.db_type,
//   //             reqData.type,
//   //             '신호갱신B',
//   //             parseFloat(reqData.close),
//   //             null,
//   //             tgData.bunbong,
//   //             tgData.second1,
//   //             tgData.second2,
//   //             tgData.second3,
//   //             tgData.second4,
//   //             new Date(parseInt(reqData.time)),
//   //           ]);
//   //         }
//   //         else if(reqData.type == 'CANCEL' && logItem?.signalType == 'BUY' && tgData.st == 'START'){
//   //           // 골드크로스 롱포지션 진입 취소
//   //           if(logItem && logItem.st == 'EXACT_WAIT'){
//   //             await dbcon.DBCall(`CALL SP_API_PLAY_ST_CANCEL(?,?,?)`,[logItem.id, tgData.id, tgData.idx-1]);

//   //             await dbcon.DBCall(`CALL SP_LOG_ADD(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)`, [
//   //                 tgData.uid,
//   //                 tgData.id,
//   //                 logItem.id,
//   //                 tgData.stoch_id,
//   //                 null,
//   //                 null,
//   //                 '취소B',
//   //                 null,
//   //                 parseFloat(reqData.close),
//   //                 null,
//   //                 null,
//   //                 null,
//   //                 null,
//   //                 null,
//   //                 null,
//   //             ]);
//   //           }
//   //         }
          
      
//   //       }

//   //     }
//   //     catch(e){
//   //       console.log('api/hook ERROR :: ', e)
//   //     }
//   //   }
//   //   // console.log('----------------')
//   // }else if(reqData.db_type == 'B_BONG_DEAD'){
//   //   // console.log('B_BONG_DEAD ----------------')
//   //   // console.log(reqData);
//   //   for(let i=0;i<tgDataList.length;i++){
//   //     try{
//   //       const tgData = tgDataList[i];
//   //       if(tgData){
//   //         const logItem = await dbcon.DBOneCall(`CALL SP_API_PLAY_LOG_ITEM2_GET(?,?,?)`, [
//   //           tgData.id,
//   //           tgData.uid,
//   //           tgData.idx,
//   //         ]);

//   //         if(reqData.type == 'dead' && (tgData.signalType == 'SELL' || tgData.signalType == 'TWO') && tgData.st == 'READY' && tgData.autoST == 'Y'){
//   //           // 데드크로스 숏포지션 진입
//   //           const logObj = await dbcon.DBOneCall(`CALL SP_API_PLAY_ST_EXACT_WAIT(?,?,?,?,?)`, [
//   //             tgData.id,
//   //             tgData.uid,
//   //             reqData.close,
//   //             tgData.idx+1,
//   //             'SELL',
//   //           ]);

//   //           await dbcon.DBCall(`CALL SP_LOG_ADD(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)`, [
//   //             tgData.uid,
//   //             tgData.id,
//   //             logObj.id,
//   //             reqData.uuid,
//   //             reqData.db_type,
//   //             reqData.type,
//   //             '신호발생B',
//   //             parseFloat(reqData.close),
//   //             null,
//   //             tgData.bunbong,
//   //             tgData.second1,
//   //             tgData.second2,
//   //             tgData.second3,
//   //             tgData.second4,
//   //             new Date(parseInt(reqData.time)),
//   //           ]);
//   //         }
//   //         else if(reqData.type == 'dead' && (tgData.signalType == 'SELL' || tgData.signalType == 'TWO') && logItem?.st == 'EXACT_WAIT' && tgData.autoST == 'Y'){
//   //           // 데드크로스 숏포지션 새로운 진입
//   //           await dbcon.DBCall(`CALL SP_API_PLAY_ST_EXACT_WAIT_UPDATE(?,?,?)`, [
//   //             logItem.id,
//   //             reqData.close,
//   //             'SELL',
//   //           ]);

//   //           await dbcon.DBCall(`CALL SP_LOG_ADD(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)`, [
//   //             tgData.uid,
//   //             tgData.id,
//   //             logItem.id,
//   //             reqData.uuid,
//   //             reqData.db_type,
//   //             reqData.type,
//   //             '신호갱신B',
//   //             parseFloat(reqData.close),
//   //             null,
//   //             tgData.bunbong,
//   //             tgData.second1,
//   //             tgData.second2,
//   //             tgData.second3,
//   //             tgData.second4,
//   //             new Date(parseInt(reqData.time)),
//   //           ]);
//   //         }
//   //         else if(reqData.type == 'CANCEL' && logItem?.signalType == 'SELL' && tgData.st == 'START'){
//   //           if(logItem && logItem.st == 'EXACT_WAIT'){
//   //             await dbcon.DBCall(`CALL SP_API_PLAY_ST_CANCEL(?,?,?)`,[logItem.id, tgData.id, tgData.idx-1]);

//   //             await dbcon.DBCall(`CALL SP_LOG_ADD(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)`, [
//   //               tgData.uid,
//   //               tgData.id,
//   //               logItem.id,
//   //               tgData.stoch_id,
//   //               null,
//   //               null,
//   //               '취소B',
//   //               null,
//   //               parseFloat(reqData.close),
//   //               null,
//   //               null,
//   //               null,
//   //               null,
//   //               null,
//   //               null,
//   //           ]);
//   //           }
//   //         }
//   //       }
//   //     }catch(e){
//   //       console.log('api/hook ERROR :: ', e)
//   //     }
//   //   }
//   // }
  
//   return res.send(true);
// });
router.post('/api/hook', async function(req, res){
  const reg_ex = /[^0-9]/g;
  const reqData = req.body;

  // console.log(reqData);
  // ATF
  if(reqData && reqData?.db_type ){
    dbcon.DBCall(`CALL SP_LOG_ALERT_ADD(?,?,?,?,?,?)`, [
      reqData.uuid,
      reqData.db_type,
      reqData.type,
      reqData.symbol,
      reqData.close,
      new Date(parseInt(reqData.time)),
    ]);

    seon.enterCoin(reqData);
  }else if(reqData && reqData.db_type == 'ATF' || reqData.db_type == 'UT'){
    // await seon.enterATF_UT(reqData);
  }else{
    return res.send(false);
  }
  
  
  // else if(reqData && (reqData.db_type == 'UT' || reqData.db_type == 'ATF')){
  //   await dbcon.DBCall(`CALL SP_LOG_ALERT_ADD3(?,?,?,?)`, [
  //     reqData.db_type,
  //     reqData.type,
  //     reqData.bunbong.replace(reg_ex, ""),
  //     new Date(parseInt(reqData.time)),
  //   ]);
  // }
  
  // if(reqData.db_type == 'ATF'){
  //   seon.ATF_OLD[reqData.bunbong] = seon.ATF_NEW[reqData.bunbong]
  //   seon.ATF_NEW[reqData.bunbong] = reqData.type

  //   const reqBun = reqData.bunbong.replace(reg_ex, "");
  //   const tgDataList = await dbcon.DBCall(`CALL SP_API_PLAY_Y_GET(?)`,[reqBun]);

  //   for(let i=0;i<tgDataList.length;i++){
  //     try{
  //       const tgData = tgDataList[i];
  //       const bunbong = tgData.bunbong.split('_')[1]
  //       // console.log(`${tgData.type} ${bunbong} ATF :: ${seon.ATF_NEW[bunbong+'m']}, UT :: ${seon.UT_NEW[bunbong+'m']}`);
  //       let stop_st = false

  //       if(tgData.type == 'A'){
  //         if((tgData.t_ST == 'Y' && tgData.t_autoST == 'Y') || (tgData.t_ST == 'N' && tgData.t_autoST == 'Y')){
  //           if(seon.ATF_OLD[bunbong+'m'] == 'SHORT' && seon.ATF_NEW[bunbong+'m'] == 'LONG' && tgData.r_signalType == 'SELL'){
  //             stop_st = true;
  //           }else if(seon.ATF_OLD[bunbong+'m'] == 'LONG' && seon.ATF_NEW[bunbong+'m'] == 'SHORT' && tgData.r_signalType == 'BUY'){
  //             stop_st = true;
  //           }  
  //         }
  //       }

  //       if(stop_st){
  //         await dbcon.DBCall(`CALL SP_LIVE_PLAY_SET_ST(?,?,?)`, [
  //           tgData.id,
  //           'START',
  //           'FORCING_WAIT',
  //         ]);

  //         await dbcon.DBCall(`CALL SP_LIVE_EVENT_LOG_ADD(?,?,?,?,?,?,?,?,?,?,?,?)`, [
  //           tgData.uid,
  //           tgData.id,
  //           tgData.r_tid,
  //           null,
  //           '청산대기_ATF',
  //           tgData.st,
  //           'START',
  //           tgData.status,
  //           'FORCING_WAIT',
  //           tgData.r_signalType,
  //           null,
  //           null,
  //         ]);
  //       }


  //     }catch(e){
  //       console.log('api/hook ERROR :: ', e)
  //     }
  //   }
  // }

  
  return res.send(true);
});

router.get('/api/seon', async function(req, res){
  // console.log(req.query);

  let memberList = await dbcon.DBCall(`CALL SP_A_MEMBER_ALL_GET()`);

  for(let i=0;i<memberList.length;i++){
    const isId = memberList[i].id;

    if(isId == 1){
      continue;
    }

    await dbcon.DBCall(`CALL SP_LIVE_PLAY_ADD(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)`, [isId,'A_1',1,옵1,옵2,옵3,진입,취소,일차익절,손절,손절취소ST,손절취소,b2차익절,추세주문ST,손절익절취소,c2차익절,추세추격,'BUY', 'Y', 'Y',1, 자동청산ST, 추격ST, 즉시진입ST, 'A','N','N']);
    await dbcon.DBCall(`CALL SP_LIVE_PLAY_ADD(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)`, [isId,'A_1',1,옵1,옵2,옵3,진입,취소,일차익절,손절,손절취소ST,손절취소,b2차익절,추세주문ST,손절익절취소,c2차익절,추세추격,'SELL','Y', 'Y',1, 자동청산ST, 추격ST, 즉시진입ST, 'A','N','N']);
    await dbcon.DBCall(`CALL SP_LIVE_PLAY_ADD(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)`, [isId,'A_3',1,옵1,옵2,옵3,진입,취소,일차익절,손절,손절취소ST,손절취소,b2차익절,추세주문ST,손절익절취소,c2차익절,추세추격,'BUY', 'Y', 'Y',1, 자동청산ST, 추격ST, 즉시진입ST, 'A','N','N']);
    await dbcon.DBCall(`CALL SP_LIVE_PLAY_ADD(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)`, [isId,'A_3',1,옵1,옵2,옵3,진입,취소,일차익절,손절,손절취소ST,손절취소,b2차익절,추세주문ST,손절익절취소,c2차익절,추세추격,'SELL','Y', 'Y',1, 자동청산ST, 추격ST, 즉시진입ST, 'A','N','N']);
    await dbcon.DBCall(`CALL SP_LIVE_PLAY_ADD(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)`, [isId,'A_5',1,옵1,옵2,옵3,진입,취소,일차익절,손절,손절취소ST,손절취소,b2차익절,추세주문ST,손절익절취소,c2차익절,추세추격,'BUY', 'Y', 'Y',1, 자동청산ST, 추격ST, 즉시진입ST, 'A','N','N']);
    await dbcon.DBCall(`CALL SP_LIVE_PLAY_ADD(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)`, [isId,'A_5',1,옵1,옵2,옵3,진입,취소,일차익절,손절,손절취소ST,손절취소,b2차익절,추세주문ST,손절익절취소,c2차익절,추세추격,'SELL','Y', 'Y',1, 자동청산ST, 추격ST, 즉시진입ST, 'A','N','N']);
  }

  let stochList = await dbcon.DBCall(`CALL SP_WS_PLAY_STOCH_GET()`);

  for(let i=0;i<stochList.length;i++){
    const stoch = stochList[i]

    const type = stoch.bunbong.split('_')[0]
    const bunbong = stoch.bunbong.split('_')[1]

    const tg = await dbcon.DBOneCall(`CALL SP_WS_PLAY_LIST_GET(?,?,?,?)`,[bunbong, stoch.second2, stoch.second3, stoch.second4]);
    let stoch_id = null

    if(!tg){
      do{
        const uuid = seon.randomString(15);
        const uuidCK = await dbcon.DBOneCall(`CALL SP_API_STOCH_ID_GET(?)`,[uuid]);
  
        if(!uuidCK){
          stoch_id = uuid
        }
  
        await dbcon.DBCall(`CALL SP_API_STOCH_ADD(?,?,?,?,?)`,[uuid, bunbong, stoch.second2, stoch.second3, stoch.second4]);
  
      }while(!stoch_id)
    }else{
      stoch_id = tg.uuid
    }

    await dbcon.DBCall(`CALL SP_API_PLAY_STOCH_ALL_EDIT(?,?,?,?,?)`,[stoch_id, stoch.bunbong, stoch.second2, stoch.second3, stoch.second4]);
  }
  



  // const stochAllList = await dbcon.DBCall(`CALL SP_WS_PLAY_STOCH_ALL_GET()`);

  // for(let i=0;i<stochAllList.length;i++){
  //   try{
  //     const uuid = stochAllList[i].uuid
    
  //     await dbcon.DBCall(`CALL SP_API_COOL_ADD(?)`,[uuid]);
  //   }catch(e){
  //     // console.log(e);
  //   }
  // }
  

  return res.send(true);

});
router.get('/api/seon/one', async function(req, res){
  // console.log(req.query);
  
  const isId = req.query.id;

  if(!isId){
    console.log('!!');
    return res.send(true);
  }

  await dbcon.DBCall(`CALL SP_LIVE_PLAY_ADD(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)`, [isId,'A_1',1,옵1,옵2,옵3,진입,취소,일차익절,손절,손절취소ST,손절취소,b2차익절,추세주문ST,손절익절취소,c2차익절,추세추격,'BUY', 'Y', 'Y',1, 자동청산ST, 추격ST, 즉시진입ST, 'A','N','N']);
  await dbcon.DBCall(`CALL SP_LIVE_PLAY_ADD(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)`, [isId,'A_1',1,옵1,옵2,옵3,진입,취소,일차익절,손절,손절취소ST,손절취소,b2차익절,추세주문ST,손절익절취소,c2차익절,추세추격,'SELL','Y', 'Y',1, 자동청산ST, 추격ST, 즉시진입ST, 'A','N','N']);
  await dbcon.DBCall(`CALL SP_LIVE_PLAY_ADD(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)`, [isId,'A_3',1,옵1,옵2,옵3,진입,취소,일차익절,손절,손절취소ST,손절취소,b2차익절,추세주문ST,손절익절취소,c2차익절,추세추격,'BUY', 'Y', 'Y',1, 자동청산ST, 추격ST, 즉시진입ST, 'A','N','N']);
  await dbcon.DBCall(`CALL SP_LIVE_PLAY_ADD(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)`, [isId,'A_3',1,옵1,옵2,옵3,진입,취소,일차익절,손절,손절취소ST,손절취소,b2차익절,추세주문ST,손절익절취소,c2차익절,추세추격,'SELL','Y', 'Y',1, 자동청산ST, 추격ST, 즉시진입ST, 'A','N','N']);
  await dbcon.DBCall(`CALL SP_LIVE_PLAY_ADD(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)`, [isId,'A_5',1,옵1,옵2,옵3,진입,취소,일차익절,손절,손절취소ST,손절취소,b2차익절,추세주문ST,손절익절취소,c2차익절,추세추격,'BUY', 'Y', 'Y',1, 자동청산ST, 추격ST, 즉시진입ST, 'A','N','N']);
  await dbcon.DBCall(`CALL SP_LIVE_PLAY_ADD(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)`, [isId,'A_5',1,옵1,옵2,옵3,진입,취소,일차익절,손절,손절취소ST,손절취소,b2차익절,추세주문ST,손절익절취소,c2차익절,추세추격,'SELL','Y', 'Y',1, 자동청산ST, 추격ST, 즉시진입ST, 'A','N','N']);

  let stochList = await dbcon.DBCall(`CALL SP_WS_PLAY_STOCH_GET()`);

  for(let i=0;i<stochList.length;i++){
    const stoch = stochList[i]

    const type = stoch.bunbong.split('_')[0]
    const bunbong = stoch.bunbong.split('_')[1]

    const tg = await dbcon.DBOneCall(`CALL SP_WS_PLAY_LIST_GET(?,?,?,?)`,[bunbong, stoch.second2, stoch.second3, stoch.second4]);
    let stoch_id = null

    if(!tg){
      do{
        const uuid = seon.randomString(15);
        const uuidCK = await dbcon.DBOneCall(`CALL SP_API_STOCH_ID_GET(?)`,[uuid]);
  
        if(!uuidCK){
          stoch_id = uuid
        }
  
        await dbcon.DBCall(`CALL SP_API_STOCH_ADD(?,?,?,?,?)`,[uuid, bunbong, stoch.second2, stoch.second3, stoch.second4]);
  
      }while(!stoch_id)
    }else{
      stoch_id = tg.uuid
    }

    await dbcon.DBCall(`CALL SP_API_PLAY_STOCH_ALL_EDIT(?,?,?,?,?)`,[stoch_id, stoch.bunbong, stoch.second2, stoch.second3, stoch.second4]);
  }
  


  return res.send(true);
});






// validateRegister
router.post('/reg', async function(req, res){
  try{
    req.body.mobile = '01000000000'

    const {userID} = await dbcon.DBOneCall(`CALL SP_U_USER_ADD(?,?,?,?,?,?)`,[
      req.body.memberid,
      req.body.username,
      req.body.mobile,
      req.body.password,
      req.body.email,
      req.body.recom,
    ]);
  
  
    const isId = userID;
    // await dbcon.DBCall(`CALL SP_A_PLAY_ADD(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)`, [isId,1,'A_1',1,옵1,옵2,옵3,진입,취소,일차익절,손절,손절취소ST,손절취소,b2차익절,추세주문ST,손절익절취소,c2차익절,추세추격,'BUY', 'Y', 'Y',1, 자동청산ST, 추격ST, 즉시진입ST, 'A','N','N']);
    // await dbcon.DBCall(`CALL SP_A_PLAY_ADD(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)`, [isId,1,'A_1',1,옵1,옵2,옵3,진입,취소,일차익절,손절,손절취소ST,손절취소,b2차익절,추세주문ST,손절익절취소,c2차익절,추세추격,'SELL','Y', 'Y',1, 자동청산ST, 추격ST, 즉시진입ST, 'A','N','N']);
    // await dbcon.DBCall(`CALL SP_A_PLAY_ADD(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)`, [isId,1,'A_3',1,옵1,옵2,옵3,진입,취소,일차익절,손절,손절취소ST,손절취소,b2차익절,추세주문ST,손절익절취소,c2차익절,추세추격,'BUY', 'Y', 'Y',1, 자동청산ST, 추격ST, 즉시진입ST, 'A','N','N']);
    // await dbcon.DBCall(`CALL SP_A_PLAY_ADD(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)`, [isId,1,'A_3',1,옵1,옵2,옵3,진입,취소,일차익절,손절,손절취소ST,손절취소,b2차익절,추세주문ST,손절익절취소,c2차익절,추세추격,'SELL','Y', 'Y',1, 자동청산ST, 추격ST, 즉시진입ST, 'A','N','N']);
    // await dbcon.DBCall(`CALL SP_A_PLAY_ADD(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)`, [isId,1,'A_5',1,옵1,옵2,옵3,진입,취소,일차익절,손절,손절취소ST,손절취소,b2차익절,추세주문ST,손절익절취소,c2차익절,추세추격,'BUY', 'Y', 'Y',1, 자동청산ST, 추격ST, 즉시진입ST, 'A','N','N']);
    // await dbcon.DBCall(`CALL SP_A_PLAY_ADD(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)`, [isId,1,'A_5',1,옵1,옵2,옵3,진입,취소,일차익절,손절,손절취소ST,손절취소,b2차익절,추세주문ST,손절익절취소,c2차익절,추세추격,'SELL','Y', 'Y',1, 자동청산ST, 추격ST, 즉시진입ST, 'A','N','N']);

    // await dbcon.DBCall(`CALL SP_LIVE_PLAY_ADD(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)`, [isId,'A_1',1,옵1,옵2,옵3,진입,취소,일차익절,손절,손절취소ST,손절취소,b2차익절,추세주문ST,손절익절취소,c2차익절,추세추격,'BUY', 'Y', 'Y',1, 자동청산ST, 추격ST, 즉시진입ST, 'A','N','N']);
    // await dbcon.DBCall(`CALL SP_LIVE_PLAY_ADD(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)`, [isId,'A_1',1,옵1,옵2,옵3,진입,취소,일차익절,손절,손절취소ST,손절취소,b2차익절,추세주문ST,손절익절취소,c2차익절,추세추격,'SELL','Y', 'Y',1, 자동청산ST, 추격ST, 즉시진입ST, 'A','N','N']);
    // await dbcon.DBCall(`CALL SP_LIVE_PLAY_ADD(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)`, [isId,'A_3',1,옵1,옵2,옵3,진입,취소,일차익절,손절,손절취소ST,손절취소,b2차익절,추세주문ST,손절익절취소,c2차익절,추세추격,'BUY', 'Y', 'Y',1, 자동청산ST, 추격ST, 즉시진입ST, 'A','N','N']);
    // await dbcon.DBCall(`CALL SP_LIVE_PLAY_ADD(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)`, [isId,'A_3',1,옵1,옵2,옵3,진입,취소,일차익절,손절,손절취소ST,손절취소,b2차익절,추세주문ST,손절익절취소,c2차익절,추세추격,'SELL','Y', 'Y',1, 자동청산ST, 추격ST, 즉시진입ST, 'A','N','N']);
    // await dbcon.DBCall(`CALL SP_LIVE_PLAY_ADD(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)`, [isId,'A_5',1,옵1,옵2,옵3,진입,취소,일차익절,손절,손절취소ST,손절취소,b2차익절,추세주문ST,손절익절취소,c2차익절,추세추격,'BUY', 'Y', 'Y',1, 자동청산ST, 추격ST, 즉시진입ST, 'A','N','N']);
    // await dbcon.DBCall(`CALL SP_LIVE_PLAY_ADD(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)`, [isId,'A_5',1,옵1,옵2,옵3,진입,취소,일차익절,손절,손절취소ST,손절취소,b2차익절,추세주문ST,손절익절취소,c2차익절,추세추격,'SELL','Y', 'Y',1, 자동청산ST, 추격ST, 즉시진입ST, 'A','N','N']);
  
    // let stochList = await dbcon.DBCall(`CALL SP_WS_PLAY_STOCH_GET()`);
  
    // for(let i=0;i<stochList.length;i++){
    //   const stoch = stochList[i]
  
    //   const type = stoch.bunbong.split('_')[0]
    //   const bunbong = stoch.bunbong.split('_')[1]
  
    //   const tg = await dbcon.DBOneCall(`CALL SP_WS_PLAY_LIST_GET(?,?,?,?)`,[bunbong, stoch.second2, stoch.second3, stoch.second4]);
    //   let stoch_id = null
    //   stoch_id = tg.uuid
  
    //   await dbcon.DBCall(`CALL SP_API_PLAY_STOCH_ONE_EDIT(?,?,?,?,?,?)`,[isId, stoch_id, stoch.bunbong, stoch.second2, stoch.second3, stoch.second4]);
    // }


    return res.status(200).json({
      status: 200,
    });

  }catch(e){
    return res.status(500).json({ errors: [{
        location: "body",
        msg: "알수없는 오류 /reg",
        param: "body",
        value: "body",
      }] 
    });
  }
});

router.post('/reg1', validateRegister1, async function(req, res){
  return res.status(200).json({
    status: 200,
  });
});
router.post('/reg2', validateRegister2, async function(req, res){
  return res.status(200).json({
    status: 200,
  });
});
router.post('/reg3', async function(req, res){
  return res.status(200).json({
    status: 200,
  });
});
router.post('/code', async function(req, res){
  const recom = req.body.recom;


  const codeList = [
    'A6561',
    'B6379',
    'C6541',
    'D7776',
    'E3927',
    'A8889',
    'A2822',
    'A5557',
    'B4780',
    'B0675',
    'C1491',
    'R0555',

    'DRG92',
    'DARK1',
    'LQ888',
  ]

  for(let i=0;i<codeList.length;i++){ 
    if(codeList[i] == recom.toUpperCase()){
      return res.status(200).json({
        status: 200,
      });
    }
  }

  return res.status(400).json({
    status: 400,
    errors: [{param:'recom', msg:'유효하지 않은 추천인 코드입니다'}]
  });
});


router.post('/api/seon/json', async function(req, res){
  const reData = req.body;

  const rows = [];

  if(!reData){
    return false;
  }

  try{
    dbcon.DBCall(`CALL SP_TEST_LOG(?)`,[JSON.stringify(reData)]);
  }catch(e){

  }

  try{
    for(let i=0;i<reData.rows.length;i++){
      // 해당 익절의 (매수)승률:lhr,연율화수익률:lcagr, PNL:lpnl (매도) 승률: shr,연율화수익률 : scagr ,PNL : spnl
      const v_ = reData.rows[i].v.split('/');
      const v = {
          tp: reData.rows[i].tp,
          lhr: parseFloat(v_[0]),
          lcagr: parseFloat(v_[1]),
          lpnl: parseFloat(v_[2]),
          shr: parseFloat(v_[3]),
          scagr: parseFloat(v_[4]),
          spnl: parseFloat(v_[5]),
      }

      rows.push(v);
    }

    reData.rows = rows;

    console.log(`
      ---SP_CAGR_STATS_ADD---
      symbol: ${reData.symbol}
      signal: ${reData.signal}
      candle_min: ${reData.candle_min}
      first_signal_date: ${reData.first_signal_date}
      lookahead_min: ${reData.lookahead_min}
      buy_count: ${reData.buy_count}
      sell_count: ${reData.sell_count}
      best_metric: ${reData.best_metric}
    `)

    dbcon.DBOneCall(`CALL SP_CAGR_STATS_ADD(?,?,?,?,?,?,?,?)`, [
      reData.symbol.replace('.P', ''),
      reData.signal,
      reData.candle_min,
      reData.first_signal_date,
      reData.lookahead_min,
      reData.buy_count,
      reData.sell_count,
      reData.best_metric,
    ]).then(({id})=>{
      Object.entries(reData.best_windows).forEach(([period, types]) => {
        Object.entries(types).forEach(([type, metrics]) => {
            // console.log(`[${type}] 수익률(PNL): ${metrics.tp}, CAGR: ${metrics.lhr} ${metrics.shr} ${metrics.pnl} ${metrics.cagr}`);

            dbcon.DBCall(`CALL SP_CAGR_BEST_ADD(?,?,?,?,?,?,?,?)`, [
              id,
              period,
              type,
              isEmpty(metrics.tp),
              isEmpty(metrics.lhr),
              isEmpty(metrics.shr),
              isEmpty(metrics.pnl),
              isEmpty(metrics.cagr),
            ])
            .then((x)=>{
              if(x == false){
                console.log(`ERR: [ADD] ${reData.symbol} ${reData.signal} ${reData.candle_min} --------`);
                // console.log(reData);
                console.log(
                  id,
                  period,
                  type,
                  metrics.tp,
                  metrics.lhr,
                  metrics.shr,
                  metrics.pnl,
                  metrics.cagr
                );
                console.log('-------------');
              }
            })
        });
      });

      for(let i=0;i<reData.rows.length;i++){
        const row = reData.rows[i];

        dbcon.DBCall(`CALL SP_CAGR_ROWS_ADD(?,?,?,?,?,?)`, [
          id,
          isEmpty(row.tp),
          'BUY',
          isEmpty(row.lhr),
          isEmpty(row.lcagr),
          isEmpty(row.lpnl),
        ])
        .then((x)=>{
          if(x == false){
            console.log(`ERR: [ADD] ${reData.symbol} ${reData.signal} ${reData.candle_min} --------`);
            // console.log(reData);
            console.log(
              id,
              row.tp,
              'BUY',
              row.lhr,
              row.lcagr,
              row.lpnl,
            );
            console.log('-------------');
          }
        });

        dbcon.DBCall(`CALL SP_CAGR_ROWS_ADD(?,?,?,?,?,?)`, [
          id,
          isEmpty(row.tp),
          'SELL',
          isEmpty(row.shr),
          isEmpty(row.scagr),
          isEmpty(row.spnl),
        ])
        .then((x)=>{
          if(x == false){
            console.log(`ERR: [ADD] ${reData.symbol} ${reData.signal} ${reData.candle_min} --------`);
            // console.log(reData);
            console.log(
              id,
              row.tp,
              'SELL',
              row.shr,
              row.scagr,
              row.spnl,
            );
            console.log('-------------');
          }
        });
        
      }
    });

  }catch(e){ 
    console.log('EEEEE api/seon/json');
    console.log(e);
    // console.log(reData);
    console.log('--------------------');

  }


  
  return res.send(true);
});


// const ttttt = () => {
//   const reData = {
//       signal: "K2",
//       candle_min: 1,
//       first_signal_date: "2024-11-01",
//       lookahead_min: 500,
//       buy_count: 123,
//       sell_count: 118,
//       best_metric: "CAGR",
//       best_windows: {
//           "ALL": {
//               "combined": { "tp": 0.012, "lhr": 0.5342, "shr": 0.4981, "pnl": 0.2841, "cagr": 0.4123 },
//               "long":     { "tp": 0.010, "lhr": 0.5520, "shr": null,   "pnl": 0.1732, "cagr": 0.3880 },
//               "short":    { "tp": 0.014, "lhr": null,   "shr": 0.5050, "pnl": 0.1109, "cagr": 0.3561 }
//           },
//           "1m": {
//               "combined": { "tp": 0.008, "lhr": 0.6000, "shr": 0.4500, "pnl": 0.0420, "cagr": 0.2100 },
//               "long":     { "tp": 0.008, "lhr": 0.6667, "shr": null,   "pnl": 0.0310, "cagr": 0.1900 },
//               "short":    { "tp": 0.006, "lhr": null,   "shr": 0.4000, "pnl": 0.0110, "cagr": 0.1200 }
//           },
//           "2m": {
//               "combined": { "tp": 0.012, "lhr": 0.5400, "shr": 0.5000, "pnl": 0.1400, "cagr": 0.3300 },
//               "long":     { "tp": 0.012, "lhr": 0.5500, "shr": null,   "pnl": 0.0900, "cagr": 0.3100 },
//               "short":    { "tp": 0.010, "lhr": null,   "shr": 0.4900, "pnl": 0.0500, "cagr": 0.2700 }
//           },
//           "1y": {
//               "combined": { "tp": 0.012, "lhr": 0.5300, "shr": 0.5100, "pnl": 0.2200, "cagr": 0.3900 },
//               "long":     { "tp": 0.010, "lhr": 0.5400, "shr": null,   "pnl": 0.1300, "cagr": 0.3600 },
//               "short":    { "tp": 0.014, "lhr": null,   "shr": 0.5200, "pnl": 0.0900, "cagr": 0.3400 }
//           },
//           "12m": {
//               "combined": { "tp": 0.012, "lhr": 0.5300, "shr": 0.5100, "pnl": 0.2200, "cagr": 0.3900 },
//               "long":     { "tp": 0.010, "lhr": 0.5400, "shr": null,   "pnl": 0.1300, "cagr": 0.3600 },
//               "short":    { "tp": 0.014, "lhr": null,   "shr": 0.5200, "pnl": 0.0900, "cagr": 0.3400 } ,
//           }
//       },
//       rows: [
//           { tp: 0.002, v: '0.7342/-0.9991/-0.1993/0.9231/16.2117/0.0911' },
//           { tp: 0.003, v: '0.6709/-0.9984/-0.1829/0.8352/15.9881/0.0906' },
//           { tp: 0.004, v: '0.6203/-0.9985/-0.185/0.7802/64.2666/0.1366' },
//           { tp: 0.005, v: '0.5823/-0.9988/-0.1902/0.7473/478.1264/0.2081' },
//           { tp: 0.006, v: '0.5316/-0.9998/-0.2313/0.6593/808.6949/0.2277' },
//           { tp: 0.007, v: '0.4684/-0.9999/-0.2618/0.6374/3218.4584/0.2807' },
//           { tp: 0.008, v: '0.4304/-0.9999/-0.2539/0.5714/2330.223/0.2681' },
//           { tp: 0.009, v: '0.3924/-0.9999/-0.2533/0.5055/1730.574/0.2566' },
//           { tp: 0.01, v: '0.3418/-0.9999/-0.2595/0.4615/2145.0734/0.2649' },
//           { tp: 0.012, v: '0.2785/-0.9999/-0.2569/0.4286/4002.7643/0.2893' },
//           { tp: 0.014, v: '0.2278/-0.9999/-0.2593/0.3956/18467.8627/0.3511' },
//           { tp: 0.016, v: '0.1519/-1/-0.3032/0.3736/94454.8733/0.4204' },
//           { tp: 0.018, v: '0.1266/-1/-0.2944/0.3297/205682.7648/0.4547' },
//           { tp: 0.02, v: '0.1013/-1/-0.3019/0.2967/418770.8032/0.4867' },
//           { tp: 0.03, v: '0.0506/-1/-0.3029/0.2088/4300238.7062/0.5966' },
//           { tp: 0.04, v: '0.038/-1/-0.2889/0.1538/154676242.1213/0.7818' },
//           { tp: 0.05, v: '0.038/-1/-0.2682/0.1319/403970203.2506/0.835' },
//           { tp: 0.06, v: '0.0127/-1/-0.2718/0.0769/567587603.5569/0.8542' },
//           { tp: 0.07, v: '0/-1/-0.276/0.022/95320858.3097/0.7556' },
//           { tp: 0.08, v: '0/-1/-0.276/0.022/174964505.1797/0.7886' },
//           { tp: 0.09, v: '0/-1/-0.276/0/16976055.3602/0.6652' },
//           { tp: 0.1, v: '0/-1/-0.276/0/16976055.3602/0.6652' },
//           { tp: 0.12, v: '0/-1/-0.276/0/16976055.3602/0.6652' },
//           { tp: 0.14, v: '0/-1/-0.276/0/16976055.3602/0.6652' },
//           { tp: 0.16, v: '0/-1/-0.276/0/16976055.3602/0.6652' },
//           { tp: 0.18, v: '0/-1/-0.276/0/16976055.3602/0.6652' },
//           { tp: 0.2, v: '0/-1/-0.276/0/16976055.3602/0.6652' }
//       ]

//   }

//   const rows = [];

//   for(let i=0;i<reData.rows.length;i++){
//       // 해당 익절의 (매수)승률:lhr,연율화수익률:lcagr, PNL:lpnl (매도) 승률: shr,연율화수익률 : scagr ,PNL : spnl
//       const v_ = reData.rows[i].v.split('/');
//       const v = {
//           tp: reData.rows[i].tp,
//           lhr: parseFloat(v_[0]),
//           lcagr: parseFloat(v_[1]),
//           lpnl: parseFloat(v_[2]),
//           shr: parseFloat(v_[3]),
//           scagr: parseFloat(v_[4]),
//           spnl: parseFloat(v_[5]),
//       }

//       rows.push(v);
//   }

//   reData.rows = rows;

//   dbcon.DBOneCall(`CALL SP_CAGR_STATS_ADD(?,?,?)`, [reData.symbol,reData.signal,reData.candle_min]).then((x)=>{
//     dbcon.DBOneCall(`CALL SP_CAGR_STATS_ADD(?,?,?,?,?,?,?,?)`, [
//       reData.symbol,
//       reData.signal,
//       reData.candle_min,
//       reData.first_signal_date,
//       reData.lookahead_min,
//       reData.buy_count,
//       reData.sell_count,
//       reData.best_metric,
//     ]).then(({id})=>{
//       console.log(id);
  
//       Object.entries(reData.best_windows).forEach(([period, types]) => {
//         Object.entries(types).forEach(([type, metrics]) => {
//             // console.log(`[${type}] 수익률(PNL): ${metrics.tp}, CAGR: ${metrics.lhr} ${metrics.shr} ${metrics.pnl} ${metrics.cagr}`);
  
//             dbcon.DBCall(`CALL SP_CAGR_BEST_ADD(?,?,?,?,?,?,?,?)`, [
//               id,
//               period,
//               type,
//               metrics.tp,
//               metrics.lhr,
//               metrics.shr,
//               metrics.pnl,
//               metrics.cagr,
//             ])
//         });
//       });
  
//       for(let i=0;i<reData.rows.length;i++){
//         const row = reData.rows[i];
  
//         dbcon.DBCall(`CALL SP_CAGR_ROWS_ADD(?,?,?,?,?,?)`, [
//           id,
//           row.tp,
//           'BUY',
//           row.lhr,
//           row.lcagr,
//           row.lpnl,
//         ])
  
//         dbcon.DBCall(`CALL SP_CAGR_ROWS_ADD(?,?,?,?,?,?)`, [
//           id,
//           row.tp,
//           'SELL',
//           row.shr,
//           row.scagr,
//           row.spnl,
//         ])
//       }
//     });
//   });
  
  



// }

// ttttt();

module.exports = router;