const pay = () => {
  Payjp.setPublicKey(process.env.PAYJP_PUBLIC_KEY);
  const submit = document.getElementById("button");
  submit.addEventListener("click", (e) => {
    e.preventDefault();
    // e.preventDefault();で通常のRuby on Railsにおけるフォーム送信処理はキャンセルされている。
    
    // フォームの情報を取得する記述
    const formResult = document.getElementById("charge-form");
    const formData = new FormData(formResult);

    const card = {
      number: formData.get("order_buyer[number]"),
      cvc: formData.get("order_buyer[cvc]"),
      exp_month: formData.get("order_buyer[exp_month]"),
      exp_year: `20${formData.get("order_buyer[exp_year]")}`,
    };
    // フォームの情報を取得する記述

    // カードの情報をトークン化
    // statusはトークンの作成がなされたかを確認できるHTTPステータスコードが入る
    // responseはそのレスポンスの内容が含まれ、response.idでトークンの値を取得
    // HTTPステータスコードが200、すなわちうまく処理が完了したとき、トークンの値を取得
    Payjp.createToken(card, (status, response) => {
      if (status == 200) {
        const token = response.id;
        // HTMLのinput要素にトークンの値を埋め込み、フォームに追加
        const renderDom = document.getElementById("charge-form");
        const tokenObj = `<input value=${token} name='token' type="hidden"> `;
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
      }

      // フォームにあるクレジットカード情報を削除
      document.getElementById("card-number").removeAttribute("name");
      document.getElementById("card-cvc").removeAttribute("name");
      document.getElementById("card-exp-month").removeAttribute("name");
      document.getElementById("card-exp-year").removeAttribute("name");

      // フォームの情報をサーバーサイドに送信
      // 5行目のe.preventDefault();でフォーム送信処理はキャンセルされているため、下記で送信処理を行う
      document.getElementById("charge-form").submit();
    });
  });
};

window.addEventListener("load", pay);