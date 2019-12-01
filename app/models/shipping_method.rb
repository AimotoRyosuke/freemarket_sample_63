class ShippingMethod < ActiveHash::Base
  self.data = [
      {id: 1, name: "らくらくメルカリ便"}, {id: 2, name: "ゆうゆうメルカリ便"}, {id: 3, name: "大型らくらくメルカリ便"},
      {id: 4, name: "未定"}, {id: 5, name: "ゆうメール"}, {id: 6, name: "レターパック"},
      {id: 7, name: "普通郵便(定形、定形外)"}, {id: 8, name: "クロネコヤマト"}, {id: 9, name: "ゆうパック"},
      {id: 10, name: "クリックポスト"}, {id: 11, name: "ゆうパケット"}
  ]
end