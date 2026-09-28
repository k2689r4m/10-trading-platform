var exports = module.exports = {};
const SYMBOL = 'NQM25';

exports.offerho = 0;
exports.bidho = 0;

exports.price = {}

exports.cool = {
    'NEW_START': 10,
    'NEW_RUN': 10,
    // 'NEW_RUN2': 300,
    'FAIL_RUN': 15,
    'RUN': 60,
    'NEW_CLOSE': 10,
    'CLOSE': 10,

    'ERROR': 300,
}

exports.getPrice = (symbol) => {

    if(exports.price[symbol]){
        return {
            symbol: symbol,
            bestBid: parseFloat(exports.price[symbol].bestBid),
            bestBidQty: exports.price[symbol].bestBidQty,
            bestAsk: parseFloat(exports.price[symbol].bestAsk),
            bestAskQty: exports.price[symbol].bestAskQty,
            st: true,
        }
    }else{
        return {
            symbol: symbol,
            bestBid: 0,
            bestBidQty: 0,
            bestAsk: 0,
            bestAskQty: 0,
            st: false,
        }
    }
}

exports.usersData = {}



exports.orderList = []


exports.runPID = [];

exports.delRunPID = (pid) => {
    const index = exports.runPID.indexOf(pid);
    if (index !== -1) {
        exports.runPID.splice(index, 1);
    }
}