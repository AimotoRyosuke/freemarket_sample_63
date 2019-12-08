$ ->
  $('#address_zip_code').jpostal({
    postcode : [
      '#address_zip_code'
    ],
    address : {
      '#address_prefecture_id  ' : '%3',
      '#address_city'            : '%4',
      '#address_address'         : '%5',
    }
  })