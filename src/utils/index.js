import moment from "moment";
import "moment/locale/es";

export const decimalsWithCommas = decimal => {
    var num = Number(decimal);
    return num.toFixed(2).replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,');
}

export const validaDate = date => {
    return date === "0001-01-01T00:00:00" ? '- - -' : moment(date).format("D MMMM YYYY, h:mm:ss a");
};

export function UrlsApi() {
    return {
        URLAPI_CLIENTES: "https://localhost:7066/api/Clientes/",
        URLAPI_PAGOS: "https://localhost:7066/api/Pagos/"
    }
}