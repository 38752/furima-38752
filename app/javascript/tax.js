function zenkakuToHankaku(str) {
  return str.replace(/[０-９]/g, function(s) {
      return String.fromCharCode(s.charCodeAt(0) - 0xFEE0);
  });
};

function calcTaxChild (){
  const price = zenkakuToHankaku(document.getElementById("item-price").value);
  const taxRate = 1 / 10;
  const tax = Math.floor(price * taxRate).toLocaleString();
  const profit = Math.floor(price * (1 - taxRate)).toLocaleString();
  // ↑『実装条件』には「販売手数料と販売利益は、小数点以下を切り捨てて表示すること。」とありますが、
  // お手本アプリでは、販売手数料を小数点以下切り捨て、販売利益を小数点以下切り上げで表示しているようです。
  // 変更が容易であり、大きな差はないと思われますので、『実装条件』に準拠し記述しています。

  document.getElementById("add-tax-price").textContent = `${tax}`;
  document.getElementById("profit").textContent = `${profit}`;
};

function calcTaxParent (){
  const priceForm = document.getElementById("item-price");
  priceForm.addEventListener('keyup', calcTaxChild);
};

window.addEventListener('load', calcTaxChild);
window.addEventListener('load', calcTaxParent);