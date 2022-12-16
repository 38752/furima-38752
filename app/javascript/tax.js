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

  document.getElementById("add-tax-price").textContent = `${tax}`;
  document.getElementById("profit").textContent = `${profit}`;
};

function calcTaxParent (){
  const priceForm = document.getElementById("item-price");
  priceForm.addEventListener('keyup', calcTaxChild);
};

window.addEventListener('load', calcTaxChild);
window.addEventListener('load', calcTaxParent);