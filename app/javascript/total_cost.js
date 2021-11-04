function cost (){
  const itemPrice = document.getElementById("item-price");
  itemPrice.addEventListener("keyup", () => {
    const price = itemPrice.value;

    // Math.〇〇とすることで求めている数字を引き出したり、変換することができる
    // floor は(1.95)= 1、ceilは(.95)= 1
    const addTaxPrice = document.getElementById("add-tax-price");
    addTaxPrice.innerHTML = (Math.floor(price * 0.1));

    const profit = document.getElementById("profit");
    const value_result = price * 0.1
    profit.innerHTML = (Math.ceil(price - value_result));
  });
 };
 
 window.addEventListener('load', cost);
  