

json.info @all do |list|  
    json.id list.id
    json.name list.name
    json.creation list.created_at
    json.users list.users do |user|
      json.user_id user.id
      json.username user.username
      end
    json.products list.products do |product|
    json.product_id product.id
    json.product_name product.name
    @help= @association= ListProduct.find_by(
        list_id: list.id,
        product_id: product.id)
    json.product_quantity @help.quantity
    json.product_descripcion @help.description
     json.product_status @help.checked
    end
end
