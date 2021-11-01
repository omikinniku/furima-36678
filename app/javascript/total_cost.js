function cost (){
  const itemPrice = document.getElementById("item-price");
  itemPrice.addEventListener("keyup", () => {
    const price = itemPrice.value;
    // console.log("イベント発火");

    // Math.〇〇とすることで求めている数字を引き出したり、変換することができる
    // floor は(1.95)= 1、ceilは(.95)= 1
    const addTaxPrice = document.getElementById("add-tax-price");
    addTaxPrice.innerHTML = (Math.floor(price * 0.1));
    // console.log("イベント発火1");

    const profit = document.getElementById("profit");
    const value_result = price * 0.1
    // console.log("イベント発火2");
    profit.innerHTML = (Math.ceil(price - value_result));
    // console.log("イベント発火3");
  });
 };
 
 window.addEventListener('load', cost);
  