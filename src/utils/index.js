function decimalsWithCommas(decimal) {
    var num = Number(decimal);
    return num.toFixed(2).replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,');
}

export default decimalsWithCommas