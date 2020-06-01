#json.list @List, :id, :name, :quantity
#json.product @product, :id, :name
#json.quantity @association, :quantity

#json.info do
   # json.list @List.name
    #json.product_id @product.id
    #json.name @product.name
    #json.quantity @association.quantity
 # end
 @message= json.info @List do |list|
    json.id list.id
    json.name list.name
    json.products list.products do |product|
    json.product_id product.id
    json.product_name product.name
    @help= @association= ListProduct.find_by(
        list_id: list.id,
        product_id: product.id)
    json.product_quantity @help.quantity
    end
end