import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.initializeCartNotExists();
    const count = this.setCartCount();

    const itemCountElement = document.querySelector("#dropdown-item-count");
    const itemCountBadgeElement = document.querySelector("#dropdown-item-count-badge");
    const subtotalElement = document.querySelector("#dropdown-subtotal");

    const cartPage = document.querySelector("#cart-table-body");

    const subtotal = this.calculateSubtotal();

    itemCountElement.innerHTML = count + " Items";
    itemCountBadgeElement.innerHTML = count;
    subtotalElement.innerHTML = "Subtotal: ₺" + subtotal;

    if (cartPage !== null) {
      const cart = this.fetchCartData();

      const cartPageSubtotal = document.querySelector("#cart-page-subtotal");
      let cartPageProductInputs = document.querySelector("#cart-page-products-input");
      let cartPageAmountInputs = document.querySelector("#cart-page-amounts-input");

      cartPageSubtotal.innerHTML =  "₺" + subtotal;
      cart["items"].forEach(item => {
        cartPage.appendChild(this.itemElement(item));

        cartPageProductInputs.value += item.id + ",";
        cartPageAmountInputs.value += item.amount + ",";
      });
    }
  }

  fetchCartData() {
    const cartData = localStorage.getItem("cart");
    return JSON.parse(cartData);
  }

  saveCart(cart) {
    localStorage.setItem("cart",  JSON.stringify(cart));
  }

  addToCart() {
    const element = this.element;
    const amountInput = element.children[0].value;
    const productId = element.children[1].value;
    const name = element.children[2].value;
    const price = element.children[3].value;
    
    const cartItem = this.CartItem(productId, name, amountInput, price);
    const cart = this.addToCartObject(cartItem);
    this.saveCart(cart);
  }

  addToCartObject(cartItem) {
    const cart = this.fetchCartData();

    this.initializeCartNotExists();

    const items = cart['items'];
    let isFound = false;
    let foundIndex = -1;
    items.forEach((item, index) => {
        if (item["id"] === cartItem["id"]) {
            isFound = true;
            foundIndex = index;
        }
    });

    if (isFound) {
        const prevAmount = items[foundIndex]["amount"];
        items[foundIndex]["amount"] = parseInt(prevAmount) + parseInt(cartItem.amount);
        
    }
    else {
        cart.items.push(cartItem);
    }

    return cart;
  }

  removeItemFromCart(event) {
    const cart = this.fetchCartData();
    const items = cart['items'];

    console.log(event.params);

    let foundIndex = -1;
    items.forEach((item, index)=> {
        if (item["id"] === item_id) {
          foundIndex = item_id;
        }
    });

    cart["items"].splice(index, 1);
    this.saveCart(cart);
  }

  calculateSubtotal() {
    const cart = this.fetchCartData();
    let sum = 0;
    cart["items"].forEach(item => {
      sum += parseInt(item["amount"]) * parseFloat(item["price"]);
    });

    return sum;
  }

  clearCart() {
    this.saveCart(this.initialCart());
  }

  setCartCount() {
    const cart = this.fetchCartData();
    return cart["items"].length;
  }

  CartItem(productId, name, amount, price) {
    return {
        "id": productId,
        "name": name,
        "amount": amount,
        "price": price
    }
  }

  initializeCartNotExists() {
    const cart = this.fetchCartData();
    if (cart === null || cart === undefined || cart['items'] === null) {
        this.saveCart(this.initialCart());
    }
  }

  initialCart() {
    return {
        "items": []
    }
  }

  itemElement(item) {
    let tr = document.createElement("tr");

    let tdname = document.createElement("td");
    tdname.innerText = item.name;

    let tdprice = document.createElement("td");
    tdprice.innerText = item.price;

    let tdamount = document.createElement("td");
    tdamount.innerText = item.amount;

    let thactions = document.createElement("th");

    let actionbutton = document.createElement("button");
    actionbutton.setAttribute("data-action", "click->cart#removeItemFromCart");
    actionbutton.setAttribute("data-item-id-param", item.id);
    actionbutton.innerText = "Remove";
    actionbutton.className = "btn btn-ghost btn-xs";

    thactions.appendChild(actionbutton);

    tr.appendChild(tdname);
    tr.appendChild(tdprice);
    tr.appendChild(tdamount);
    tr.appendChild(thactions);

    return tr;
  }

  nameElement(name) {
    const div = document.createElement("div");
    div.className = "font-bold";
    div.innerHTML = name;
  }
}
